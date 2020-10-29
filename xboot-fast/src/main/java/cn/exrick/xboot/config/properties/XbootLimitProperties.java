package cn.exrick.xboot.config.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author Exrickx
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "xboot.ratelimit")
public class XbootLimitProperties {

    /**
     * 是否开启全局限流
     */
    private Boolean enable = false;

    /**
     * 限制请求个数
     */
    private Long limit = 100L;

    /**
     * 每单位时间内（毫秒）
     */
    private Long timeout = 1000L;
}
