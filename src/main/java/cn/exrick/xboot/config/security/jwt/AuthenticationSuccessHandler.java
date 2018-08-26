package cn.exrick.xboot.config.security.jwt;

import cn.exrick.xboot.common.annotation.SystemLog;
import cn.exrick.xboot.common.constant.SecurityConstant;
import cn.exrick.xboot.common.utils.IpInfoUtil;
import cn.exrick.xboot.common.utils.ResponseUtil;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 登录成功处理类
 * @author Exrickx
 */
@Slf4j
@Component
public class AuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Value("${xboot.tokenExpireTime}")
    private Integer tokenExpireTime;

    @Value("${xboot.saveLoginTime}")
    private Integer saveLoginTime;

    @Autowired
    private IpInfoUtil ipInfoUtil;

    @Override
    @SystemLog(description="登录系统")
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        //用户选择保存登录状态几天
        String saveTime = request.getParameter(SecurityConstant.SAVE_LOGIN);
        if(StrUtil.isNotBlank(saveTime)&&Boolean.valueOf(saveTime)){
            tokenExpireTime = saveLoginTime * 60 * 24;
        }
        String username = ((UserDetails)authentication.getPrincipal()).getUsername();
        List<GrantedAuthority> list = (List<GrantedAuthority>) ((UserDetails)authentication.getPrincipal()).getAuthorities();
        List<String> authorities = new ArrayList<>();
        for(GrantedAuthority g : list){
            authorities.add(g.getAuthority());
        }
        ipInfoUtil.getUrl(request);
        //登陆成功生成JWT
        String token = Jwts.builder()
                //主题 放入用户名
                .setSubject(username)
                //自定义属性 放入用户拥有请求权限
                .claim(SecurityConstant.AUTHORITIES, new Gson().toJson(authorities))
                //失效时间
                .setExpiration(new Date(System.currentTimeMillis() + tokenExpireTime * 60 * 1000))
                //签名算法和密钥
                .signWith(SignatureAlgorithm.HS512, SecurityConstant.JWT_SIGN_KEY)
                .compact();
        token = SecurityConstant.TOKEN_SPLIT + token;

        ResponseUtil.out(response, ResponseUtil.resultMap(true,200,"登录成功", token));
    }
}
