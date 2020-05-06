package cn.exrick.xboot.common.exception;

import cn.exrick.xboot.common.utils.ResultUtil;
import cn.exrick.xboot.common.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * @author Exrickx
 */
@Slf4j
@RestControllerAdvice
public class RestCtrlExceptionHandler {

    @ExceptionHandler(XbootException.class)
    @ResponseStatus(value = HttpStatus.OK)
    public Result<Object> handleXbootException(XbootException e) {

        String errorMsg = "XBoot exception";
        if (e!=null){
            errorMsg = e.getMsg();
            log.error(e.toString(), e);
        }
        return new ResultUtil<>().setErrorMsg(500, errorMsg);
    }

    @ExceptionHandler(BindException.class)
    @ResponseStatus(value = HttpStatus.OK)
    public Result<Object> handleBindException(BindException e) {

        StringBuilder sb = new StringBuilder();
        e.getFieldErrors().forEach(error->{
            String fieldName = error.getField();
            String message = error.getDefaultMessage();
            sb.append(fieldName + "-" + message + "；");
        });
        String result = sb.toString();
        if(result.length()>0){
            result = result.substring(0, result.length()-1);
        }
        return new ResultUtil<>().setErrorMsg(500, result);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(value = HttpStatus.OK)
    public Result<Object> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {

        StringBuilder sb = new StringBuilder();
        e.getBindingResult().getFieldErrors().forEach(error->{
            String fieldName = error.getField();
            String message = error.getDefaultMessage();
            sb.append(fieldName + "-" + message + "；");
        });
        String result = sb.toString();
        if(result.length()>0){
            result = result.substring(0, result.length()-1);
        }
        return new ResultUtil<>().setErrorMsg(500, result);
    }

    @ExceptionHandler(LimitException.class)
    @ResponseStatus(value = HttpStatus.OK)
    public Result<Object> handleLimitException(LimitException e) {

        String errorMsg = "Limit exception";
        if (e!=null){
            errorMsg = e.getMsg();
            log.warn(e.getMsg(), e);
        }
        return new ResultUtil<>().setErrorMsg(500, errorMsg);
    }

    @ExceptionHandler(CaptchaException.class)
    @ResponseStatus(value = HttpStatus.OK)
    public Result<Object> handleCaptchaExceptionException(CaptchaException e) {

        String errorMsg = "CaptchaException exception";
        if (e!=null){
            errorMsg = e.getMsg();
            log.warn(e.getMsg(), e);
        }
        return new ResultUtil<>().setErrorMsg(500, errorMsg);
    }

    @ExceptionHandler(AccessDeniedException.class)
    @ResponseStatus(value = HttpStatus.OK)
    public Result<Object> handleAccessDeniedExceptionException(AccessDeniedException e) {

        String errorMsg = "AccessDeniedException exception";
        if (e!=null){
            errorMsg = e.getMessage();
            log.warn(e.getMessage(), e);
        }
        return new ResultUtil<>().setErrorMsg(500, errorMsg);
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(value = HttpStatus.OK)
    public Result<Object> handleException(Exception e) {

        String errorMsg = "Exception";
        if (e!=null){
            errorMsg = e.getMessage();
            log.error(e.toString(), e);
        }
        return new ResultUtil<>().setErrorMsg(500, errorMsg);
    }
}
