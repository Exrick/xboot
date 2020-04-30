package cn.exrick.xboot.config.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * @author Exrickx
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "xboot.token")
public class XbootTokenProperties {

    /**
     * 使用redis存储token
     */
    private Boolean redis = true;

    /**
     * 单设备登陆
     */
    private Boolean sdl = true;

    /**
     * 存储权限数据
     */
    private Boolean storePerms = true;

    /**
     * token默认过期时间
     */
    private Integer tokenExpireTime = 30;

    /**
     * 用户选择保存登录状态对应token过期时间（天）
     */
    private Integer saveLoginTime = 7;

    /**
     * 限制用户登陆错误次数（次）
     */
    private Integer loginTimeLimit = 10;

    /**
     * 错误超过次数后多少分钟后才能继续登录（分钟）
     */
    private Integer loginAfterTime = 10;
}
