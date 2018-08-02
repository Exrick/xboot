# X-Boot
[![AUR](https://img.shields.io/aur/license/yaourt.svg)](https://github.com/Exrick/xmall/blob/master/License)
[![](https://img.shields.io/badge/Author-Exrick-orange.svg)](http://blog.exrick.cn)
[![](https://img.shields.io/badge/version-1.0-brightgreen.svg)](https://github.com/Exrick/x-boot)
[![GitHub stars](https://img.shields.io/github/stars/Exrick/x-boot.svg?style=social&label=Stars)](https://github.com/Exrick/x-boot)
[![GitHub forks](https://img.shields.io/github/forks/Exrick/x-boot.svg?style=social&label=Fork)](https://github.com/Exrick/x-boot)

> 作者大四作品 能力经验有限 如有错误欢迎指正 期待您的捐赠支持！

### [宣传视频](https://www.bilibili.com/video/av23121122/)
- 作者亲自制作 [点我观看](https://www.bilibili.com/video/av23121122/)
### 在线Demo 
http://xboot.exrick.cn
### 前台为基于Vue+iView的独立项目请跳转至 [x-boot-front](https://github.com/Exrick/x-boot-front) 项目仓库查看
### 项目简介
- [x] 代码拥有详细注释 学习与实战的不错选择
- [x] 核心使用目前最新 SpringBoot 2.0.1.RELEASE
- [x] JPA + Mybatis-Plus任意切换
    - 项目持久层默认推荐使用JPA，更简单易上手，且OOP首先应满足面向对象的要求，而不是面向数据库。复杂业务逻辑需联表查询时可选择Mybatis-Plus写sql
- [x] AOP操作日志记录方式任意切换
    - 默认使用数据库记录记录，可配置切换使用Elasticseach记录，使用Spring-Data-Elasticsearch简化开发
- [x] 极简代码生成
    - 只需输入实体类名即可生成三层代码，自动创建数据库表
- [x] 为什么要前后端分离
    - 都什么时代了还在用JQuery？ 
### 分支说明
- master：基于Redis的‘JWT’ (待提交)
- jwt：基于JWT，由于刷新token机制较麻烦，作者不推荐(待提交)
- oauth2：基于OAuth2协议(待开发)

![](https://i.loli.net/2018/07/24/5b56dfead395b.png)

![](https://i.loli.net/2018/07/24/5b56e00daab72.png)

![](https://i.loli.net/2018/07/24/5b56e06a81777.png)

![](https://i.loli.net/2018/07/24/5b56e08a4fb76.png)

![](https://i.loli.net/2018/07/24/5b56e0ac944a8.png)

![](https://i.loli.net/2018/07/24/5b56e0ce6eb53.png)

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
- [Beetl](http://ibeetl.com/guide/#beetl)：模版引擎 代码生成使用
- [Hutool](http://hutool.mydoc.io/)：Java工具包
- [Jasypt](https://github.com/ulisesbocchio/jasypt-spring-boot)：配置文件加密(thymeleaf作者开发)
- [Swagger2](https://github.com/Exrick/xmall/blob/master/study/Swagger2.md)：Api文档生成
- MySQL
- [Nginx](https://github.com/Exrick/xmall/blob/master/study/Nginx.md)
- [Maven](https://github.com/Exrick/xmall/blob/master/study/Maven.md)
- 第三方SDK
    - [七牛云文件存储服务](https://developer.qiniu.com/kodo/sdk/1239/java)
- 第三方接口
    - [Mob全国天气预报接口](http://api.mob.com/#/apiwiki/weather)：需注册账号创建应用后申请填入AppKey后免费使用
- 其它开发工具
    - Lombok
    - ~~[JRebel](https://github.com/Exrick/xmall/blob/master/study/JRebel.md)：开发热部署~~ 已无法免费使用 改回devtools
    - [阿里JAVA开发规约插件](https://github.com/alibaba/p3c)

### 项目运行部署
- 安装依赖并启动：[Redis](https://github.com/Exrick/xmall/blob/master/study/Redis.md)、[Elasticsearch](https://github.com/Exrick/xmall/blob/master/study/Elasticsearch.md)(当配置使用ES记录日志时需要)
- [Maven安装和在IDEA中配置](https://github.com/Exrick/xmall/blob/master/study/Maven.md)
- 使用IDEA([破解/免费注册](http://idea.lanyus.com/)) 导入该Maven项目
- 修改配置文件 `application.yml` 相应配置，其中有详细注释
- MySQL数据库新建 `xboot` 数据库，配置文件已开启ddl自动生成表结构但无初始数据，请记得运行导入sql文件
- 配置第三方服务
    - Mob接口 现在需要注册申请后使用 在 `cn.exrick.common.utils.IpInfoUtil` 中修改填入你的AppKey
    - 七牛云对象存储 `cn.exrick.common.utils.QiniuUtil` 中修改填入你的配置
- 启动运行 `XbootApplication.java` 默认端口8888 访问接口文档 `http://localhost:8888/swagger-ui.html` 说明启动成功 管理员账密admin|123456
- 前台页面请启动基于Vue的 [xboot-front](https://github.com/Exrick/x-boot-front) 项目，并修改其接口代理配置

### 学习记录（更新中）
1.[Spring Boot 2.x 区别总结](https://github.com/Exrick/x-boot/wiki/SpringBoot2.x%E5%8C%BA%E5%88%AB%E6%80%BB%E7%BB%93)

2.Spring Security整合JWT

3.Spring Security动态数据库权限管理

### 开发指南及相关技术栈说明
- 项目使用 [Lombok](https://projectlombok.org/) 插件简化开发，请自行在编译器中安装，不安装会报错但不影响运行，常用注解说明：
    
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
- 操作日志使用ES或数据库记录配置 注解使用 `@SystemLog(description="操作日志名称")`
```yaml
xboot:
  # 日志记录方式 true使用Elasticsearch记录 false记录至数据库中
  logRecord:
    es: false
```
- 接口相关
    - 为方便前台配置代理，所有接口建议以统一路径例如“/xboot”开头
    - 登录成功后前台请在返回的`result`字段中保存token
    
    ![](http://p77xsahe9.bkt.clouddn.com/18-6-6/65435347.jpg)
    - 之后的请求中请在header或参数中添加该token即可
    
    ![](http://p77xsahe9.bkt.clouddn.com/18-6-6/95613949.jpg)
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
- 后台开发代码生成
    - 代码生成方法在 `cn.exrick.xboot.generator` 包中的 `XbootGenerator.java` 工具类，修改好生成类配置后运行主函数main方法即可生成三层相关代码，别忘了在实体类中添加相关字段，运行项目后将自动生成数据库表
    
- 增删改查(CRUD) 
    - JPA与Mybatis-Plus随意切换
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
- Spring Security官方推荐权限管理：`@PreAuthorize("hasRole('ADMIN')")` 
- Spring定时：`@Scheduled(cron="cron表达式")` 
- Spring异步：`@Async` 

等自行了解
### 作者其他项目推荐
- [XPay个人免签收款支付系统v1.2](https://github.com/Exrick/xpay)

    - 现已支持移动端支付 手机扫码体验

    ![](http://p77xsahe9.bkt.clouddn.com/18-7-21/16350122.jpg)

- [XMall：基于SOA架构的分布式电商购物商城](https://github.com/Exrick/xmall)

    ![](https://i.loli.net/2018/07/22/5b54615b95788.jpg)

- 微信小程序APP 
    - [前台源码点我提前获取](http://xpay.exrick.cn/pay) [预览视频](https://v.qq.com/x/page/f0627kf4x1e.html)

    ![](https://i.loli.net/2018/07/21/5b52e1de385e7.png)
### 技术疑问交流
- QQ交流群 `475743731(付费)`，可获取各项目详细图文文档、疑问解答 [![](http://pub.idqqimg.com/wpa/images/group.png)](http://shang.qq.com/wpa/qunwpa?idkey=7b60cec12ba93ebed7568b0a63f22e6e034c0d1df33125ac43ed753342ec6ce7)
- 免费交流群 `562962309` [![](http://pub.idqqimg.com/wpa/images/group.png)](http://shang.qq.com/wpa/qunwpa?idkey=52f6003e230b26addeed0ba6cf343fcf3ba5d97829d17f5b8fa5b151dba7e842)
- 作者博客：[http://blog.exrick.cn](http://blog.exrick.cn)
### 捐赠
![](http://p77xsahe9.bkt.clouddn.com/18-7-20/54731550.jpg)

![](http://p77xsahe9.bkt.clouddn.com/18-6-28/32845239.jpg)