package cn.exrick.xboot.common.limit;

import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

/**
 * 令牌桶算法限流
 * @author Exrick
 */
@Slf4j
@Component
public class RedisRaterLimiter {

    @Autowired
    private StringRedisTemplate redisTemplate;

    public String acquireToken(String point, Integer limit, Long timeout) {

        String maxCountKey = "BUCKET:MAX_COUNT:" + point;

        String currCountKey = "BUCKET:CURR_COUNT:" + point;

        try {
            // 令牌值
            String token = "T";
            // 无效的限流值 返回token
            if(limit<=0||timeout<=0){
                return token;
            }
            // maxCount为主要判断标志
            String maxCount = redisTemplate.opsForValue().get(maxCountKey);
            String currCount = redisTemplate.opsForValue().get(currCountKey);
            // 初始
            if(StrUtil.isBlank(maxCount)){
                // 初始计数为1
                redisTemplate.opsForValue().set(currCountKey, "1", timeout, TimeUnit.MILLISECONDS);
                // 总数
                redisTemplate.opsForValue().set(maxCountKey, limit.toString(), timeout, TimeUnit.MILLISECONDS);
                return token;
            } else if (StrUtil.isNotBlank(maxCount)&&StrUtil.isNotBlank(currCount)){
                // 判断是否超过限制
                if(Integer.valueOf(currCount)<Integer.valueOf(maxCount)){
                    // 计数加1
                    redisTemplate.opsForValue().set(currCountKey, String.valueOf(Integer.valueOf(currCount)+1), timeout, TimeUnit.MILLISECONDS);
                    return token;
                }
            } else {
                // currCount变量先失效（几乎不可能） 返回token
                return token;
            }
        } catch (Exception e) {
            log.error("限流出错，请检查Redis运行状态\n"+e.toString());
        }
        return null;
    }
}

