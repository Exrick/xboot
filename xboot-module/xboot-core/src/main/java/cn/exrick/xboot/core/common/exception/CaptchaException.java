package cn.exrick.xboot.core.common.exception;

import lombok.Data;

/**
 * @author Exrickx
 */
@Data
public class CaptchaException extends RuntimeException {

    private String msg;

    public CaptchaException(String msg){
        super(msg);
        this.msg = msg;
    }
}
