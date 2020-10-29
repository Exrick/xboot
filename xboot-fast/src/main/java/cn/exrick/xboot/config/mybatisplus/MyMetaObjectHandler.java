package cn.exrick.xboot.config.mybatisplus;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 字段填充审计
 * @author Exrick
 */
@Slf4j
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {

        setFieldUser("createBy", metaObject);
        this.setFieldValByName("createTime", new Date(), metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {

        setFieldUser("updateBy", metaObject);
        this.setFieldValByName("updateTime", new Date(), metaObject);
    }

    public void setFieldUser(String field, MetaObject metaObject) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && authentication.getName() != null
                && !(authentication instanceof AnonymousAuthenticationToken)) {
            this.setFieldValByName(field, authentication.getName(), metaObject);
        }
    }
}

