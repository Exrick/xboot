package cn.exrick.xboot.controller;

import cn.exrick.xboot.common.annotation.RateLimiter;
import cn.exrick.xboot.common.lock.Callback;
import cn.exrick.xboot.common.lock.RedisDistributedLockTemplate;
import cn.exrick.xboot.common.utils.PageUtil;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.PageVo;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.entity.User;
import cn.exrick.xboot.service.RoleService;
import cn.exrick.xboot.service.mybatis.IUserService;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "在线Demo所需接口")
public class DemoController {

    @Autowired
    private IUserService iUserService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private RedisDistributedLockTemplate lockTemplate;

    @RequestMapping(value = "/test",method = RequestMethod.GET)
    @RateLimiter(limit = 1, timeout = 5000)
    @ApiOperation(value = "同步锁限流测试")
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

    @RequestMapping(value = "/role/getAllList",method = RequestMethod.GET)
    @ApiOperation(value = "获取全部角色")
    public Result<Object> roleGetAll(){

        List<Role> list = roleService.getAll();
        return new ResultUtil<Object>().setData(list);
    }

    @RequestMapping(value = "/role/getAllByPage",method = RequestMethod.GET)
    @ApiOperation(value = "分页获取角色")
    public Result<org.springframework.data.domain.Page<Role>> getRoleByPage(@ModelAttribute PageVo page){

        org.springframework.data.domain.Page<Role> list = roleService.findAll(PageUtil.initPage(page));
        return new ResultUtil<org.springframework.data.domain.Page<Role>>().setData(list);
    }
}
