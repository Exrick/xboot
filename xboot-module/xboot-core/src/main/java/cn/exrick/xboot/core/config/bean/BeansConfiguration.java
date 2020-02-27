package cn.exrick.xboot.core.config.bean;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.PathMatcher;

/**
 * 声明bean
 * @author exrick
 */
@Configuration
public class BeansConfiguration {

    @Bean
    public PathMatcher pathMatcher(){

        return new AntPathMatcher();
    }
}
