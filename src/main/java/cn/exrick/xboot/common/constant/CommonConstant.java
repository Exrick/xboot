package cn.exrick.xboot.common.constant;


/**
 * 常量
 * @author Exrickx
 */
public interface CommonConstant {

    /**
     * 用户正常状态
     */
    Integer USER_STATUS_NORMAL=0;

    /**
     * 用户禁用状态
     */
    Integer USER_STATUS_LOCK=-1;

    /**
     * 普通用户
     */
    Integer USER_TYPE_NORMAL=0;

    /**
     * 普通用户
     */
    Integer USER_TYPE_ADMIN=1;

    /**
     * 性别男
     */
    Integer SEX_MAN=0;

    /**
     * 性别女
     */
    Integer SEX_WOMAN=1;

    /**
     * 性别保密
     */
    Integer SEX_SECRET=2;

    /**
     * 正常状态
     */
    Integer STATUS_NORMAL=0;

    /**
     * 删除标志
     */
    Integer DEL_FLAG=1;

    /**
     * token分割
     */
    String TOKEN_SPLIT = "Bearer ";

    /**
     * JWT签名加密key
     */
    String JWT_SIGN_KEY = "xboot";

    /**
     * token参数头
     */
    String HEADER = "Authorization";

    /**
     * 权限
     */
    String AUTHORITIES = "authorities";
}
