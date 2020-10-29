package cn.exrick.xboot.common.annotation;

import java.lang.annotation.*;

/**
 * Redis限流注解
 * @author Exrickx
 */
@Target(ElementType.METHOD) // 作用于方法上
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RateLimiter {

    /**
     * 自定义限流切入点 name 默认类引用路径+方法名
     * @return
     */
    String name() default "";

    /**
     * 限流速率（时间间隔内最大请求个数）
     * @return
     */
    long rate() default 5;

    /**
     * 速率间隔 单位毫秒
     * @return
     */
    long rateInterval() default 1000;

    /**
     * 是否启用IP限流（加上IP作为name标识）
     * @return
     */
    boolean ipLimit() default false;
}
