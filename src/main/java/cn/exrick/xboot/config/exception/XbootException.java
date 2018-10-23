package cn.exrick.xboot.config.exception;

import lombok.Data;

/**
 * @author Exrickx
 */
@Data
public class XbootException extends RuntimeException {

    private String msg;

    public XbootException(String msg){
        super(msg);
        this.msg = msg;
    }
}
