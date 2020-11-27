package cn.exrick.xboot.modules.open.controller;

import cn.exrick.xboot.common.annotation.SystemLog;
import cn.exrick.xboot.common.constant.OAuthConstant;
import cn.exrick.xboot.common.constant.SecurityConstant;
import cn.exrick.xboot.common.enums.LogType;
import cn.exrick.xboot.common.exception.XbootException;
import cn.exrick.xboot.common.redis.RedisTemplateHelper;
import cn.exrick.xboot.common.utils.NameUtil;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.utils.SecurityUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.config.security.SecurityUserDetails;
import cn.exrick.xboot.modules.base.entity.User;
import cn.exrick.xboot.modules.base.service.UserService;
import cn.exrick.xboot.modules.open.entity.Client;
import cn.exrick.xboot.modules.open.service.ClientService;
import cn.exrick.xboot.modules.open.vo.Oauth2TokenInfo;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * @author Exrick
 */
@Slf4j
@RestController
@Api(tags = "OAuth2认证接口")
@RequestMapping("/xboot/oauth2")
public class Oauth2Controller {

    @Autowired
    private ClientService clientService;

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private RedisTemplateHelper redisTemplate;

    @RequestMapping(value = "/info/{client_id}", method = RequestMethod.GET)
    @ApiOperation(value = "站点基本信息")
    public Result<Object> info(@ApiParam("客户端id") @PathVariable String client_id) {

        Client client = getClient(client_id);

        Map<String, Object> map = new HashMap<>(16);
        map.put("name", client.getName());
        map.put("homeUri", client.getHomeUri());
        map.put("logo", client.getLogo());
        map.put("autoApprove", client.getAutoApprove());
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/authorize", method = RequestMethod.POST)
    @ApiOperation(value = "认证获取code")
    @SystemLog(description = "认证中心登录", type = LogType.LOGIN)
    public Result<Object> authorize(@ApiParam("用户名") @RequestParam String username,
                                    @ApiParam("密码") @RequestParam String password,
                                    @ApiParam("客户端id") @RequestParam String client_id,
                                    @ApiParam("成功授权后回调地址") @RequestParam String redirect_uri,
                                    @ApiParam("授权类型为code") @RequestParam(required = false, defaultValue = "code") String response_type,
                                    @ApiParam("客户端状态值") @RequestParam String state) {

        Client client = getClient(client_id);

        if (!client.getRedirectUri().equals(redirect_uri)) {
            return ResultUtil.error("回调地址redirect_uri不正确");
        }
        // 登录认证
        User user;
        if (NameUtil.mobile(username)) {
            user = userService.findByMobile(username);
        } else if (NameUtil.email(username)) {
            user = userService.findByEmail(username);
        } else {
            user = userService.findByUsername(username);
        }
        if (user == null) {
            return ResultUtil.error("用户名不存在");
        }
        if (!new BCryptPasswordEncoder().matches(password, user.getPassword())) {
            return ResultUtil.error("用户密码不正确");
        }
        String accessToken = securityUtil.getToken(user.getUsername(), true);
        // 生成code 5分钟内有效
        String code = IdUtil.simpleUUID();
        // 存入用户及clientId信息
        redisTemplate.set(OAuthConstant.OAUTH_CODE_PRE + code,
                new Gson().toJson(new Oauth2TokenInfo(client_id, user.getUsername())), 5L, TimeUnit.MINUTES);
        Map<String, Object> map = new HashMap<>(16);
        map.put("code", code);
        map.put("redirect_uri", redirect_uri);
        map.put("state", state);
        map.put("accessToken", accessToken);
        // 记录日志
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                new SecurityUserDetails(new User().setUsername(user.getUsername())), null, null);
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/token", method = RequestMethod.GET)
    @ApiOperation(value = "获取access_token令牌")
    public Result<Object> token(@ApiParam("授权类型") @RequestParam String grant_type,
                                @ApiParam("客户端id") @RequestParam String client_id,
                                @ApiParam("客户端秘钥") @RequestParam String client_secret,
                                @ApiParam("认证返回的code") @RequestParam(required = false) String code,
                                @ApiParam("刷新token") @RequestParam(required = false) String refresh_token,
                                @ApiParam("成功授权后回调地址") @RequestParam(required = false) String redirect_uri) {

        Client client = getClient(client_id);

        // 判断clientSecret
        if (!client.getClientSecret().equals(client_secret)) {
            return ResultUtil.error("client_secret不正确");
        }
        Oauth2TokenInfo tokenInfo = null;
        if (OAuthConstant.AUTHORIZATION_CODE.equals(grant_type)) {
            // 判断回调地址
            if (!client.getRedirectUri().equals(redirect_uri)) {
                return ResultUtil.error("回调地址redirect_uri不正确");
            }
            // 判断code 获取用户信息
            String codeValue = redisTemplate.get(OAuthConstant.OAUTH_CODE_PRE + code);
            if (StrUtil.isBlank(codeValue)) {
                return ResultUtil.error("code已过期");
            }
            tokenInfo = new Gson().fromJson(codeValue, Oauth2TokenInfo.class);
            if (!tokenInfo.getClientId().equals(client_id)) {
                return ResultUtil.error("code不正确");
            }
        } else if (OAuthConstant.REFRESH_TOKEN.equals(grant_type)) {
            // 从refreshToken中获取用户信息
            String refreshTokenValue = redisTemplate.get(OAuthConstant.OAUTH_TOKEN_INFO_PRE + refresh_token);
            if (StrUtil.isBlank(refreshTokenValue)) {
                return ResultUtil.error("refresh_token已过期");
            }
            tokenInfo = new Gson().fromJson(refreshTokenValue, Oauth2TokenInfo.class);
            if (!tokenInfo.getClientId().equals(client_id)) {
                return ResultUtil.error("refresh_token不正确");
            }
        } else {
            return ResultUtil.error("授权类型grant_type不正确");
        }

        String token = null, refreshToken = null;
        Long expiresIn = null;
        String tokenKey = OAuthConstant.OAUTH_TOKEN_PRE + tokenInfo.getUsername() + ":" + client_id,
                refreshKey = OAuthConstant.OAUTH_REFRESH_TOKEN_PRE + tokenInfo.getUsername() + ":" + client_id;
        if (OAuthConstant.AUTHORIZATION_CODE.equals(grant_type)) {
            // 生成token模式
            String oldToken = redisTemplate.get(tokenKey);
            String oldRefreshToken = redisTemplate.get(refreshKey);
            if (StrUtil.isNotBlank(oldToken) && StrUtil.isNotBlank(oldRefreshToken)) {
                // 旧token
                token = oldToken;
                refreshToken = oldRefreshToken;
                expiresIn = redisTemplate.getExpire(OAuthConstant.OAUTH_TOKEN_INFO_PRE + token, TimeUnit.SECONDS);
            } else {
                // 新生成 30天过期
                String newToken = IdUtil.simpleUUID();
                String newRefreshToken = IdUtil.simpleUUID();
                redisTemplate.set(tokenKey, newToken, 30L, TimeUnit.DAYS);
                redisTemplate.set(refreshKey, newRefreshToken, 30L, TimeUnit.DAYS);
                // 新token中存入用户信息
                redisTemplate.set(OAuthConstant.OAUTH_TOKEN_INFO_PRE + newToken, new Gson().toJson(tokenInfo), 30L, TimeUnit.DAYS);
                redisTemplate.set(OAuthConstant.OAUTH_TOKEN_INFO_PRE + newRefreshToken, new Gson().toJson(tokenInfo), 30L, TimeUnit.DAYS);
                token = newToken;
                refreshToken = newRefreshToken;
                expiresIn = redisTemplate.getExpire(OAuthConstant.OAUTH_TOKEN_INFO_PRE + token, TimeUnit.SECONDS);
            }
        } else if (OAuthConstant.REFRESH_TOKEN.equals(grant_type)) {
            // 刷新token模式 生成新token 30天过期
            String newToken = IdUtil.simpleUUID();
            String newRefreshToken = IdUtil.simpleUUID();
            redisTemplate.set(tokenKey, newToken, 30L, TimeUnit.DAYS);
            redisTemplate.set(refreshKey, newRefreshToken, 30L, TimeUnit.DAYS);
            // 新token中存入用户信息
            redisTemplate.set(OAuthConstant.OAUTH_TOKEN_INFO_PRE + newToken, new Gson().toJson(tokenInfo), 30L, TimeUnit.DAYS);
            redisTemplate.set(OAuthConstant.OAUTH_TOKEN_INFO_PRE + newRefreshToken, new Gson().toJson(tokenInfo), 30L, TimeUnit.DAYS);
            token = newToken;
            refreshToken = newRefreshToken;
            expiresIn = redisTemplate.getExpire(OAuthConstant.OAUTH_TOKEN_INFO_PRE + token, TimeUnit.SECONDS);
            // 旧refreshToken过期
            redisTemplate.delete(OAuthConstant.OAUTH_TOKEN_INFO_PRE + refresh_token);
        }

        Map<String, Object> map = new HashMap<>(16);
        map.put("access_token", token);
        map.put("expires_in", expiresIn);
        map.put("refresh_token", refreshToken);
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/authorized", method = RequestMethod.POST)
    @ApiOperation(value = "已认证过获取code/单点登录实现")
    public Result<Object> authorized(@ApiParam("客户端id") @RequestParam String client_id,
                                     @ApiParam("成功授权后回调地址") @RequestParam String redirect_uri,
                                     @ApiParam("客户端状态值") @RequestParam String state) {

        Client client = getClient(client_id);

        // 判断回调地址
        if (!client.getRedirectUri().equals(redirect_uri)) {
            return ResultUtil.error("回调地址redirect_uri不正确");
        }

        User user = securityUtil.getCurrUser();

        // 生成code 5分钟内有效
        String code = IdUtil.simpleUUID();
        redisTemplate.set(OAuthConstant.OAUTH_CODE_PRE + code,
                new Gson().toJson(new Oauth2TokenInfo(client_id, user.getUsername())), 5L, TimeUnit.MINUTES);
        Map<String, Object> map = new HashMap<>(16);
        map.put("code", code);
        map.put("redirect_uri", redirect_uri);
        map.put("state", state);
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    @ApiOperation(value = "退出登录（内部信任站点使用）")
    public Result<Object> logout() {

        User user = securityUtil.getCurrUser();

        // 删除当前用户登录accessToken
        String token = redisTemplate.get(SecurityConstant.USER_TOKEN + user.getUsername());
        redisTemplate.delete(token);
        redisTemplate.delete(SecurityConstant.USER_TOKEN + user.getUsername());
        // 删除当前用户授权第三方应用的access_token
        redisTemplate.deleteByPattern(OAuthConstant.OAUTH_TOKEN_PRE + user.getUsername() + ":*");
        redisTemplate.deleteByPattern(OAuthConstant.OAUTH_REFRESH_TOKEN_PRE + user.getUsername() + ":*");
        return ResultUtil.data(null);
    }

    @RequestMapping(value = "/user", method = RequestMethod.GET)
    @ApiOperation(value = "获取用户信息")
    public Result<Object> user(@ApiParam("令牌") @RequestParam String access_token) {

        String tokenValue = redisTemplate.get(OAuthConstant.OAUTH_TOKEN_INFO_PRE + access_token);
        if (StrUtil.isBlank(tokenValue)) {
            return ResultUtil.error("access_token已过期失效");
        }
        Oauth2TokenInfo tokenInfo = new Gson().fromJson(tokenValue, Oauth2TokenInfo.class);
        User user = userService.findByUsername(tokenInfo.getUsername());
        if (user == null) {
            return ResultUtil.error("用户信息不存在");
        }
        Map<String, Object> map = new HashMap<>(16);
        map.put("username", tokenInfo.getUsername());
        map.put("avatar", user.getAvatar());
        map.put("sex", user.getSex());
        return ResultUtil.data(map);
    }

    private Client getClient(String client_id) {

        Client client = clientService.get(client_id);
        if (client == null) {
            throw new XbootException("客户端client_id不存在");
        }
        return client;
    }
}
