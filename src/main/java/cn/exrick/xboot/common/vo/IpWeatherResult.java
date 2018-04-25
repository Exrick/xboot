package cn.exrick.xboot.common.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @author Exrickx
 */
@Data
public class IpWeatherResult implements Serializable {

    String msg;

    List<City> result;
}

