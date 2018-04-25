package cn.exrick.xboot.controller.manage;

import cn.exrick.xboot.base.XbootBaseController;
import cn.exrick.xboot.common.constant.CommonConstant;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.entity.User;
import cn.exrick.xboot.service.UserService;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;


/**
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "用户接口")
@RequestMapping("/user")
@CacheConfig(cacheNames = "user")
public class UserController extends XbootBaseController<User, String> {

    @Autowired
    private UserService userService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Override
    public UserService getService() {
        return userService;
    }

    @RequestMapping(value = "/regist",method = RequestMethod.POST)
    @ApiOperation(value = "注册用户")
    public Result<Object> regist(@ModelAttribute User u,
                                 @RequestParam String verify,
                                 @RequestParam String codeId){

        if(StrUtil.isBlank(verify)|| StrUtil.isBlank(u.getUsername())
                || StrUtil.isBlank(u.getPassword())){
            return new ResultUtil<Object>().setErrorMsg("缺少必需表单字段");
        }

        //验证码
        String code=redisTemplate.opsForValue().get(codeId);
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

        String encryptPass = new BCryptPasswordEncoder().encode(u.getPassword());
        u.setPassword(encryptPass);
        u.setType(CommonConstant.USER_TYPE_NORMAL);
        User user=userService.save(u);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("注册失败");
        }

        return new ResultUtil<Object>().setData(user);
    }

    @RequestMapping(value = "/info",method = RequestMethod.GET)
    @ApiOperation(value = "获取当前登录用户接口")
    public Result<Object> getUserInfo(){

        UserDetails user = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User u = userService.findByUsername(user.getUsername());
        u.setPassword(null);
        return new ResultUtil<Object>().setData(u);
    }

    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ApiOperation(value = "修改资料",notes = "用户名密码不会修改 需要通过id获取原用户信息 需要username更新缓存")
    @CacheEvict(key = "#u.username")
    public Result<Object> edit(@ModelAttribute User u){

        User old = userService.get(u.getId());
        u.setUsername(old.getUsername());
        u.setPassword(old.getPassword());

        User user=userService.update(u);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("修改失败");
        }

        return new ResultUtil<Object>().setData(user);
    }

    @RequestMapping(value = "/modifyPass",method = RequestMethod.POST)
    @ApiOperation(value = "修改密码")
    public Result<Object> modifyPass(@ApiParam("需用户id获取原用户数据") @RequestParam String id,
                                     @ApiParam("password") @RequestParam String password,
                                     @ApiParam("新密码") @RequestParam String newPass){

        User old = userService.get(id);

        String oldPass = new BCryptPasswordEncoder().encode(password);
        if(!old.getPassword().equals(oldPass)){
            return new ResultUtil<Object>().setErrorMsg("旧密码不正确");
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

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/admin/add",method = RequestMethod.POST)
    @ApiOperation(value = "添加用户")
    public Result<Object> regist(@ModelAttribute User u){

        if(StrUtil.isBlank(u.getUsername()) || StrUtil.isBlank(u.getPassword())){
            return new ResultUtil<Object>().setErrorMsg("缺少必需表单字段");
        }

        if(userService.findByUsername(u.getUsername())!=null){
            return new ResultUtil<Object>().setErrorMsg("该用户名已被注册");
        }

        String encryptPass = new BCryptPasswordEncoder().encode(u.getPassword());
        u.setPassword(encryptPass);
        User user=userService.save(u);
        if(user==null){
            return new ResultUtil<Object>().setErrorMsg("添加失败");
        }

        return new ResultUtil<Object>().setData(user);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/admin/disable",method = RequestMethod.POST)
    @ApiOperation(value = "后台禁用用户")
    public Result<Object> disable(@ApiParam("用户唯一id标识") @RequestParam String userId){

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

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/admin/enable",method = RequestMethod.POST)
    @ApiOperation(value = "后台启用用户")
    public Result<Object> enable(@ApiParam("用户唯一id标识") @RequestParam String userId){

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

}
