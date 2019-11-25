package cn.exrick.xboot.modules.open.controller;

import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.modules.base.entity.User;
import cn.exrick.xboot.modules.base.service.UserService;
import cn.exrick.xboot.modules.open.entity.Client;
import cn.exrick.xboot.modules.open.service.ClientService;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Slf4j
@Controller
@Api(description = "客户端管理接口")
@RequestMapping("/oauth2")
public class Oauth2Controller {

    @Autowired
    private ClientService clientService;

    @Autowired
    private UserService userService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/authorize", method = RequestMethod.GET)
    @ApiOperation(value = "认证获取code")
    public Result<Object> authorize(@ApiParam("用户名") @RequestParam String username,
                                    @ApiParam("密码") @RequestParam String password,
                                    @ApiParam("客户端id") @RequestParam String clientId,
                                    @ApiParam("成功授权后回调地址") @RequestParam String redirectUri,
                                    @ApiParam("授权类型为code") @RequestParam(required = false, defaultValue = "code") String responseType,
                                    @ApiParam("客户端状态值") @RequestParam String state){

        Client client = clientService.get(clientId);
        if(client==null){
            return ResultUtil.error("客户端clientId不存在");
        }
        User user = userService.findByUsername(username);
        if(user==null){
            return ResultUtil.error("用户名不存在");
        }
        if(!new BCryptPasswordEncoder().matches(password, user.getPassword())){
            return ResultUtil.error("用户密码不正确");
        }
        // 判断回调地址
        if(!client.getRedirectUri().equals(redirectUri)){
            return ResultUtil.error("回调地址redirectUri不正确");
        }
        // 生成code 5分钟内有效
        String code = UUID.randomUUID().toString().replace("-", "");
        // 存入用户信息
        redisTemplate.opsForValue().set("oauthCode:"+clientId, code);
        Map<String, Object> map = new HashMap<>(16);
        map.put("code", code);
        map.put("redirectUri", redirectUri);
        map.put("state", state);
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/token", method = RequestMethod.GET)
    @ApiOperation(value = "获取accessToken令牌")
    public Result<Object> token(@ApiParam("授权类型") @RequestParam String grantType,
                                @ApiParam("客户端id") @RequestParam String clientId,
                                @ApiParam("客户端秘钥") @RequestParam String clientSecret,
                                @ApiParam("认证返回的code") @RequestParam(required = false) String code,
                                @ApiParam("刷新token") @RequestParam String refreshToken,
                                @ApiParam("成功授权后回调地址") @RequestParam(required = false) String redirectUri){

        Client client = clientService.get(clientId);
        if(client==null){
            return ResultUtil.error("客户端clientId不存在");
        }
        // 判断clientSecret
        if(!client.getSecretKey().equals(clientSecret)){
            return ResultUtil.error("clientSecret不正确");
        }
        String username = null;
        if("authorizationCode".equals(grantType)){
            // 判断回调地址
            if(!client.getRedirectUri().equals(redirectUri)){
                return ResultUtil.error("回调地址redirectUri不正确");
            }
            // 判断code 获取用户信息
            username = redisTemplate.opsForValue().get("oauthCode:"+clientId);
            if(StrUtil.isBlank(username)||!username.equals(code)){
                return ResultUtil.error("code已过期或不正确");
            }
        } else if ("refreshToken".equals(grantType)){
            // 从refreshToken中获取用户信息
            username = redisTemplate.opsForValue().get("oauthTokenInfo:"+refreshToken);
            if(StrUtil.isBlank(username)){
                return ResultUtil.error("refreshToken已过期");
            }
        }
        String token = null, refreshTokenParam;
        Long expiresIn = null;
        String tokenKey = "oauthToken:"+clientId+":"+username, refreshKey = "oauthRefreshToken:"+clientId+":"+username;
        if("authorizationCode".equals(grantType)){
            // 生成token模式
            String oldToken = redisTemplate.opsForValue().get(tokenKey);
            String oldRefreshToken = redisTemplate.opsForValue().get(refreshKey);
            if(StrUtil.isNotBlank(oldToken)&&StrUtil.isNotBlank(oldRefreshToken)){
                // 旧token
                token = oldToken;
                refreshTokenParam = oldRefreshToken;
                expiresIn = redisTemplate.getExpire(token, TimeUnit.SECONDS);
            } else {
                // 新生成 30天过期
                String newToken = UUID.randomUUID().toString().replace("-", "");
                String newRefreshToken = UUID.randomUUID().toString().replace("-", "");
                redisTemplate.opsForValue().set(tokenKey, newToken, 30L, TimeUnit.DAYS);
                redisTemplate.opsForValue().set(refreshKey, newRefreshToken, 30L, TimeUnit.DAYS);
                // 新token中存入用户信息
                redisTemplate.opsForValue().set("oauthTokenInfo:"+newToken, username,30L, TimeUnit.DAYS);
                redisTemplate.opsForValue().set("oauthTokenInfo:"+newRefreshToken, username,30L, TimeUnit.DAYS);
                token = newToken;
                refreshTokenParam = newRefreshToken;
                expiresIn = redisTemplate.getExpire(token, TimeUnit.SECONDS);
            }
        } else if("refreshToken".equals(grantType)) {
            // 刷新token模式
            String v = redisTemplate.opsForValue().get(refreshKey);
            if(StrUtil.isBlank(v)||!v.equals(refreshToken)){
                return ResultUtil.error("refreshToken已过期或不正确");
            }
            // 生成新token 30天过期 覆盖旧refreshToken
            String newToken = UUID.randomUUID().toString().replace("-", "");
            String newRefreshToken = UUID.randomUUID().toString().replace("-", "");
            redisTemplate.opsForValue().set(tokenKey, newToken, 30L, TimeUnit.DAYS);
            redisTemplate.opsForValue().set(refreshKey, newRefreshToken, 30L, TimeUnit.DAYS);
            // 新token中存入用户信息
            redisTemplate.opsForValue().set("oauthTokenInfo:"+newToken, username,30L, TimeUnit.DAYS);
            redisTemplate.opsForValue().set("oauthTokenInfo:"+newRefreshToken, username,30L, TimeUnit.DAYS);
            token = newToken;
            refreshTokenParam = newRefreshToken;
            expiresIn = redisTemplate.getExpire(token, TimeUnit.SECONDS);
        } else {
            return ResultUtil.error("授权类型grantType不正确");
        }

        Map<String, Object> map = new HashMap<>(16);
        map.put("accessToken", token);
        map.put("expiresIn", expiresIn);
        map.put("refreshToken", refreshTokenParam);
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/user", method = RequestMethod.GET)
    @ApiOperation(value = "获取用户信息")
    public Result<Object> authorize(@ApiParam("令牌") @RequestParam String accessToken){

        String username = redisTemplate.opsForValue().get(accessToken);
        if(StrUtil.isBlank(accessToken)){
            return ResultUtil.error("accessToken已过期失效");
        }
        User user = userService.findByUsername(username);
        Map<String, Object> map = new HashMap<>(16);
        map.put("username", username);
        map.put("avatar", user.getAvatar());
        map.put("sex", user.getSex());
        return ResultUtil.data(map);
    }
}
