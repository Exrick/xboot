package cn.exrick.xboot.common.utils;

import cn.exrick.xboot.config.exception.XbootException;
import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import com.qiniu.util.UrlSafeBase64;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.FileInputStream;
import java.io.IOException;
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
     * 构造一个带指定Zone对象的配置类 zone2华南
     */
    public Configuration getConfiguration(){

        Configuration cfg = null;
        if(zone.equals(0)){
            cfg = new Configuration(Zone.zone0());
        }else if(zone.equals(1)){
            cfg = new Configuration(Zone.zone1());
        }else if(zone.equals(2)){
            cfg = new Configuration(Zone.zone2());
        }else if(zone.equals(3)){
            cfg = new Configuration(Zone.zoneNa0());
        }else if(zone.equals(4)){
            cfg = new Configuration(Zone.zoneAs0());
        }else {
            cfg = new Configuration(Zone.autoZone());
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
    public String qiniuInputStreamUpload(FileInputStream file, String key) {

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
     * Base64上传
     * @param data64
     * @return
     */
    public String qiniuBase64Upload(String data64) {

        String key = renamePic("");
        // 服务端http://up-z2.qiniup.com 此处存储区域需自行修改
        String url = "http://up-z2.qiniup.com/putb64/-1/key/" + UrlSafeBase64.encodeToString(key);
        RequestBody rb = RequestBody.create(null, data64);
        Request request = new Request.Builder().
                url(url).
                addHeader("Content-Type", "application/octet-stream")
                .addHeader("Authorization", "UpToken " + getUpToken())
                .post(rb).build();
        OkHttpClient client = new OkHttpClient();
        okhttp3.Response response = null;
        try {
            response = client.newCall(request).execute();
        } catch (IOException e) {
            throw new XbootException("上传文件出错，请检查七牛云配置，" + e.toString());
        }
        return domain + "/" + key;
    }

    public String getUpToken() {
        Auth auth = Auth.create(accessKey, secretKey);
        return auth.uploadToken(bucket, null, 3600, new StringMap().put("insertOnly", 1));
    }

    public String base64Data(String data) {

        if (data == null || data.isEmpty()) {
            return "";
        }
        String base64 = data.substring(data.lastIndexOf(",") + 1);
        return base64;
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