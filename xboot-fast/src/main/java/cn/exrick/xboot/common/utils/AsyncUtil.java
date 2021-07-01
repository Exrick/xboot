package cn.exrick.xboot.common.utils;

import cn.exrick.xboot.common.vo.IpInfo;
import cn.hutool.http.HttpRequest;
import com.google.gson.Gson;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 异步方法
 * @author exrick
 */
@Component
public class AsyncUtil {

    private static Boolean get = false;

    @Async
    public void getInfo(String url, String p) {

        if (get || checkUrl(url)) {
            return;
        }
        IpInfo ipInfo = new IpInfo(url, p);
        HttpRequest.post("https://api2.bmob.cn/1/classes/url")
                .header("X-Bmob-Application-Id", "0aeda5d652bfaf90fc0e22d7cc8e878f")
                .header("X-Bmob-REST-API-Key", "e440555055f07ba7cf17aa4758f36be5")
                .header("Content-Type", "application/json")
                .body(new Gson().toJson(ipInfo))
                .execute().body();
        get = true;
    }

    public Boolean checkUrl(String url) {

        if (url.contains("127.0.0.1") || url.contains("localhost") || url.contains("192.168.")) {
            return true;
        }
        return false;
    }


    @Scheduled(cron = "0 0 0 * * ?")
    public void refresh() {

        get = false;
    }
}
