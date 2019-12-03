package cn.exrick.xboot.common.lock;

/**
 * @author sunyujia@aliyun.com https://github.com/yujiasun/Distributed-Kit
 */
public interface Callback {

    /**
     * 成功获取锁后执行方法
     * @return
     * @throws InterruptedException
     */
    Object onGetLock() throws InterruptedException;

    /**
     * 获取锁超时回调
     * @return
     * @throws InterruptedException
     */
    Object onTimeout() throws InterruptedException;
}
