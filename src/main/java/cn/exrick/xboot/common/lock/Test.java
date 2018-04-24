package cn.exrick.xboot.common.lock;

import lombok.extern.slf4j.Slf4j;
import redis.clients.jedis.JedisPool;

@Slf4j
public class Test {

    public static void main(String[] args){

        final RedisDistributedLockTemplate template=new RedisDistributedLockTemplate();//本类线程安全,可通过spring注入
        template.execute("订单流水号", 5000, new Callback() {//获取锁超时时间为5秒
            @Override
            public Object onGetLock() throws InterruptedException {
                //TODO 获得锁后要做的事
                log.info("执行");
                return null;
            }

            @Override
            public Object onTimeout() throws InterruptedException {
                //TODO 获得锁超时后要做的事
                return null;
            }
        });
    }
}
