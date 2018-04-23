package cn.exrick.xboot.config.security;

import cn.exrick.xboot.common.constant.CommonConstant;
import cn.exrick.xboot.common.utils.ResponseUtil;
import com.google.gson.Gson;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * 登录成功处理类
 * @author Exrickx
 */
@Slf4j
@Component
public class AuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Value("${xboot.jwtExpireTime}")
    private Integer jwtExpireTime;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        String username = ((UserDetails)authentication.getPrincipal()).getUsername();
        String authorities = new Gson().toJson(((UserDetails)authentication.getPrincipal()).getAuthorities());
        //登陆成功生成JWT
        String token = Jwts.builder()
                //主题 放入用户名
                .setSubject(username)
                //自定义属性 放入用户拥有权限
                .claim(CommonConstant.AUTHORITIES, authorities)
                //失效时间
                .setExpiration(new Date(System.currentTimeMillis() + jwtExpireTime * 60 * 1000))
                //签名算法和密钥
                .signWith(SignatureAlgorithm.HS512, CommonConstant.JWT_SIGN_KEY)
                .compact();
        token = CommonConstant.TOKEN_SPLIT + token;
        log.info(token);

        ResponseUtil.out(response, ResponseUtil.resultMap(true,200,"登录成功", token));
    }
}
