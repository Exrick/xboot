package cn.exrick.xboot.common.utils;

import cn.exrick.xboot.common.constant.SecurityConstant;
import cn.exrick.xboot.exception.XbootException;
import cn.hutool.core.util.StrUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import io.jsonwebtoken.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Exrickx
 */
@Slf4j
public class JWTUtil {

    private static final String token = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGhvcml0aWVzIjoiW3tcInJvbGVcIjpcIlJPTEVfQURNSU5cIn1dIiwiZXhwIjoxNTI0NDg5MTUzfQ.-TOsmUB0HkRUOqEBb-LvM-7TeACwyFVTZiQbblUa42d9pmRn8PIpuALaUbQFkWiQEDDzYZU9OFUaW7IYvqWsiQ";

    public static void main(String[] args){
        // 解析token.
        Claims claims = null;
        try {
            claims = Jwts.parser()
                    .setSigningKey(SecurityConstant.JWT_SIGN_KEY)
                    .parseClaimsJws(token.replace(SecurityConstant.TOKEN_SPLIT, ""))
                    .getBody();

            //获取用户名
            String username = claims.getSubject();
            log.info(username+"=========");
            //获取权限（角色）
            String authoritie = claims.get("authorities").toString();
            log.info(authoritie);
            if(StrUtil.isNotBlank(authoritie)){

                List<GrantedAuthority> authorities =  AuthorityUtils.commaSeparatedStringToAuthorityList(authoritie);

                for(GrantedAuthority grantedAuthority:authorities){
                    log.info(grantedAuthority.getAuthority()+"===========");
                }
            }

        } catch (ExpiredJwtException e) {
            throw new XbootException("Token已过期");
        } catch (UnsupportedJwtException e) {
            throw new XbootException("Token格式错误");
        } catch (MalformedJwtException e) {
            throw new XbootException("Token没有被正确构造");
        } catch (SignatureException e) {
            throw new XbootException("签名失败");
        } catch (IllegalArgumentException e) {
            throw new XbootException("非法参数异常");
        }
    }
}
