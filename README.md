# X-Boot
[![AUR](https://img.shields.io/aur/license/yaourt.svg)](https://github.com/Exrick/xmall/blob/master/License)
[![](https://img.shields.io/badge/Author-Exrick-orange.svg)](http://blog.exrick.cn)
[![](https://img.shields.io/badge/version-1.0-brightgreen.svg)](https://github.com/Exrick/x-boot)
[![GitHub stars](https://img.shields.io/github/stars/Exrick/x-boot.svg?style=social&label=Stars)](https://github.com/Exrick/x-boot)
[![GitHub forks](https://img.shields.io/github/forks/Exrick/x-boot.svg?style=social&label=Fork)](https://github.com/Exrick/x-boot)

> 作者目前大四 能力经验有限 如有错误欢迎指正 期待您的捐赠支持！

### [宣传视频](https://www.bilibili.com/video/av23121122/)
- 作者亲自制作 可接单做视频... 视频已上传至[B站](https://www.bilibili.com/video/av23121122/)
### 在线Demo 
http://xboot.exrick.cn
### 前台为基于Vue+iView的独立项目请跳转至 [x-boot-front](https://github.com/Exrick/x-boot-front) 项目仓库查看
### 项目简介
- 代码拥有详细注释 学习与实战的不错选择
- 核心使用目前最新 SpringBoot 2.0.1.RELEASE
- JPA + Mybatis-Plus 任意切换
    - 项目持久层默认推荐使用JPA，更简单易上手，且OOP首先应满足面向对象的要求，而不是面向数据库。但遇到复杂业务逻辑需联表查询时可选择Mybatis-Plus写sql
- AOP操作日志默认已使用Elasticseach全文检索引擎记录，使用Spring Data Elasticsearch简化开发
- 为什么要前后端分离
    - 都什么时代了还在用JQuery？ 
### 分支说明
- master：基于Redis的‘JWT’ (待提交)
- jwt：基于JWT，由于刷新token机制较麻烦，作者不推荐(待提交)
- oauth2：基于OAuth2协议(待开发)

![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20180504215410.png)

![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20180504215449.png)

![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20180504215601.png)

![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20180504215541.png)

![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20180504215621.png)

![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20180504215656.png)

### 前端所用技术
- Vue 2.5.x、iView、iview-admin、iview-area、Vuex、Vue Router、ES6、webpack、axios、echarts、cookie等
- 前台为基于Vue+iView的独立项目请跳转至 [x-boot-front](https://github.com/Exrick/x-boot-front) 项目仓库查看
### 后端所用技术
##### 各框架依赖版本皆使用目前最新版本
- Spring Boot 2.0.1.RELEASE
- SpringMVC
- Spring Security
- [Spring Data JPA](https://docs.spring.io/spring-data/jpa/docs/2.0.6.RELEASE/reference/html/)
- [MyBatis-Plus](http://mp.baomidou.com)
- [Redis](https://github.com/Exrick/xmall/blob/master/study/Redis.md)
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

### 项目运行部署
- 安装依赖并启动：[Redis](https://github.com/Exrick/xmall/blob/master/study/Redis.md)、[Elasticsearch](https://github.com/Exrick/xmall/blob/master/study/Elasticsearch.md)(非必需，但影响日志功能)
- [Maven安装和在IDEA中配置](https://github.com/Exrick/xmall/blob/master/study/Maven.md)
- 使用IDEA([破解/免费注册](http://idea.lanyus.com/)) 导入该Maven项目 都什么时代了还用Eclipse？
- 修改配置文件 `application.yml` 相应配置，其中有详细注释
- MySQL数据库新建 `xboot` 数据库，配置文件已开启ddl自动生成表结构但无初始数据，请记得运行导入sql文件
- 启动运行 `XbootApplication.java` 默认端口8888 访问接口文档 `http://localhost:8888/swagger-ui.html` 说明启动成功 管理员账密admin|123456
- 前台页面请启动基于Vue的 [xboot-front](https://github.com/Exrick/x-boot-front) 项目，并修改其接口代理配置

### 学习记录（更新中）
1.[Spring Boot 2.x 区别总结](https://github.com/Exrick/x-boot/wiki/SpringBoot2.x%E5%8C%BA%E5%88%AB%E6%80%BB%E7%BB%93)

2.Spring Security整合JWT

### 开发指南及相关技术栈说明
- 项目使用 Lombok 插件简化开发，请自行在编译器中安装，不安装会报错但不影响运行，常用注解说明：
    
    - `@Data`：自动生成get、set等方法
    - `@Slf4j`：日志打印可直接使用log.info()等
    
- 配置文件可使用Jasypt加密，可到 `cn.exrick.xboot.common` 包中找到 JasyptUtil 工具类生成加解密结果
```yaml
# 配置文件加密key
jasypt:
  encryptor:
    password: xboot

spring:
  # 数据源
  datasource:
    # Jasypt加密 可到common-utils中找到JasyptUtil加解密工具类生成加密结果 格式为ENC(加密结果)
    password: ENC(F4B0s6u9xcDw3V+P0qC4CA==)
```
- 接口相关
    - 登录成功后前台请在返回的`result`字段中保存token
    
    ![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20180505113233.png)
    - 之后的请求中请在header中放入该token即可
    
    ![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20180505113302.png)
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
    ```java
    @RateLimiter(limit = 1, timeout = 5000)
    ```
    - 支持多维度IP、uid等限流 详见代码
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
    - JPA与MybatisPlus随意切换
    - 不想写sql？[Spring Data JPA](https://docs.spring.io/spring-data/jpa/docs/2.0.6.RELEASE/reference/html/#jpa.query-methods.query-creation) 了解一下
        
        [具体x-boot增删改文档示例](https://github.com/Exrick/x-boot/wiki/CRUD)
    - 复杂业务逻辑JPA联表太蛋疼？[MyBatis-Plus](http://mp.baomidou.com) 这就不用了解了吧
    - JPA与MybatisPlus同时使用时需注意实体类注解区别，更多请见官方文档，常用注解区别：
    ```java
    //表名
    JPA: @Table(name = "t_user")
    MP:  @TableName("t_user")
    //排除非表字段
    JPA: @Transient
    MP:  @TableField(exist=false)
    ```
- Spring缓存注解
    ```java
    @CacheConfig(cacheNames = "user")
    public interface UserService extends XbootBaseService<User,String> {
        @Cacheable(key = "#username")
        User findByUsername(String username);
    }
    ```
    - 删除刷新注解 `@CacheEvict(key = "#u.username")` 手动删除刷新缓存时注意key为：`user::username`
- Spring Security权限：`@PreAuthorize("hasRole('ADMIN')")` 
- Spring定时：`@Scheduled(cron="cron表达式")` 
- Spring异步：`@Async` 

等自行了解
### 作者其他项目推荐
- [XMall：基于SOA架构的分布式电商购物商城](https://github.com/Exrick/xmall)

    ![](http://oweupqzdv.bkt.clouddn.com/QQ%E6%88%AA%E5%9B%BE20171022183906.jpg)
    
- 微信小程序APP 
    - 捐赠≥19.9可加群私聊群主提前下载前台源码[预览视频](https://v.qq.com/x/page/f0627kf4x1e.html) 赠送[慕课网SpringCloud学习资源](https://coding.imooc.com/class/187.html) 

    ![](http://oweupqzdv.bkt.clouddn.com/%E5%B0%8F%E7%A8%8B%E5%BA%8F%E9%A2%84%E8%A7%881.png)
### 技术疑问交流
- 给作者项目Star或捐赠后可加入交流群 `475743731`，还可免费获取 [慕课网学习资源](https://coding.imooc.com/class/203.html) 和 [UI框架](https://github.com/Exrick/xmall/blob/master/study/FlatLab.md) [![](http://pub.idqqimg.com/wpa/images/group.png)](http://shang.qq.com/wpa/qunwpa?idkey=7b60cec12ba93ebed7568b0a63f22e6e034c0d1df33125ac43ed753342ec6ce7)
- 作者博客：[http://blog.exrick.cn](http://blog.exrick.cn)
### 捐赠
![](http://oweupqzdv.bkt.clouddn.com/FgwHSk1Rnd-8FKqNJhFSSdcq2QVB.png)