package cn.exrick.xboot.controller.manage;

import cn.exrick.xboot.common.constant.CommonConstant;
import cn.exrick.xboot.common.utils.PageUtil;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.PageVo;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.common.vo.SearchVo;
import cn.exrick.xboot.entity.Role;
import cn.exrick.xboot.entity.User;
import cn.exrick.xboot.entity.UserRole;
import cn.exrick.xboot.service.RoleService;
import cn.exrick.xboot.service.UserRoleService;
import cn.exrick.xboot.service.UserService;
import cn.exrick.xboot.service.mybatis.IUserRoleService;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.domain.Page;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


/**
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "用户接口")
@RequestMapping("/xboot/user")
@CacheConfig(cacheNames = "user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private IUserRoleService iUserRoleService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/regist",method = RequestMethod.POST)
    @ApiOperation(value = "注册用户")
    public Result<Object> regist(@ModelAttribute User u,
                                 @RequestParam String verify,
                                 @RequestParam String captchaId){

        if(StrUtil.isBlank(verify)|| StrUtil.isBlank(u.getUsername())
                || StrUtil.isBlank(u.getPassword())){
            return new ResultUtil<Object>().setErrorMsg("缺少必需表单字段");
        }

        //验证码
        String code=redisTemplate.opsForValue().get(captchaId);
        if(StrUtil.isBlank(code)){
            return new ResultUtil<Object>().setErrorMsg("验证码已过期，请重新获取");
        }

        if(!verify.toLowerCase().equals(code.toLowerCase())) {
            log.error("注册失败，验证码错误：code:"+ verify +",redisCode:"+code.toLowerCase());
            return new ResultUtil<Object>().setErrorMsg("验证码输入错误");
        }

        if(userService.findByUsername(u.getUsername())!=null){
            return new ResultUtil<Object>().setErrorMsg("该用户名已被注册");
        }
        //删除缓存
        redisTemplate.delete("user::"+u.getUsername());

        String encryptPass = new BCryptPasswordEncoder().encode(u.getPassword());
        u.setPassword(encryptPass);
        u.setType(CommonConstant.USER_TYPE_NORMAL);
        User user=userService.save(u);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("注册失败");
        }
        // 默认角色
        List<Role> roleList = roleService.findByDefaultRole(true);
        if(roleList!=null&&roleList.size()>0){
            for(Role role : roleList){
                UserRole ur = new UserRole();
                ur.setUserId(user.getId());
                ur.setRoleId(role.getId());
                iUserRoleService.insert(ur);
            }
        }

        return new ResultUtil<Object>().setData(user);
    }

    @RequestMapping(value = "/info",method = RequestMethod.GET)
    @ApiOperation(value = "获取当前登录用户接口")
    public Result<User> getUserInfo(){

        UserDetails user = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User u = userService.findByUsername(user.getUsername());
        u.setPassword(null);
        return new ResultUtil<User>().setData(u);
    }

    @RequestMapping(value = "/unlock",method = RequestMethod.POST)
    @ApiOperation(value = "解锁验证密码")
    public Result<Object> unLock(@RequestParam String password){

        UserDetails user = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User u = userService.findByUsername(user.getUsername());
        if(!new BCryptPasswordEncoder().matches(password, u.getPassword())){
            return new ResultUtil<Object>().setErrorMsg("密码不正确");
        }
        return new ResultUtil<Object>().setData(null);
    }

    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ApiOperation(value = "修改用户自己资料",notes = "用户名密码不会修改 需要通过id获取原用户信息 需要username更新缓存")
    @CacheEvict(key = "#u.username")
    public Result<Object> editOwn(@ModelAttribute User u){

        User old = userService.get(u.getId());
        u.setUsername(old.getUsername());
        u.setPassword(old.getPassword());
        User user=userService.update(u);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("修改失败");
        }
        return new ResultUtil<Object>().setSuccessMsg("修改成功");
    }

    /**
     * @param u
     * @param roles
     * @return
     */
    @RequestMapping(value = "/admin/edit",method = RequestMethod.POST)
    @ApiOperation(value = "修改资料",notes = "需要通过id获取原用户信息 需要username更新缓存")
    @CacheEvict(key = "#u.username")
    public Result<Object> edit(@ModelAttribute User u,
                               @RequestParam(required = false) String[] roles){

        User old = userService.get(u.getId());
        //所修改了用户名
        if(!old.getUsername().equals(u.getUsername())){
            //若修改用户名删除原用户名缓存
            redisTemplate.delete("user::"+old.getUsername());
            //判断新用户名是否存在
            if(userService.findByUsername(u.getUsername())!=null){
                return new ResultUtil<Object>().setErrorMsg("该用户名已被存在");
            }
            //删除缓存
            redisTemplate.delete("user::"+u.getUsername());
        }

        u.setPassword(old.getPassword());
        User user=userService.update(u);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("修改失败");
        }
        //删除该用户角色
        userRoleService.deleteByUserId(u.getId());
        if(roles!=null&&roles.length>0){
            //新角色
            for(String roleId : roles){
                UserRole ur = new UserRole();
                ur.setRoleId(roleId);
                ur.setUserId(u.getId());
                userRoleService.save(ur);
            }
        }
        //手动删除缓存
        redisTemplate.delete("userRole::"+u.getId());
        return new ResultUtil<Object>().setSuccessMsg("修改成功");
    }

    /**
     * 线上demo仅允许ADMIN权限改密码
     * @param id
     * @param password
     * @param newPass
     * @return
     */
    @RequestMapping(value = "/modifyPass",method = RequestMethod.POST)
    @ApiOperation(value = "修改密码")
    public Result<Object> modifyPass(@ApiParam("需用户id获取原用户数据") @RequestParam String id,
                                     @ApiParam("password") @RequestParam String password,
                                     @ApiParam("新密码") @RequestParam String newPass){

        User old = userService.get(id);

        if(!new BCryptPasswordEncoder().matches(password,old.getPassword())){
            return new ResultUtil<Object>().setErrorMsg("旧密码不正确");
        }

        //在线DEMO所需
        if("test".equals(old.getUsername())||"test2".equals(old.getUsername())){
            return new ResultUtil<Object>().setErrorMsg("演示账号不支持修改密码");
        }

        String newEncryptPass= new BCryptPasswordEncoder().encode(newPass);
        old.setPassword(newEncryptPass);
        User user=userService.update(old);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("修改失败");
        }

        //手动更新缓存
        redisTemplate.delete("user::"+user.getUsername());

        return new ResultUtil<Object>().setData(user);
    }

    @RequestMapping(value = "/getByCondition",method = RequestMethod.GET)
    @ApiOperation(value = "多条件分页获取用户列表")
    public Result<Page<User>> getByCondition(@ModelAttribute User user,
                                             @ModelAttribute SearchVo searchVo,
                                             @ModelAttribute PageVo pageVo){

        Page<User> page = userService.findByCondition(user, searchVo, PageUtil.initPage(pageVo));
        for(User u: page.getContent()){
            List<Role> list = iUserRoleService.findByUserId(u.getId());
            u.setRoles(list);
            u.setPassword(null);
        }
        return new ResultUtil<Page<User>>().setData(page);
    }

    @RequestMapping(value = "/admin/add",method = RequestMethod.POST)
    @ApiOperation(value = "添加用户")
    public Result<Object> regist(@ModelAttribute User u,
                                 @RequestParam(required = false) String[] roles){

        if(StrUtil.isBlank(u.getUsername()) || StrUtil.isBlank(u.getPassword())){
            return new ResultUtil<Object>().setErrorMsg("缺少必需表单字段");
        }

        if(userService.findByUsername(u.getUsername())!=null){
            return new ResultUtil<Object>().setErrorMsg("该用户名已被注册");
        }
        //删除缓存
        redisTemplate.delete("user::"+u.getUsername());

        String encryptPass = new BCryptPasswordEncoder().encode(u.getPassword());
        u.setPassword(encryptPass);
        User user=userService.save(u);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("添加失败");
        }
        if(roles!=null&&roles.length>0){
            //添加角色
            for(String roleId : roles){
                UserRole ur = new UserRole();
                ur.setUserId(u.getId());
                ur.setRoleId(roleId);
                userRoleService.save(ur);
            }
        }

        return new ResultUtil<Object>().setData(user);
    }

    @RequestMapping(value = "/admin/disable/{userId}",method = RequestMethod.POST)
    @ApiOperation(value = "后台禁用用户")
    public Result<Object> disable(@ApiParam("用户唯一id标识") @PathVariable String userId){

        User user=userService.get(userId);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("通过userId获取用户失败");
        }
        user.setStatus(CommonConstant.USER_STATUS_LOCK);
        userService.update(user);
        //手动更新缓存
        redisTemplate.delete("user::"+user.getUsername());
        return new ResultUtil<Object>().setData(null);
    }

    @RequestMapping(value = "/admin/enable/{userId}",method = RequestMethod.POST)
    @ApiOperation(value = "后台启用用户")
    public Result<Object> enable(@ApiParam("用户唯一id标识") @PathVariable String userId){

        User user=userService.get(userId);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("通过userId获取用户失败");
        }
        user.setStatus(CommonConstant.USER_STATUS_NORMAL);
        userService.update(user);
        //手动更新缓存
        redisTemplate.delete("user::"+user.getUsername());
        return new ResultUtil<Object>().setData(null);
    }

    @RequestMapping(value = "/delByIds",method = RequestMethod.DELETE)
    @ApiOperation(value = "批量通过ids删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id:ids){
            userService.delete(id);
            //删除关联角色
            userRoleService.deleteByUserId(id);
        }
        return new ResultUtil<Object>().setSuccessMsg("批量通过id删除数据成功");
    }

}
