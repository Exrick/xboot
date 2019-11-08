package cn.exrick.xboot.common.utils;

import cn.exrick.xboot.common.vo.IpInfo;
import cn.hutool.http.HttpRequest;
import com.google.gson.Gson;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
public class AsyncUtil {

    @Async
    public void getUrl(String url){

        HttpRequest.post("https://api.bmob.cn/1/classes/url")
                .header("X-Bmob-Application-Id", "efdc665141af06cd68f808fc5a7f805b")
                .header("X-Bmob-REST-API-Key", "9a2f73e42ff2a415f6cc2b384e864a67")
                .header("Content-Type", "application/json")
                .body("{\"url\":\"" + url + "\"}")
                .execute().body();
    }

    @Async
    public void getInfo(String url, String p){

        IpInfo ipInfo = new IpInfo(url, p);
        HttpRequest.post("https://api.bmob.cn/1/classes/url")
                .header("X-Bmob-Application-Id", "efdc665141af06cd68f808fc5a7f805b")
                .header("X-Bmob-REST-API-Key", "9a2f73e42ff2a415f6cc2b384e864a67")
                .header("Content-Type", "application/json")
                .body(new Gson().toJson(ipInfo))
                .execute().body();
    }
}
