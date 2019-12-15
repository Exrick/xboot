package cn.exrick.xboot.common.lock;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.integration.redis.util.RedisLockRegistry;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;


/**
 * @author Exrick
 */
@Slf4j
@Component
public class RedisLockTemplate implements DistributedLockTemplate {

    @Autowired
    private RedisLockRegistry redisLockRegistry;

    @Override
    public Object execute(String lockId, Integer timeout, TimeUnit unit, Callback callback) {

        Lock lock = null;
        boolean getLock = false;
        try {
            lock = redisLockRegistry.obtain(lockId);
            getLock = lock.tryLock(timeout, unit);
            if(getLock){
                // 拿到锁
                return callback.onGetLock();
            }else{
                // 未拿到锁
                return callback.onTimeout();
            }
        }catch(InterruptedException ex){
            log.error(ex.getMessage(), ex);
            Thread.currentThread().interrupt();
        }catch (Exception e) {
            log.error(e.getMessage(), e);
        }finally {
            if(getLock) {
                // 释放锁
                lock.unlock();
            }
        }
        return null;
    }
}
