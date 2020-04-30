# XBoot
[![AUR](https://img.shields.io/badge/GPL-v3-red)](https://github.com/Exrick/xmall/blob/master/License)
[![](https://img.shields.io/badge/Author-Exrick-orange.svg)](http://blog.exrick.cn)
[![](https://img.shields.io/badge/version-2.0-brightgreen.svg)](https://github.com/Exrick/x-boot)
[![GitHub stars](https://img.shields.io/github/stars/Exrick/x-boot.svg?style=social&label=Stars)](https://github.com/Exrick/x-boot)
[![GitHub forks](https://img.shields.io/github/forks/Exrick/x-boot.svg?style=social&label=Fork)](https://github.com/Exrick/x-boot)

### 宣传视频
- [作者亲自制作XBoot文字快闪宣传视频](http://www.bilibili.com/av30284667)
- [作者亲自制作其他项目宣传视频](https://www.bilibili.com/video/av23121122/)
### 宣传官网
- 官网地址：http://xb.exrick.cn
- 官网源码：https://github.com/Exrick/xboot-show
### 在线Demo
- 在线Demo：http://xboot.exrick.cn
- 单点登录测试页：http://sso.exrick.cn
- 统一认证平台访问地址：http://xboot.exrick.cn/authorize
### 最新最全面在线文档
https://www.kancloud.cn/exrick/xboot/content
### 前台基于Vue+iView项目地址： [xboot-front](https://github.com/Exrick/xboot-front)
### 版本说明
- xboot-fast：单应用版本
- xboot-module：多模块版本
### 项目简介 
- [x] 代码拥有详细注释 无复杂逻辑 核心使用 SpringBoot 2.2.6.RELEASE
- [x] JWT / 基于Redis可配置单设备登录Token交互 任意切换 支持点单登录 提供开放平台
- [x] JPA + Mybatis-Plus 任意切换
- [x] 操作日志记录方式任意切换Mysql或Elasticseach记录
- [x] Java、Vue、SQL代码生成效率翻四倍
- [x] 动态权限管理、多维度轻松控制权限按钮显示、数据权限管理
- [x] 支持社交账号、短信等多方式登录 不干涉原用户数据 实现第三方账号管理
- [x] 基于Websocket消息推送管理、基于Quartz定时任务管理、数据字典管理
- [x] 后台提供分布式限流、同步锁、验证码等工具类 前端提供丰富Vue模版
- [x] 可动态配置短信、邮件、Vaptcha验证码等
- [x] 为什么要前后端分离
    - 都什么时代了还在用JQuery？ 

![](https://i.loli.net/2019/04/29/5cc70cac4b7a4.png)

### 截图预览

- PC

![QQ截图20180826163917.png](https://i.loli.net/2018/08/26/5b826868e2359.png)

![QQ截图20180826164058.png](https://i.loli.net/2018/08/26/5b8268d63d156.png)

![QQ截图20180826164144.png](https://i.loli.net/2018/08/26/5b8268e6a091f.png)

- iPad Mini 5

<img src=https://i.loli.net/2019/11/25/2tiloPbTcqfnRDQ.jpg width=600/>

- iPhone X

<img src=https://i.loli.net/2019/11/25/EaLfVxmli2Tg8PY.jpg width=300/>


### [完整版截图细节展示](https://github.com/Exrick/x-boot/wiki/%E5%AE%8C%E6%95%B4%E7%89%88%E6%88%AA%E5%9B%BE%E7%BB%86%E8%8A%82%E5%B1%95%E7%A4%BA)

### 系统架构

<img src="https://i.loli.net/2019/05/01/5cc87695f109d.png" width="600px"/>

### 前端所用技术
- Vue 2.5.x、Vue Cli 4.x、iView、iview-admin、iview-area、Vuex、Vue Router、ES6、webpack、axios、echarts、cookie等
- 前台为基于Vue+iView的独立项目请跳转至 [xboot-front](https://github.com/Exrick/xboot-front) 项目仓库查看
### 后端所用技术

<img src=https://i.loli.net/2019/11/25/gUiynavBAHd6hY8.jpg width=1000/>

##### 各框架依赖版本皆使用目前最新版本
- Spring Boot 2.2.6.RELEASE
- SpringMVC
- Spring Security
- [Spring Data JPA](https://docs.spring.io/spring-data/jpa/docs/2.2.2.RELEASE/reference/html/)
- [MyBatis-Plus](http://mp.baomidou.com)：已更新至3.x版本
- [Redis](https://github.com/Exrick/xmall/blob/master/study/Redis.md)
- [Elasticsearch](https://github.com/Exrick/xmall/blob/master/study/Elasticsearch.md)：基于Lucene分布式搜索引擎
- [Druid](http://druid.io/)：阿里高性能数据库连接池（偏监控 注重性能可使用默认HikariCP） [Druid配置官方中文文档](https://github.com/alibaba/druid/tree/master/druid-spring-boot-starter)
- [Json Web Token(JWT)](https://jwt.io/)
- [Quartz](http://www.quartz-scheduler.org)：定时任务
- [Beetl](http://ibeetl.com/guide/#beetl)：模版引擎 代码生成使用
- [Thymeleaf](https://www.thymeleaf.org/)：发送模版邮件使用
- [Hutool](http://hutool.mydoc.io/)：Java工具包
- [Jasypt](https://github.com/ulisesbocchio/jasypt-spring-boot)：配置文件加密(thymeleaf作者开发)
- [Swagger2](https://github.com/Exrick/xmall/blob/master/study/Swagger2.md)：Api文档生成
- MySQL
- [Nginx](https://github.com/Exrick/xmall/blob/master/study/Nginx.md)
- [Maven](https://github.com/Exrick/xmall/blob/master/study/Maven.md)
- 第三方SDK或服务
    - [七牛云文件存储服务](https://developer.qiniu.com/kodo/sdk/1239/java)
    - [腾讯位置服务](https://lbs.qq.com/webservice_v1/guide-ip.html)：需申请填入key后免费使用
    - 完整版
        - [Vaptcha人机验证码](https://www.vaptcha.com/)
        - [阿里云短信服务](https://dysms.console.aliyun.com)
- 其它开发工具
    - [Lombok](https://projectlombok.org/)
    - [JRebel](https://github.com/Exrick/xmall/blob/master/study/JRebel.md)：开发秒级热部署
    - [阿里JAVA开发规约插件](https://github.com/alibaba/p3c)

### 最新最全面在线文档

> 第一时间更新，文档永不收费

https://www.kancloud.cn/exrick/xboot/content

### 本地运行部署
- 安装依赖并启动：[Redis](https://github.com/Exrick/xmall/blob/master/study/Redis.md)、[Elasticsearch](https://github.com/Exrick/xmall/blob/master/study/Elasticsearch.md)(当配置使用ES记录日志时需要)
- [Maven安装和在IDEA中配置](https://github.com/Exrick/xmall/blob/master/study/Maven.md)
- 建议使用IDEA([破解/免费注册](http://idea.lanyus.com/)) 安装 `Lombok` 插件后导入该Maven项目 若未自动下载依赖请在根目录下执行 `mvn install` 命令
- MySQL数据库新建 `xboot` 数据库，配置文件已开启ddl自动生成表结构但无初始数据，请记得运行导入xboot.sql文件(当报错找不到Quartz相关表时请设置数据库忽略大小写或额外重新导入quartz.sql)
- 修改配置文件 `application.yml` 相应配置，其中有详细注释，所有配置只需在这里修改
- 编译器中启动运行 `XbootApplication.java` 或根目录下执行命令 `mvn spring-boot:run` 默认端口8888 访问接口文档 `http://localhost:8888/swagger-ui.html` 说明启动成功 管理员账密admin|123456
- 前台页面请启动基于Vue的 [xboot-front](https://github.com/Exrick/xboot-front) 项目，并修改其接口代理配置
> 温馨提示：若更新代码后报错，请记得更新sql并清空Redis缓存
### 开发指南及相关技术栈文档
- [项目基本配置和使用相关技术栈文档【必读】](https://github.com/Exrick/x-boot/wiki/%E9%A1%B9%E7%9B%AE%E5%9F%BA%E6%9C%AC%E9%85%8D%E7%BD%AE%E5%92%8C%E4%BD%BF%E7%94%A8%E7%9B%B8%E5%85%B3%E6%8A%80%E6%9C%AF%E6%A0%88%E6%96%87%E6%A1%A3%E3%80%90%E5%BF%85%E8%AF%BB%E3%80%91)
- [如何使用XBoot后端在30秒内开发出增删改接口](https://github.com/Exrick/x-boot/wiki/%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8XBoot%E5%90%8E%E7%AB%AF%E5%9C%A830%E7%A7%92%E5%86%85%E5%BC%80%E5%8F%91%E5%87%BA%E5%A2%9E%E5%88%A0%E6%94%B9%E6%8E%A5%E5%8F%A3)
- [具体XBoot增删改文档示例](https://github.com/Exrick/x-boot/wiki/CRUD)
- 完整版
    - [第三方社交账号登录配置](https://github.com/Exrick/x-boot/wiki/%E7%AC%AC%E4%B8%89%E6%96%B9%E7%A4%BE%E4%BA%A4%E8%B4%A6%E5%8F%B7%E7%99%BB%E5%BD%95%E9%85%8D%E7%BD%AE)
    - [短信登录配置](https://github.com/Exrick/x-boot/wiki/%E7%9F%AD%E4%BF%A1%E7%99%BB%E5%BD%95%E9%85%8D%E7%BD%AE)
    - [Vaptcha人机验证码配置使用](https://github.com/Exrick/x-boot/wiki/vaptcha%E4%BA%BA%E6%9C%BA%E9%AA%8C%E8%AF%81%E7%A0%81%E9%85%8D%E7%BD%AE%E4%BD%BF%E7%94%A8)
    - [Activiti工作流开发说明](https://github.com/Exrick/x-boot/wiki/Activiti%E5%B7%A5%E4%BD%9C%E6%B5%81%E5%BC%80%E5%8F%91%E8%AF%B4%E6%98%8E)

### [分布式扩展](https://github.com/alibaba/dubbo-spring-boot-starter/blob/master/README_zh.md)

### XBoot后端学习分享（更新中）
1. [Spring Boot 2.x 区别总结](https://github.com/Exrick/x-boot/wiki/SpringBoot2.x%E5%8C%BA%E5%88%AB%E6%80%BB%E7%BB%93)

2. [Spring Security整合JWT](https://github.com/Exrick/x-boot/wiki/SpringSecurity%E6%95%B4%E5%90%88JWT)

3. [Spring Security实现动态数据库权限管理](https://github.com/Exrick/x-boot/wiki/SpringSecurity%E5%8A%A8%E6%80%81%E6%9D%83%E9%99%90%E7%AE%A1%E7%90%86)

4. [Spring Boot 2.x整合Quartz](https://github.com/Exrick/x-boot/wiki/Spring-Boot-2.x%E6%95%B4%E5%90%88Quartz)

5. [基于Websocket实现发送消息后右上角消息图标红点实时显示](https://github.com/Exrick/x-boot/wiki/%E5%9F%BA%E4%BA%8EWebsocket%E5%AE%9E%E7%8E%B0%E5%8F%91%E9%80%81%E6%B6%88%E6%81%AF%E5%90%8E%E5%8F%B3%E4%B8%8A%E8%A7%92%E6%B6%88%E6%81%AF%E5%9B%BE%E6%A0%87%E7%BA%A2%E7%82%B9%E5%AE%9E%E6%97%B6%E6%98%BE%E7%A4%BA)

6. [Spring Boot 2.x整合Activiti工作流以及模型设计器](https://github.com/Exrick/x-boot/wiki/Spring-Boot-2.x%E6%95%B4%E5%90%88Activiti%E5%B7%A5%E4%BD%9C%E6%B5%81%E4%BB%A5%E5%8F%8A%E6%A8%A1%E5%9E%8B%E8%AE%BE%E8%AE%A1%E5%99%A8)
### Docker下后端集群部署(更新中)

> 前端集群部署请跳转至[xboot-front](https://github.com/Exrick/xboot-front)项目查看

1.[Docker的安装与常用命令](https://github.com/Exrick/x-boot/wiki/Docker%E7%9A%84%E5%AE%89%E8%A3%85%E4%B8%8E%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4)

2.基于PXC架构Mysql数据库集群搭建

3.Redis集群搭建

4.Elasticsearch集群搭建

5.XBoot后端集群部署

### 商用授权
- 个人学习使用遵循GPL开源协议
- 商用需联系作者授权

### 作者其他项目推荐
- [XMall微信小程序APP前端 现已开源！](https://github.com/Exrick/xmall-weapp)
    
    [![WX20190924-234416@2x.png](https://s2.ax1x.com/2019/10/06/ucEsBD.md.png)](https://www.bilibili.com/video/av70226175)

- [XMall：基于SOA架构的分布式电商购物商城](https://github.com/Exrick/xmall)

    ![](https://i.loli.net/2018/07/22/5b54615b95788.jpg)
    
- [XPay个人免签收款支付系统](https://github.com/Exrick/xpay)

- 机器学习笔记
    - [Machine-Learning](https://github.com/Exrick/Machine-Learning)
    
### 技术疑问交流
- QQ交流群 `475743731(付费)`，可获取各项目详细图文文档、疑问解答 [![](http://pub.idqqimg.com/wpa/images/group.png)](http://shang.qq.com/wpa/qunwpa?idkey=7b60cec12ba93ebed7568b0a63f22e6e034c0d1df33125ac43ed753342ec6ce7)
- 免费交流群 `562962309` [![](http://pub.idqqimg.com/wpa/images/group.png)](http://shang.qq.com/wpa/qunwpa?idkey=52f6003e230b26addeed0ba6cf343fcf3ba5d97829d17f5b8fa5b151dba7e842)
- 作者博客：[http://blog.exrick.cn](http://blog.exrick.cn)
### [捐赠](http://xpay.exrick.cn/pay)