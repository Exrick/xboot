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
     * 由字母数字下划线组成且开头必须是字母，不能超过16位
     */
    private static final Pattern pUsername = Pattern.compile("[a-zA-Z]{1}[a-zA-Z0-9_]{1,15}");

    /**
     * 手机号
     */
    private static final Pattern pMobile = Pattern.compile("^1[3|4|5|8][0-9]\\d{8}$");

    /**
     * 邮箱
     */
    private static final Pattern pEmail = Pattern.compile("^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$");

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
