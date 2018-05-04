package cn.exrick.xboot.controller.manage;

import cn.exrick.xboot.common.utils.PageUtil;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.PageVo;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.entity.elasticsearch.EsLog;
import cn.exrick.xboot.service.elasticsearch.LogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;


/**
 * 拥有ROLE_ADMIN角色的用户可以访问
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "日志管理接口")
@RequestMapping("/log")
public class LogController {

    @Autowired
    private LogService logService;

    @RequestMapping(value = "/getAllByPage",method = RequestMethod.GET)
    @ApiOperation(value = "分页获取全部")
    public Result<Page<EsLog>> getAllByPage(@ModelAttribute PageVo pageVo){

        Page<EsLog> page = logService.getLogList(PageUtil.initPage(pageVo));
        return new ResultUtil<Page<EsLog>>().setData(page);
    }

    @RequestMapping(value = "/search",method = RequestMethod.GET)
    @ApiOperation(value = "分页搜索")
    public Result<Page<EsLog>> search(@RequestParam String key, @ModelAttribute PageVo pageVo){

        Page<EsLog> page = logService.searchLog(key, PageUtil.initPage(pageVo));
        return new ResultUtil<Page<EsLog>>().setData(page);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/delByIds",method = RequestMethod.DELETE)
    @ApiOperation(value = "批量删除")
    public Result<Object> delByIds(@RequestParam String[] ids){

        for(String id : ids){
            logService.deleteLog(id);
        }
        return new ResultUtil<Object>().setSuccessMsg("删除成功");
    }

    @PreAuthorize("hasRole('ADMIN')")
    @RequestMapping(value = "/delAll",method = RequestMethod.DELETE)
    @ApiOperation(value = "全部删除")
    public Result<Object> delAll(){

        logService.deleteAll();
        return new ResultUtil<Object>().setSuccessMsg("删除成功");
    }
}
