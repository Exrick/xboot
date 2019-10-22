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

    public String acquireTokenFromBucket(String point, int limit, long timeout) {

        String maxCountKey = "BUCKET:MAX_COUNT:" + point;

        String currCountKey = "BUCKET:CURR_COUNT:" + point;

        try {
            // 令牌值
            String token = "T";
            // 无效的限流值 返回token
            if(limit<1){
                return token;
            }
            String valueMaxCount = redisTemplate.opsForValue().get(maxCountKey);
            // 初始
            if(StrUtil.isBlank(valueMaxCount)){
                // 计数加1
                redisTemplate.opsForValue().increment(currCountKey);
                redisTemplate.expire(currCountKey, timeout, TimeUnit.MILLISECONDS);
                // 总数
                redisTemplate.opsForValue().set(maxCountKey, String.valueOf(limit), timeout, TimeUnit.MILLISECONDS);
                return token;
            } else {
                // 判断是否超过限制
                String currCount = redisTemplate.opsForValue().get(currCountKey);
                if(StrUtil.isNotBlank(currCount)&&Integer.valueOf(currCount)<Integer.valueOf(valueMaxCount)){
                    // 计数加1
                    redisTemplate.opsForValue().increment(currCountKey);
                    return token;
                }
            }
        } catch (Exception e) {
            log.error("限流出错，请检查Redis运行状态\n"+e.toString());
        }
        return null;
    }
}