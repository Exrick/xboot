package cn.exrick.xboot.common.lock;

import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

/**
 * @author Exrick
 */
@Slf4j
@Component
public class RedisLockTemplate implements DistributedLockTemplate {

    @Autowired
    private RedissonClient redisson;

    @Override
    public Object execute(String lockId, Integer timeout, Integer leaseTime, TimeUnit unit, Callback callback) {

        if (timeout == null) {
            timeout = 0;
        }
        RLock lock = null;
        boolean getLock = false;
        try {
            lock = redisson.getLock(lockId);
            if (leaseTime == null || leaseTime <= 0) {
                getLock = lock.tryLock(timeout, unit);
            } else {
                getLock = lock.tryLock(timeout, leaseTime, unit);
            }
            if (getLock) {
                // 拿到锁
                return callback.onGetLock();
            } else {
                // 未拿到锁
                return callback.onTimeout();
            }
        } catch (InterruptedException ex) {
            log.error(ex.getMessage(), ex);
            Thread.currentThread().interrupt();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            if (getLock) {
                // 释放锁
                lock.unlock();
            }
        }
        return null;
    }
}
