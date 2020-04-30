package cn.exrick.xboot.common.utils;

import lombok.extern.slf4j.Slf4j;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 用户名验证工具类
 * @author Exrickx
 */
@Slf4j
public class UsernameUtil {

    /**
     * 由字母、数字、下划线、中文组成，不能超过16位
     */
    private static final Pattern pUsername = Pattern.compile("^[a-zA-Z0-9_\\u4e00-\\u9fa5]{1,16}$");

    /**
     * 普通用户11位手机号
     * 10、11、12开头的号码已分配给特定机构
     */
    private static final Pattern pMobile = Pattern.compile("^[1][3,4,5,6,7,8,9][0-9]{9}$");

    /**
     * 邮箱
     * http://emailregex.com/
     */
    private static final Pattern pEmail = Pattern.compile("^(([^<>()\\[\\]\\\\.,;:\\s@\"]+(\\.[^<>()\\[\\]\\\\.,;:\\s@\"]+)*)|(\".+\"))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$");

    public static boolean Username(String v){

        Matcher m = pUsername.matcher(v);
        if(m.matches()){
            return true;
        }
        return false;
    }

    public static boolean Mobile(String v){

        Matcher m = pMobile.matcher(v);
        if(m.matches()){
            return true;
        }
        return false;
    }

    public static boolean Email(String v){

        Matcher m = pEmail.matcher(v);
        if(m.matches()){
            return true;
        }
        return false;
    }
}
