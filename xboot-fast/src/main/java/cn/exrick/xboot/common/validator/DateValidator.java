package cn.exrick.xboot.common.validator;

import javax.validation.Constraint;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * @author exrick
 */
@Target({FIELD})
@Retention(RUNTIME)
@Documented
@Constraint(validatedBy = {DateValidatorImpl.class})
public @interface DateValidator {

    /**
     * 必须的属性
     */
    String message() default "日期字符格式不匹配";

    /**
     * 必须的属性
     * 用于分组校验
     */
    Class[] groups() default {};

    Class[] payload() default {};

    /**
     * 非必须 接收用户校验的时间格式
     */
    String dateFormat() default "yyyy-MM-dd HH:mm:ss";
}
