package cn.exrick.xboot.modules.open.controller;

import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.modules.base.entity.User;
import cn.exrick.xboot.modules.base.service.UserService;
import cn.exrick.xboot.modules.open.entity.Client;
import cn.exrick.xboot.modules.open.service.ClientService;
import cn.exrick.xboot.modules.open.vo.Oauth2TokenInfo;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @author Exrick
 */
@Slf4j
@RestController
@Api(description = "OAuth2认证接口")
@RequestMapping("/xboot/oauth2")
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
                                    @ApiParam("客户端id") @RequestParam String client_id,
                                    @ApiParam("成功授权后回调地址") @RequestParam String redirect_uri,
                                    @ApiParam("授权类型为code") @RequestParam(required = false, defaultValue = "code") String response_type,
                                    @ApiParam("客户端状态值") @RequestParam String state){

        Client client = clientService.get(client_id);
        if(client==null){
            return ResultUtil.error("客户端client_id不存在");
        }
        User user = userService.findByUsername(username);
        if(user==null){
            return ResultUtil.error("用户名不存在");
        }
        if(!new BCryptPasswordEncoder().matches(password, user.getPassword())){
            return ResultUtil.error("用户密码不正确");
        }
        // 判断回调地址
        if(!client.getRedirectUri().equals(redirect_uri)){
            return ResultUtil.error("回调地址redirect_uri不正确");
        }
        // 生成code 5分钟内有效
        String code = UUID.randomUUID().toString().replace("-", "");
        // 存入用户及clientId信息
        redisTemplate.opsForValue().set("oauthCode:"+code, new Gson().toJson(new Oauth2TokenInfo(client_id, username)), 5L, TimeUnit.MINUTES);
        Map<String, Object> map = new HashMap<>(16);
        map.put("code", code);
        map.put("redirect_uri", redirect_uri);
        map.put("state", state);
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/token", method = RequestMethod.GET)
    @ApiOperation(value = "获取accessToken令牌")
    public Result<Object> token(@ApiParam("授权类型") @RequestParam String grant_type,
                                @ApiParam("客户端id") @RequestParam String client_id,
                                @ApiParam("客户端秘钥") @RequestParam String client_secret,
                                @ApiParam("认证返回的code") @RequestParam(required = false) String code,
                                @ApiParam("刷新token") @RequestParam(required = false) String refresh_token,
                                @ApiParam("成功授权后回调地址") @RequestParam(required = false) String redirect_uri){

        Client client = clientService.get(client_id);
        if(client==null){
            return ResultUtil.error("客户端client_id不存在");
        }
        // 判断clientSecret
        if(!client.getClientSecret().equals(client_secret)){
            return ResultUtil.error("client_secret不正确");
        }
        Oauth2TokenInfo tokenInfo = null;
        if("authorization_code".equals(grant_type)){
            // 判断回调地址
            if(!client.getRedirectUri().equals(redirect_uri)){
                return ResultUtil.error("回调地址redirect_uri不正确");
            }
            // 判断code 获取用户信息
            String codeValue = redisTemplate.opsForValue().get("oauthCode:"+code);
            if(StrUtil.isBlank(codeValue)){
                return ResultUtil.error("code已过期");
            }
            tokenInfo = new Gson().fromJson(codeValue, Oauth2TokenInfo.class);
            if(!tokenInfo.getClientId().equals(client_id)){
                return ResultUtil.error("code不正确");
            }
        } else if ("refresh_token".equals(grant_type)){
            // 从refreshToken中获取用户信息
            String refreshTokenValue = redisTemplate.opsForValue().get("oauthTokenInfo:"+refresh_token);
            if(StrUtil.isBlank(refreshTokenValue)){
                return ResultUtil.error("refresh_token已过期");
            }
            tokenInfo = new Gson().fromJson(refreshTokenValue, Oauth2TokenInfo.class);
            if(!tokenInfo.getClientId().equals(client_id)){
                return ResultUtil.error("refresh_token不正确");
            }
        } else {
            return ResultUtil.error("授权类型grant_type不正确");
        }

        String token = null, refreshToken = null;
        Long expiresIn = null;
        String tokenKey = "oauthToken:"+client_id+":"+tokenInfo.getUsername(), refreshKey = "oauthRefreshToken:"+client_id+":"+tokenInfo.getUsername();
        if("authorization_code".equals(grant_type)){
            // 生成token模式
            String oldToken = redisTemplate.opsForValue().get(tokenKey);
            String oldRefreshToken = redisTemplate.opsForValue().get(refreshKey);
            if(StrUtil.isNotBlank(oldToken)&&StrUtil.isNotBlank(oldRefreshToken)){
                // 旧token
                token = oldToken;
                refreshToken = oldRefreshToken;
                expiresIn = redisTemplate.getExpire("oauthTokenInfo:"+token, TimeUnit.SECONDS);
            } else {
                // 新生成 30天过期
                String newToken = UUID.randomUUID().toString().replace("-", "");
                String newRefreshToken = UUID.randomUUID().toString().replace("-", "");
                redisTemplate.opsForValue().set(tokenKey, newToken, 30L, TimeUnit.DAYS);
                redisTemplate.opsForValue().set(refreshKey, newRefreshToken, 30L, TimeUnit.DAYS);
                // 新token中存入用户信息
                redisTemplate.opsForValue().set("oauthTokenInfo:"+newToken, new Gson().toJson(tokenInfo),30L, TimeUnit.DAYS);
                redisTemplate.opsForValue().set("oauthTokenInfo:"+newRefreshToken, new Gson().toJson(tokenInfo),30L, TimeUnit.DAYS);
                token = newToken;
                refreshToken = newRefreshToken;
                expiresIn = redisTemplate.getExpire(token, TimeUnit.SECONDS);
            }
        } else if("refresh_token".equals(grant_type)) {
            // 刷新token模式 生成新token 30天过期
            String newToken = UUID.randomUUID().toString().replace("-", "");
            String newRefreshToken = UUID.randomUUID().toString().replace("-", "");
            redisTemplate.opsForValue().set(tokenKey, newToken, 30L, TimeUnit.DAYS);
            redisTemplate.opsForValue().set(refreshKey, newRefreshToken, 30L, TimeUnit.DAYS);
            // 新token中存入用户信息
            redisTemplate.opsForValue().set("oauthTokenInfo:"+newToken, new Gson().toJson(tokenInfo),30L, TimeUnit.DAYS);
            redisTemplate.opsForValue().set("oauthTokenInfo:"+newRefreshToken, new Gson().toJson(tokenInfo),30L, TimeUnit.DAYS);
            token = newToken;
            refreshToken = newRefreshToken;
            expiresIn = redisTemplate.getExpire("oauthTokenInfo:"+token, TimeUnit.SECONDS);
            // 旧refreshToken过期
            redisTemplate.delete("oauthTokenInfo:"+refresh_token);
        }

        Map<String, Object> map = new HashMap<>(16);
        map.put("access_token", token);
        map.put("expires_in", expiresIn);
        map.put("refresh_token", refreshToken);
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/authorized", method = RequestMethod.GET)
    @ApiOperation(value = "已认证过获取code")
    public Result<Object> authorized(@ApiParam("用户名") @RequestParam String username,
                                     @ApiParam("客户端id") @RequestParam String client_id,
                                     @ApiParam("成功授权后回调地址") @RequestParam String redirect_uri,
                                     @ApiParam("客户端状态值") @RequestParam String state){

        Client client = clientService.get(client_id);
        if(client==null){
            return ResultUtil.error("客户端client_id不存在");
        }
        // 判断回调地址
        if(!client.getRedirectUri().equals(redirect_uri)){
            return ResultUtil.error("回调地址redirect_uri不正确");
        }
        // 判断原token是否失效
        String tokenKey = "oauthToken:"+client_id+":"+username, refreshKey = "oauthRefreshToken:"+client_id+":"+username;
        String oldToken = redisTemplate.opsForValue().get(tokenKey);
        String oldRefreshToken = redisTemplate.opsForValue().get(refreshKey);
        if(StrUtil.isBlank(oldToken)||StrUtil.isBlank(oldRefreshToken)){
            return ResultUtil.error("原认证信息已失效，请重新认证");
        }
        // 生成code 5分钟内有效
        String code = UUID.randomUUID().toString().replace("-", "");
        // 存入用户及clientId信息
        redisTemplate.opsForValue().set("oauthCode:"+code, new Gson().toJson(new Oauth2TokenInfo(client_id, username)),5L, TimeUnit.MINUTES);
        Map<String, Object> map = new HashMap<>(16);
        map.put("code", code);
        map.put("redirect_uri", redirect_uri);
        map.put("state", state);
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/user", method = RequestMethod.GET)
    @ApiOperation(value = "获取用户信息")
    public Result<Object> user(@ApiParam("令牌") @RequestParam String access_token){

        String tokenValue = redisTemplate.opsForValue().get("oauthTokenInfo:"+access_token);
        if(StrUtil.isBlank(tokenValue)){
            return ResultUtil.error("access_token已过期失效");
        }
        Oauth2TokenInfo tokenInfo = new Gson().fromJson(tokenValue, Oauth2TokenInfo.class);
        User user = userService.findByUsername(tokenInfo.getUsername());
        if(user==null){
            return ResultUtil.error("用户信息不存在");
        }
        Map<String, Object> map = new HashMap<>(16);
        map.put("username", tokenInfo.getUsername());
        map.put("avatar", user.getAvatar());
        map.put("sex", user.getSex());
        return ResultUtil.data(map);
    }
}
