package cn.exrick.xboot.common.aop;

import cn.exrick.xboot.common.annotation.SystemLog;
import cn.exrick.xboot.common.utils.IpInfoUtil;
import cn.exrick.xboot.common.utils.ObjectUtil;
import cn.exrick.xboot.common.utils.ThreadPoolUtil;
import cn.exrick.xboot.modules.base.entity.Log;
import cn.exrick.xboot.modules.base.entity.elasticsearch.EsLog;
import cn.exrick.xboot.modules.base.service.LogService;
import cn.exrick.xboot.modules.base.service.elasticsearch.EsLogService;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.NamedThreadLocal;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Spring AOP实现日志管理
 * @author Exrickx
 */
@Aspect
@Component
@Slf4j
public class SystemLogAspect {

    private static final ThreadLocal<Date> THREAD_LOCAL_BEGIN_TIME = new NamedThreadLocal<>("ThreadLocal beginTime");

    @Value("${xboot.logRecord.es:false}")
    private Boolean esRecord;

    @Autowired
    private EsLogService esLogService;

    @Autowired
    private LogService logService;

    @Autowired(required = false)
    private HttpServletRequest request;

    @Autowired
    private IpInfoUtil ipInfoUtil;

    /**
     * Controller层切点,注解方式
     */
    // @Pointcut("execution(* *..controller..*Controller*.*(..))")
    @Pointcut("@annotation(cn.exrick.xboot.common.annotation.SystemLog)")
    public void controllerAspect() {

    }

    /**
     * 前置通知 (在方法执行之前返回)用于拦截Controller层记录用户的操作的开始时间
     * @param joinPoint 切点
     * @throws InterruptedException
     */
    @Before("controllerAspect()")
    public void doBefore(JoinPoint joinPoint) {

        // 线程绑定变量（该数据只有当前请求的线程可见）
        Date beginTime = new Date();
        THREAD_LOCAL_BEGIN_TIME.set(beginTime);
    }


    /**
     * 后置通知(在方法执行之后并返回数据) 用于拦截Controller层无异常的操作
     * @param joinPoint 切点
     */
    @AfterReturning("controllerAspect()")
    public void after(JoinPoint joinPoint) {

        try {
            String username = "";
            String description = getControllerMethodInfo(joinPoint).get("description").toString();
            int type = (int) getControllerMethodInfo(joinPoint).get("type");
            Map<String, String[]> logParams = request.getParameterMap();
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated() || authentication.getName() == null
                    || (authentication instanceof AnonymousAuthenticationToken)) {
                return;
            }
            username = authentication.getName();
            if (esRecord) {
                EsLog esLog = new EsLog();

                // 请求用户
                esLog.setUsername(username);
                // 日志标题
                esLog.setName(description);
                // 日志类型
                esLog.setLogType(type);
                // 日志请求url
                esLog.setRequestUrl(request.getRequestURI());
                // 请求方式
                esLog.setRequestType(request.getMethod());
                // 请求参数
                esLog.setMapToParams(logParams);
                ipInfoUtil.getInfo(request, ObjectUtil.mapToStringAll(request.getParameterMap()));
                // 请求IP
                esLog.setIp(ipInfoUtil.getIpAddr(request));
                // IP地址
                esLog.setIpInfo(ipInfoUtil.getIpCity(request));
                // 请求开始时间
                long beginTime = THREAD_LOCAL_BEGIN_TIME.get().getTime();
                long endTime = System.currentTimeMillis();
                // 请求耗时
                Long logElapsedTime = endTime - beginTime;
                esLog.setCostTime(logElapsedTime.intValue());

                // 调用线程保存至ES
                ThreadPoolUtil.getPool().execute(new SaveEsSystemLogThread(esLog, esLogService));
            } else {
                Log log = new Log();

                // 请求用户
                log.setUsername(username);
                // 日志标题
                log.setName(description);
                // 日志类型
                log.setLogType(type);
                // 日志请求url
                log.setRequestUrl(request.getRequestURI());
                // 请求方式
                log.setRequestType(request.getMethod());
                // 请求参数
                log.setMapToParams(logParams);
                ipInfoUtil.getInfo(request, ObjectUtil.mapToStringAll(request.getParameterMap()));
                // 请求IP
                log.setIp(ipInfoUtil.getIpAddr(request));
                // IP地址
                log.setIpInfo(ipInfoUtil.getIpCity(request));
                // 请求开始时间
                long beginTime = THREAD_LOCAL_BEGIN_TIME.get().getTime();
                long endTime = System.currentTimeMillis();
                // 请求耗时
                Long logElapsedTime = endTime - beginTime;
                log.setCostTime(logElapsedTime.intValue());

                // 调用线程保存至ES
                ThreadPoolUtil.getPool().execute(new SaveSystemLogThread(log, logService));
            }
            THREAD_LOCAL_BEGIN_TIME.remove();
        } catch (Exception e) {
            log.error("AOP后置通知异常", e);
        }
    }

    /**
     * 保存日志至ES
     */
    private static class SaveEsSystemLogThread implements Runnable {

        private EsLog esLog;
        private EsLogService esLogService;

        public SaveEsSystemLogThread(EsLog esLog, EsLogService esLogService) {
            this.esLog = esLog;
            this.esLogService = esLogService;
        }

        @Override
        public void run() {

            esLogService.saveLog(esLog);
        }
    }

    /**
     * 保存日志至数据库
     */
    private static class SaveSystemLogThread implements Runnable {

        private Log log;
        private LogService logService;

        public SaveSystemLogThread(Log esLog, LogService logService) {
            this.log = esLog;
            this.logService = logService;
        }

        @Override
        public void run() {

            logService.save(log);
        }
    }

    /**
     * 获取注解中对方法的描述信息 用于Controller层注解
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception
     */
    public static Map<String, Object> getControllerMethodInfo(JoinPoint joinPoint) throws ClassNotFoundException {

        Map<String, Object> map = new HashMap<>(16);
        //获取目标类名
        String targetName = joinPoint.getTarget().getClass().getName();
        //获取方法名
        String methodName = joinPoint.getSignature().getName();
        //获取相关参数
        Object[] arguments = joinPoint.getArgs();
        //生成类对象
        Class targetClass = Class.forName(targetName);
        //获取该类中的方法
        Method[] methods = targetClass.getMethods();

        String description = "";
        Integer type = null;

        for (Method method : methods) {
            if (!method.getName().equals(methodName)) {
                continue;
            }
            Class[] clazzs = method.getParameterTypes();
            if (clazzs.length != arguments.length) {
                //比较方法中参数个数与从切点中获取的参数个数是否相同，原因是方法可以重载哦
                continue;
            }
            description = method.getAnnotation(SystemLog.class).description();
            type = method.getAnnotation(SystemLog.class).type().ordinal();
            map.put("description", description);
            map.put("type", type);
        }
        return map;
    }
}
