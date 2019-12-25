package cn.exrick.xboot.modules.base.controller.manage;

import cn.exrick.xboot.common.utils.PageUtil;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.PageVo;
import cn.exrick.xboot.common.vo.Result;
import cn.exrick.xboot.common.vo.SearchVo;
import cn.exrick.xboot.modules.base.vo.RedisInfo;
import cn.exrick.xboot.modules.base.vo.RedisVo;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.*;


/**
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "Redis缓存管理接口")
@RequestMapping("/xboot/redis")
@Transactional
public class RedisController {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/getAllByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取全部")
    public Result<Page<RedisVo>> getAllByPage(@RequestParam(required = false) String key,
                                              SearchVo searchVo,
                                              PageVo pageVo){

        List<RedisVo> list = new ArrayList<>();

        if(StrUtil.isNotBlank(key)){
            key = "*" + key + "*";
        }else{
            key = "*";
        }
        for (String s : redisTemplate.keys(key)) {
            RedisVo redisVo = new RedisVo(s, "");
            list.add(redisVo);
        }
        Page<RedisVo> page = new PageImpl<RedisVo>(PageUtil.listToPage(pageVo, list), PageUtil.initPage(pageVo), list.size());
        page.getContent().forEach(e->{
            String value = "";
            try {
                value =  redisTemplate.opsForValue().get(e.getKey());
                if(value.length()>150){
                    value = value.substring(0, 149) + "...";
                }
            } catch (Exception exception){
                value = "非字符格式数据";
            }
            e.setValue(value);
        });
        return new ResultUtil<Page<RedisVo>>().setData(page);
    }

    @RequestMapping(value = "/getByKey/{key}", method = RequestMethod.GET)
    @ApiOperation(value = "通过key获取")
    public Result<Object> getByKey(@PathVariable String key){

        String value = redisTemplate.opsForValue().get(key);
        return ResultUtil.data(value);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ApiOperation(value = "添加或编辑")
    public Result<Object> save(@RequestParam String key,
                               @RequestParam String value){

        redisTemplate.opsForValue().set(key ,value);
        return ResultUtil.success("删除成功");
    }

    @RequestMapping(value = "/delByKeys", method = RequestMethod.DELETE)
    @ApiOperation(value = "批量删除")
    public Result<Object> delByKeys(@RequestParam String[] keys){

        for(String key : keys){
            redisTemplate.delete(key);
        }
        return ResultUtil.success("删除成功");
    }

    @RequestMapping(value = "/delAll", method = RequestMethod.DELETE)
    @ApiOperation(value = "全部删除")
    public Result<Object> delAll(){

        redisTemplate.delete(redisTemplate.keys("*"));
        return ResultUtil.success("删除成功");
    }

    @RequestMapping(value = "/getKeySize", method = RequestMethod.GET)
    @ApiOperation(value = "获取实时key大小")
    public Result<Object> getKeySize(){

        Map<String, Object> map = new HashMap<>(16);
        map.put("keySize", redisTemplate.getConnectionFactory().getConnection().dbSize());
        map.put("time", DateUtil.format(new Date(), "HH:mm:ss"));
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/getMemory", method = RequestMethod.GET)
    @ApiOperation(value = "获取实时内存大小")
    public Result<Object> getMemory(){

        Map<String, Object> map = new HashMap<>(16);
        Properties memory = redisTemplate.getConnectionFactory().getConnection().info("memory");
        map.put("memory", memory.get("used_memory"));
        map.put("time", DateUtil.format(new Date(), "HH:mm:ss"));
        return ResultUtil.data(map);
    }

    @RequestMapping(value = "/info", method = RequestMethod.GET)
    @ApiOperation(value = "获取Redis信息")
    public Result<Object> info(){

        List<RedisInfo> infoList = new ArrayList<>();
        Properties properties = redisTemplate.getConnectionFactory().getConnection().info();
        Set<Object> keys = properties.keySet();
        for(Object key : keys){
            String value = properties.get(key).toString();
            RedisInfo redisInfo = new RedisInfo();
            redisInfo.setKey(key.toString());
            redisInfo.setValue(value);
            infoList.add(redisInfo);
        }
        return ResultUtil.data(infoList);
    }
}
