package cn.exrick.xboot.modules.base.controller;

import cn.exrick.xboot.common.annotation.RateLimiter;
import cn.exrick.xboot.common.lock.Callback;
import cn.exrick.xboot.common.lock.RedisDistributedLockTemplate;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

/**
 * @author Exrickx
 */
@Slf4j
@Controller
@Api(description = "测试接口 无需登录验证")
@Transactional
@RequestMapping("/test")
public class TestController {

    @Autowired
    private RedisDistributedLockTemplate lockTemplate;

    @RequestMapping(value = "/lockAndLimit",method = RequestMethod.GET)
    @RateLimiter(limit = 1, timeout = 5000)
    @ApiOperation(value = "同步锁限流测试")
    @ResponseBody
    public Result<Object> test(){

        lockTemplate.execute("订单流水号", 5000, new Callback() {
            @Override
            public Object onGetLock() throws InterruptedException {
                //TODO 获得锁后要做的事
                log.info("生成订单流水号");
                return null;
            }

            @Override
            public Object onTimeout() throws InterruptedException {
                //TODO 获得锁超时后要做的事
                return null;
            }
        });
        return new ResultUtil<Object>().setData(null);
    }

}
