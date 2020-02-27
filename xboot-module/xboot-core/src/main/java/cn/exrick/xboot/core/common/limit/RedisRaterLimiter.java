package cn.exrick.xboot.core.common.limit;

import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.core.RedisOperations;
import org.springframework.data.redis.core.SessionCallback;
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

    public String acquireToken(String point, int limit, long timeout) {

        String maxCountKey = "BUCKET:MAX_COUNT:" + point;

        String currCountKey = "BUCKET:CURR_COUNT:" + point;

        try {
            // 令牌值
            String token = "T";
            // 无效的限流值 返回token
            if(limit<=0||timeout<=0){
                return token;
            }
            String valueMaxCount = redisTemplate.opsForValue().get(maxCountKey);
            String currCount = redisTemplate.opsForValue().get(currCountKey);
            // 初始
            if(StrUtil.isBlank(valueMaxCount)&&StrUtil.isBlank(currCount)){
                // 计数加1
                redisTemplate.opsForValue().increment(currCountKey);
                redisTemplate.expire(currCountKey, timeout, TimeUnit.MILLISECONDS);
                // 总数
                redisTemplate.opsForValue().set(maxCountKey, String.valueOf(limit), timeout, TimeUnit.MILLISECONDS);
                return token;
            } else if (StrUtil.isNotBlank(valueMaxCount)&&StrUtil.isNotBlank(currCount)){
                // 判断是否超过限制
                if(StrUtil.isNotBlank(currCount)&&Integer.valueOf(currCount)<Integer.valueOf(valueMaxCount)){
                    // 计数加1
                    redisTemplate.opsForValue().increment(currCountKey);
                    // 避免key失效 上述语句未设置失效时间
                    if(redisTemplate.getExpire(currCountKey)==-1){
                        redisTemplate.delete(currCountKey);
                    }
                    return token;
                }
            } else {
                return token;
            }
        } catch (Exception e) {
            log.error("限流出错，请检查Redis运行状态\n"+e.toString());
        }
        return null;
    }
}

