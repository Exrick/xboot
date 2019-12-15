package cn.exrick.xboot.common.utils;

import cn.exrick.xboot.common.exception.XbootException;
import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.UUID;

/**
 * @author Exrickx
 */
@Slf4j
@Component
public class QiniuUtil {

    /**
     * 生成上传凭证，然后准备上传
     */
    @Value("${xboot.qiniu.accessKey}")
    private String accessKey;

    @Value("${xboot.qiniu.secretKey}")
    private String secretKey;

    @Value("${xboot.qiniu.bucket}")
    private String bucket;

    @Value("${xboot.qiniu.domain}")
    private String domain;

    @Value("${xboot.qiniu.zone}")
    private Integer zone;

    /**
     * 构造一个带指定Zone对象的配置类
     */
    public Configuration getConfiguration(){

        Configuration cfg = null;
        if(zone.equals(0)){
            cfg = new Configuration(Region.region0());
        }else if(zone.equals(1)){
            cfg = new Configuration(Region.region1());
        }else if(zone.equals(2)){
            cfg = new Configuration(Region.region2());
        }else if(zone.equals(3)){
            cfg = new Configuration(Region.regionNa0());
        }else if(zone.equals(4)){
            cfg = new Configuration(Region.regionAs0());
        }else {
            cfg = new Configuration(Region.autoRegion());
        }
        return cfg;
    }

    public UploadManager getUploadManager(Configuration cfg){

        UploadManager uploadManager = new UploadManager(cfg);
        return uploadManager;
    }

    /**
     * 文件路径上传
     * @param filePath
     * @param key   文件名
     * @return
     */
    public String qiniuUpload(String filePath, String key) {

        Auth auth = Auth.create(accessKey, secretKey);
        String upToken = auth.uploadToken(bucket);
        try {
            Response response = getUploadManager(getConfiguration()).put(filePath, key, upToken);
            DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
            return domain + "/" + putRet.key;
        } catch (QiniuException ex) {
            Response r = ex.response;
            throw new XbootException("上传文件出错，请检查七牛云配置，" + r.toString());
        }
    }

    /**
     * 文件流上传
     * @param file
     * @param key  文件名
     * @return
     */
    public String qiniuInputStreamUpload(InputStream file, String key) {

        Auth auth = Auth.create(accessKey, secretKey);
        String upToken = auth.uploadToken(bucket);
        try {
            Response response = getUploadManager(getConfiguration()).put(file, key, upToken, null, null);
            DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
            return domain + "/" + putRet.key;
        } catch (QiniuException ex) {
            Response r = ex.response;
            throw new XbootException("上传文件出错，请检查七牛云配置，" + r.toString());
        }
    }

    /**
     * 以UUID重命名
     *
     * @param fileName
     * @return
     */
    public String renamePic(String fileName) {
        String extName = fileName.substring(fileName.lastIndexOf("."));
        return UUID.randomUUID().toString().replace("-", "") + extName;
    }
}