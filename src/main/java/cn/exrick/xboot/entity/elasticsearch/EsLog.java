package cn.exrick.xboot.entity.elasticsearch;

import cn.exrick.xboot.base.XbootBaseEntity;
import cn.exrick.xboot.common.constant.CommonConstant;
import cn.exrick.xboot.common.utils.SnowFlakeUtil;
import cn.hutool.core.util.StrUtil;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.gson.Gson;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.elasticsearch.annotations.Document;

import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**
 * Elasticsearch文档实体类
 * @author Exrickx
 */
@Data
@Document(indexName = "log", type = "log", shards = 1, replicas = 0, refreshInterval = "-1")
public class EsLog implements Serializable{

    private static final long serialVersionUID = 1L;

    @Id
    @ApiModelProperty(value = "唯一标识")
    private String id = String.valueOf(SnowFlakeUtil.getFlowIdInstance().nextId());

    @ApiModelProperty(value = "创建者")
    private String createBy;

    @CreatedDate
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "更新者")
    private String updateBy;

    @LastModifiedDate
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty(value = "更新时间")
    private Date updateTime;

    @ApiModelProperty(value = "删除标志 默认0")
    private Integer delFlag = CommonConstant.STATUS_NORMAL;

    @ApiModelProperty(value = "方法操作名称")
    private String name;

    @ApiModelProperty(value = "请求路径")
    private String requestUrl;

    @ApiModelProperty(value = "请求类型")
    private String requestType;

    @ApiModelProperty(value = "请求参数")
    private String requestParam;

    @ApiModelProperty(value = "请求用户")
    private String username;

    @ApiModelProperty(value = "ip")
    private String ip;

    @ApiModelProperty(value = "ip信息")
    private String ipInfo;

    @ApiModelProperty(value = "花费时间")
    private Integer costTime;

    /**
     * 转换请求参数为Json
     * @param paramMap
     */
    public void setMapToParams(Map<String, String[]> paramMap) {
        if (paramMap == null) {
            return;
        }
        Map<String, Object> params = new HashMap<>();
        for (Map.Entry<String, String[]> param : paramMap.entrySet()) {

            String key = param.getKey();
            String paramValue = (param.getValue() != null && param.getValue().length > 0 ? param.getValue()[0] : "");
            String obj = StrUtil.endWithIgnoreCase(param.getKey(), "password") ? "你是看不见我的" : paramValue;
            params.put(key,obj);
        }
        this.requestParam = new Gson().toJson(params);
    }
}
