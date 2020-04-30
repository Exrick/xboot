package cn.exrick.xboot.config.bean;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

/**
 * 声明bean
 * @author exrick
 */
@Configuration
@Import(cn.hutool.extra.spring.SpringUtil.class)
public class BeansConfiguration {

    @Bean
    public PathMatcher pathMatcher(){

        return new AntPathMatcher();
    }
}
