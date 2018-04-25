package cn.exrick.xboot.controller;

import cn.exrick.xboot.common.annotation.RateLimiter;
import cn.exrick.xboot.common.lock.Callback;
import cn.exrick.xboot.common.lock.RedisDistributedLockTemplate;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.entity.User;
import cn.exrick.xboot.service.mybatis.IUserService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@Api(description = "测试接口")
public class TestController {

    @Autowired
    private IUserService iUserService;

    @Autowired
    private RedisDistributedLockTemplate lockTemplate;

    @RequestMapping(value = "/test",method = RequestMethod.GET)
    @RateLimiter(limit = 1, timeout = 5000)
    public Result<Object> test(){

        //MybatisPlus分页查找
        Page<User> userList = iUserService.selectPage(
                new Page<User>(1, 10),
                new EntityWrapper<User>().eq("username", "admin")
        );

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
        return new ResultUtil<Object>().setData(userList);
    }
}
