package cn.exrick.xboot.controller.common;

import cn.exrick.xboot.common.utils.QiniuUtil;
import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.FileInputStream;

/**
 * @author Exrickx
 */
@Slf4j
@RestController
@Api(description = "文件上传接口")
@RequestMapping("/upload")
@CrossOrigin
public class UploadController {

    @RequestMapping(value = "/file",method = RequestMethod.POST)
    @ApiOperation(value = "文件上传")
    public Result<Object> upload(@RequestParam("file") MultipartFile file,
                                 HttpServletRequest request) {

        String imagePath = null;
        String fileName = QiniuUtil.renamePic(file.getOriginalFilename());
        try {
            FileInputStream inputStream = (FileInputStream) file.getInputStream();
            //上传七牛云服务器
            imagePath= QiniuUtil.qiniuInputStreamUpload(inputStream,fileName);
            if(StrUtil.isBlank(imagePath)){
                return new ResultUtil<Object>().setErrorMsg("上传失败，请检查七牛云配置");
            }
        } catch (Exception e) {
            log.error(e.toString());
        }

        return new ResultUtil<Object>().setData(imagePath);
    }
}
