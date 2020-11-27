package cn.exrick.xboot.modules.base.controller.common;

import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.hutool.http.HttpUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(tags = "Security相关接口")
@RequestMapping("/xboot/common")
@Transactional
public class SecurityController {

    @RequestMapping(value = "/needLogin", method = RequestMethod.GET)
    @ApiOperation(value = "没有登录")
    public Result<Object> needLogin() {

        return ResultUtil.error(401, "您还未登录");
    }

    @RequestMapping(value = "/swagger/login", method = RequestMethod.GET)
    @ApiOperation(value = "Swagger接口文档专用登录接口 方便测试")
    public Result<Object> swaggerLogin(@RequestParam String username, @RequestParam String password,
                                       @ApiParam("图片验证码ID") @RequestParam(required = false) String captchaId,
                                       @ApiParam("验证码") @RequestParam(required = false) String code,
                                       @ApiParam("记住密码") @RequestParam(required = false, defaultValue = "true") Boolean saveLogin,
                                       @ApiParam("可自定义登录接口地址")
                                       @RequestParam(required = false, defaultValue = "http://127.0.0.1:8888/xboot/login")
                                               String loginUrl) {

        Map<String, Object> params = new HashMap<>(16);
        params.put("username", username);
        params.put("password", password);
        params.put("captchaId", captchaId);
        params.put("code", code);
        params.put("saveLogin", saveLogin);
        String result = HttpUtil.post(loginUrl, params);
        return ResultUtil.data(result);
    }
}
