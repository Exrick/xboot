package cn.exrick.xboot.common.lock;

/**
 * 分布式锁模板类
 * @author sunyujia@aliyun.com https://github.com/yujiasun/Distributed-Kit
 * @date 2016/2/26
 */
public interface DistributedLockTemplate {

    /**
     * @param lockId 锁id(对应业务唯一ID)
     * @param timeout 单位毫秒
     * @param callback 回调函数
     * @return
     */
    public Object execute(String lockId, Integer timeout, Callback callback);
}
