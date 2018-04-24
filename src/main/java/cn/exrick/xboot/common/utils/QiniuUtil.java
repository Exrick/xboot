package cn.exrick.xboot.common.utils;

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

    @Value("${xboot.qiniu.isLim}")
    private static boolean isLim;

    /**
     * 生成上传凭证，然后准备上传
     */
    private static String accessKey = "_VKlMONYct_cXOibOAOQWukdZjHTd2p7J4NPjKn3";

    private static String secretKey = "G4POT7bN4DM5rmirdXCyuPhBAOls2J6WWVKETrEa";

    private static String bucket = "rent";

    private static String origin="http://p77xsahe9.bkt.clouddn.com/";

    private static Auth auth = Auth.create(accessKey, secretKey);

    private static String upToken = auth.uploadToken(bucket);

    /**
     * 构造一个带指定Zone对象的配置类 zone2华南
     */
    private static Configuration cfg = new Configuration(Zone.zone2());

    private static UploadManager uploadManager = new UploadManager(cfg);

    /**
     * 文件路径上传
     * @param filePath
     * @param key 文件名
     * @return
     */
    public static String qiniuUpload(String filePath, String key){

        try {
            Response response = uploadManager.put(filePath, key, upToken);
            //解析上传成功的结果
            DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
            if(isLim){
                return origin + putRet.key + "?imageslim";
            }
            return origin + putRet.key;
        }catch(QiniuException ex){
            Response r = ex.response;
            log.warn(r.toString());
            try {
                log.warn(r.bodyString());
                return r.bodyString();
            } catch (QiniuException ex2) {
                //ignore
            }
        }
        return null;
    }

    /**
     * 文件流上传
     * @param file
     * @param key 文件名
     * @return
     */
    public static String qiniuInputStreamUpload(FileInputStream file,String key){

        try {
            Response response = uploadManager.put(file,key,upToken,null, null);
            //解析上传成功的结果
            DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
            if(isLim){
                return origin + putRet.key + "?imageslim";
            }
            return origin + putRet.key;
        } catch (QiniuException ex) {
            Response r = ex.response;
            log.warn(r.toString());
            try {
                log.warn(r.bodyString());
                return r.bodyString();
            } catch (QiniuException ex2) {
                //ignore
            }
        }
        return null;
    }

    /**
     * Base64上传
     * @param data64
     * @return
     */
    public static String qiniuBase64Upload(String data64){

        String key = renamePic("");
        //服务端http://up-z2.qiniup.com
        String url = "http://up-z2.qiniup.com/putb64/-1/key/"+ UrlSafeBase64.encodeToString(key);
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
            e.printStackTrace();
        }
        if(isLim){
            return origin + key + "?imageslim";
        }
        return origin + key;
    }

    public static String getUpToken() {
        return auth.uploadToken(bucket, null, 3600, new StringMap().put("insertOnly", 1));
    }

    public static String base64Data(String data){

        if(data==null||data.isEmpty()){
            return "";
        }
        String base64 =data.substring(data.lastIndexOf(",")+1);
        return base64;
    }

    /**
     * 以UUID重命名
     * @param fileName
     * @return
     */
    public static String renamePic(String fileName){
        String extName = fileName.substring(fileName.lastIndexOf("."));
        return UUID.randomUUID().toString().replace("-","")+extName;
    }

    public static void main(String[] args){
        base64Data("data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEASABIAAD/2");
    }
}
