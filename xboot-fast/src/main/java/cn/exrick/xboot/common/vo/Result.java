package cn.exrick.xboot.common.vo;


import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * @author Exrickx
 * 前后端交互数据标准
 */
@Data
public class Result<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "成功标志")
    private boolean success;

    @ApiModelProperty(value = "消息")
    private String message;

    @ApiModelProperty(value = "返回代码")
    private Integer code;

    @ApiModelProperty(value = "时间戳")
    private long timestamp = System.currentTimeMillis();

    @ApiModelProperty(value = "结果对象")
    private T result;
}
