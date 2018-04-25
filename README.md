# X-Boot
[![AUR](https://img.shields.io/aur/license/yaourt.svg)](https://github.com/Exrick/xmall/blob/master/License)
[![](https://img.shields.io/badge/Author-Exrick-orange.svg)](http://blog.exrick.cn)
[![](https://img.shields.io/badge/version-1.0-brightgreen.svg)](https://github.com/Exrick/x-boot)
[![GitHub stars](https://img.shields.io/github/stars/Exrick/x-boot.svg?style=social&label=Stars)](https://github.com/Exrick/x-boot)
[![GitHub forks](https://img.shields.io/github/forks/Exrick/x-boot.svg?style=social&label=Fork)](https://github.com/Exrick/x-boot)

> 作者目前大四 能力经验有限 如有错误欢迎指正期待您的捐赠支持！

### 在线Demo

### 为什么要前后端分离

- 都什么时代了还在用JQuery？ 

### 分支说明

### 前端所用技术
    
### 后端所用技术
##### 各框架依赖版本皆使用目前最新版本
- Spring Boot 2.0.1.RELEASE
- SpringMVC
- Spring Security
- [Spring Data JPA](https://docs.spring.io/spring-data/jpa/docs/2.0.6.RELEASE/reference/html/)
- [Redis](https://github.com/Exrick/xmall/blob/master/study/Redis.md)
- [MyBatis-Plus](http://mp.baomidou.com)
- [Elasticsearch](https://github.com/Exrick/xmall/blob/master/study/Elasticsearch.md)：基于Lucene分布式搜索引擎
- [Druid](http://druid.io/)：阿里高性能数据库连接池
- Json Web Token(JWT)
- [Hutool](http://hutool.mydoc.io/)：Java工具包
- [Jasypt](https://github.com/ulisesbocchio/jasypt-spring-boot)：配置文件加密(thymeleaf作者开发)
- [Swagger2](https://github.com/Exrick/xmall/blob/master/study/Swagger2.md)：Api文档生成
- MySQL
- [Nginx](https://github.com/Exrick/xmall/blob/master/study/Nginx.md)
- [Maven](https://github.com/Exrick/xmall/blob/master/study/Maven.md)
- 第三方SDK
    - [七牛云文件存储服务](https://developer.qiniu.com/kodo/sdk/1239/java)
- 第三方接口
    - [Mob全国天气预报接口](http://api.mob.com/#/apiwiki/weather)
- 其它开发工具
    - Lombok
    - [JRebel](https://github.com/Exrick/xmall/blob/master/study/JRebel.md)：开发热部署
    - [阿里JAVA开发规约插件](https://github.com/alibaba/p3c)

### 运行部署
- 下载zip直接解压或安装git后执行克隆命令 `git clone https://github.com/Exrick/xmall.git`
- 安装依赖并启动：[Redis](https://github.com/Exrick/xmall/blob/master/study/Redis.md)、[Elasticsearch](https://github.com/Exrick/xmall/blob/master/study/Elasticsearch.md)
- [Maven安装和在IDEA中配置](https://github.com/Exrick/xmall/blob/master/study/Maven.md)
- 使用IDEA([破解/免费注册](http://idea.lanyus.com/)) 导入该Maven项目 都什么时代了还用Eclipse？
- 修改配置文件 `application.yml` 相应配置，其中有详细注释
- MySQL数据库新建 `xboot` 数据库，配置文件已开启ddl自动生成表结构，当然你也可以运行sql文件(优化字段)
- 运行 `XbootApplication.java` 默认端口8888 访问接口文档 `http://localhost:8888/swagger-ui.html` 说明启动成功 管理员账密admin|123456
- 前台页面请启动基于Vue的 [xboot-front]() 项目，并修改其接口代理配置
### 开发指南及相关技术栈说明
- 项目使用Lombok插件简化开发，请自行在编译器中安装，不安装会报错但不影响运行，常用注解说明：
    
    - @Data：自动生成get、set等方法
    - @Slf4j：日志打印可直接使用log.info()等
- 配置文件可使用Jasypt加密，可到cn.exrick.xboot.common包中找到JasyptUtil工具类生成加解密结果
```yaml
# 配置文件加密key
jasypt:
  encryptor:
    password: xboot

spring:
  # 数据源
  datasource:
    url: jdbc:mysql://127.0.0.1:3306/xboot?useUnicode=true&characterEncoding=utf-8&useSSL=false
    username: root
    # Jasypt加密 可到common-utils中找到JasyptUtil加解密工具类生成加密结果 格式为ENC(加密结果)
    password: ENC(F4B0s6u9xcDw3V+P0qC4CA==)
```
- 分布式限流(基于Redis令牌桶算法)
    - 全局限流
    ```yaml
    xboot:
      # 全局限流
      rateLimit:
        enable: true
        # 每1秒内
        timeout: 1000
        # 总限制100个请求
        limit: 100
    ```
    - 指定方法限流注解
    `@RateLimiter(limit = 1, timeout = 5000)`
- 分布式同步锁(基于Redis)
```java
    @Autowired
    private RedisDistributedLockTemplate lockTemplate;

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
```
- 增删改查(CRUD)
    - 不想写sql？[Spring Data JPA](https://docs.spring.io/spring-data/jpa/docs/2.0.6.RELEASE/reference/html/#jpa.query-methods.query-creation) 了解一下
    - 复杂业务逻辑JPA联表太蛋疼？[MyBatis-Plus](http://mp.baomidou.com) 
### 技术疑问交流
- 给作者项目Star或捐赠后可加入交流群 `475743731`，还可免费获取最新源码和 [UI框架](https://github.com/Exrick/xmall/blob/master/study/FlatLab.md) [![](http://pub.idqqimg.com/wpa/images/group.png)](http://shang.qq.com/wpa/qunwpa?idkey=7b60cec12ba93ebed7568b0a63f22e6e034c0d1df33125ac43ed753342ec6ce7)
- 作者博客：[http://blog.exrick.cn](http://blog.exrick.cn)
### 捐赠
![](http://oweupqzdv.bkt.clouddn.com/FgwHSk1Rnd-8FKqNJhFSSdcq2QVB.png)