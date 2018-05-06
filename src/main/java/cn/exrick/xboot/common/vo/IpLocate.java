package cn.exrick.xboot.common.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @author Exrickx
 */
@Data
public class IpLocate implements Serializable {

    private String retCode;

    private City result;
}

