package cn.exrick.xboot.generator;

import cn.exrick.xboot.generator.bean.Entity;
import cn.exrick.xboot.generator.bean.Item;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModelProperty;
import lombok.extern.slf4j.Slf4j;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.ClasspathResourceLoader;
import org.beetl.core.resource.FileResourceLoader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.List;

import static cn.exrick.xboot.generator.XbootGenerator.*;
import static cn.exrick.xboot.generator.XbootGenerator.name;

/**
 * 代码生成器 Mybatis-Plus
 * @author Exrickx
 */
@Slf4j
public class XbootMPGenerator {

    /**
     * 实体类名
     * 建议仅需修改
     */
    private static final String className = "Student";

    /**
     * 类说明描述
     * 建议仅需修改
     */
    private static final String description = "测试";

    /**
     * 作者名
     * 建议仅需修改
     */
    private static final String author = "Exrick";

    /**
     * 数据库表名前缀
     * 下方请根据需要修改
     */
    private static final String tablePre = "t_";

    /**
     * 主键类型
     */
    private static final String primaryKeyType = "String";

    /**
     * 生成模块路径
     * (文件自动生成至该模块下)
     */
    private static final String module = "/xboot-modules/xboot-your";

    /**
     * 实体类对应包
     * (文件自动生成至该包下)
     */
    private static final String entityPackage = "cn.exrick.xboot.your.entity";

    /**
     * dao对应包 【注意修改后需到cn.exrick.xboot.core.config.mybatisplus.MybatisPlusConfig配置你的mapper路径扫描】
     * (文件自动生成至该包下)
     */
    private static final String daoPackage = "cn.exrick.xboot.your.mapper";

    /**
     * service对应包
     * (文件自动生成至该包下)
     */
    private static final String servicePackage = "cn.exrick.xboot.your.service";

    /**
     * serviceImpl对应包
     * (文件自动生成至该包下)
     */
    private static final String serviceImplPackage = "cn.exrick.xboot.your.serviceimpl";

    /**
     * controller对应包
     * (文件自动生成至该包下)
     */
    private static final String controllerPackage = "cn.exrick.xboot.your.controller";

    /**
     * 运行该主函数即可生成代码
     * @param args
     * @throws IOException
     */
    public static void main(String[] args) throws IOException {

        // 模板路径
        String root = System.getProperty("user.dir")+"/xboot-modules/xboot-generator/src/main/java/cn/exrick/xboot/generator/template";
        FileResourceLoader resourceLoader = new FileResourceLoader(root,"utf-8");
        Configuration cfg = Configuration.defaultConfiguration();
        GroupTemplate gt = new GroupTemplate(resourceLoader, cfg);

        // 生成代码
        generateCode(gt);

        // 读取你的实体类中的字段，补充生成条件构造分页查询代码【需自行复制控制台打印输出的代码自行覆盖】
        generatePlus(gt);

        // 根据类名删除生成的代码
        //deleteCode(className);
    }

    /**
     * 生成代码
     * @param gt
     * @throws IOException
     */
    private static void generateCode(GroupTemplate gt) throws IOException{

        Template entityTemplate = gt.getTemplate("entity.btl");
        Template daoTemplate = gt.getTemplate("mapper.btl");
        Template serviceTemplate = gt.getTemplate("mpService.btl");
        Template serviceImplTemplate = gt.getTemplate("mpServiceImpl.btl");
        Template controllerTemplate = gt.getTemplate("mpController.btl");
        Template mapperXmlTemplate = gt.getTemplate("mapperXml.btl");

        Entity entity = new Entity();
        entity.setEntityPackage(entityPackage);
        entity.setDaoPackage(daoPackage);
        entity.setServicePackage(servicePackage);
        entity.setServiceImplPackage(serviceImplPackage);
        entity.setControllerPackage(controllerPackage);
        entity.setAuthor(author);
        entity.setClassName(name(className, true));
        entity.setTableName(tablePre+camel2Underline(className));
        entity.setClassNameLowerCase(name(className, false));
        entity.setDescription(description);
        entity.setPrimaryKeyType(primaryKeyType);
        entity.setIsTree(false);

        OutputStream out = null;

        //生成实体类代码
        entityTemplate.binding("entity", entity);
        String entityResult = entityTemplate.render();
        System.out.println(entityResult);
        //创建文件
        String entityFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(entityPackage) + "/" + className + ".java";
        File entityFile = new File(entityFileUrl);
        File entityDir = entityFile.getParentFile();
        if (!entityDir.exists()) {
            entityDir.mkdirs();
        }
        if(!entityFile.exists()){
            // 若文件存在则不重新生成
            entityFile.createNewFile();
            out = new FileOutputStream(entityFile);
            entityTemplate.renderTo(out);
        }

        //生成dao代码
        daoTemplate.binding("entity",entity);
        String daoResult = daoTemplate.render();
        System.out.println(daoResult);
        //创建文件
        String daoFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(daoPackage) + "/" +className + "Mapper.java";
        File daoFile = new File(daoFileUrl);
        File daoDir = daoFile.getParentFile();
        if (!daoDir.exists()) {
            daoDir.mkdirs();
        }
        if(!daoFile.exists()) {
            // 若文件存在则不重新生成
            daoFile.createNewFile();
            out = new FileOutputStream(daoFile);
            daoTemplate.renderTo(out);
        }

        //生成service代码
        serviceTemplate.binding("entity",entity);
        String serviceResult = serviceTemplate.render();
        System.out.println(serviceResult);
        //创建文件
        String serviceFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(servicePackage) + "/I" + className + "Service.java";
        File serviceFile = new File(serviceFileUrl);
        File serviceDir = serviceFile.getParentFile();
        if (!serviceDir.exists()) {
            serviceDir.mkdirs();
        }
        if(!serviceFile.exists()) {
            // 若文件存在则不重新生成
            serviceFile.createNewFile();
            out = new FileOutputStream(serviceFile);
            serviceTemplate.renderTo(out);
        }

        //生成serviceImpl代码
        serviceImplTemplate.binding("entity",entity);
        String serviceImplResult = serviceImplTemplate.render();
        System.out.println(serviceImplResult);
        //创建文件
        String serviceImplFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(serviceImplPackage) + "/I" + className + "ServiceImpl.java";
        File serviceImplFile = new File(serviceImplFileUrl);
        File serviceImplDir = serviceImplFile.getParentFile();
        if (!serviceImplDir.exists()) {
            serviceImplDir.mkdirs();
        }
        if(!serviceImplFile.exists()) {
            // 若文件存在则不重新生成
            serviceImplFile.createNewFile();
            out = new FileOutputStream(serviceImplFile);
            serviceImplTemplate.renderTo(out);
        }

        //生成controller代码
        controllerTemplate.binding("entity",entity);
        String controllerResult = controllerTemplate.render();
        System.out.println(controllerResult);
        //创建文件
        String controllerFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(controllerPackage) + "/" + className + "Controller.java";
        File controllerFile = new File(controllerFileUrl);
        File controllerDir = controllerFile.getParentFile();
        if (!controllerDir.exists()) {
            controllerDir.mkdirs();
        }
        if(!controllerFile.exists()) {
            // 若文件存在则不重新生成
            controllerFile.createNewFile();
            out = new FileOutputStream(controllerFile);
            controllerTemplate.renderTo(out);
        }

        //生成mapperXml代码
        mapperXmlTemplate.binding("entity",entity);
        String mapperXmlResult = mapperXmlTemplate.render();
        System.out.println(mapperXmlResult);
        //创建文件
        String mapperXmlFileUrl = System.getProperty("user.dir")+ module +"/src/main/resources/mapper/" + className + "Mapper.xml";
        File mapperXmlFile = new File(mapperXmlFileUrl);
        File mapperXmlDir = mapperXmlFile.getParentFile();
        if (!mapperXmlDir.exists()) {
            mapperXmlDir.mkdirs();
        }
        if(!mapperXmlFile.exists()) {
            // 若文件存在则不重新生成
            mapperXmlFile.createNewFile();
            out = new FileOutputStream(mapperXmlFile);
            mapperXmlTemplate.renderTo(out);
        }

        if(out!=null){
            out.close();
        }
        System.out.println("\n\n生成代码成功！\n\n\n");
    }

    /**
     * 删除指定类代码
     * @param className
     * @throws IOException
     */
    private static void deleteCode(String className) throws IOException{

        String entityFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(entityPackage) + "/" +className+".java";
        File entityFile = new File(entityFileUrl);
        if(entityFile.exists()){
            entityFile.delete();
        }
        String daoFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(daoPackage) + "/" +className+"Mapper.java";
        File daoFile = new File(daoFileUrl);
        if(daoFile.exists()){
            daoFile.delete();
        }

        String serviceFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(servicePackage) + "/I" +className+"Service.java";
        File serviceFile = new File(serviceFileUrl);
        if(serviceFile.exists()){
            serviceFile.delete();
        }

        String serviceImplFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(serviceImplPackage) + "/I" +className+"ServiceImpl.java";
        File serviceImplFile = new File(serviceImplFileUrl);
        if(serviceImplFile.exists()){
            serviceImplFile.delete();
        }

        String controllerFileUrl = System.getProperty("user.dir")+ module +"/src/main/java/"+ dotToLine(controllerPackage) + "/" +className+"Controller.java";
        File controllerFile = new File(controllerFileUrl);
        if(controllerFile.exists()){
            controllerFile.delete();
        }

        String mapperXmlFileUrl = System.getProperty("user.dir")+ module +"/src/main/resources/mapper/" + className + "Mapper.xml";
        File mapperXmlFile = new File(mapperXmlFileUrl);
        if(mapperXmlFile.exists()){
            mapperXmlFile.delete();
        }

        System.out.println("删除代码完毕！");
    }

    private static void generatePlus(GroupTemplate gt){

        try {
            generateMPlus(gt);
        }catch (Exception e){
            System.out.println("请确保实体类存在并且【已编译生成的模块代码】，记得完善填入字段后再生成条件构造代码哦！");
        }
    }

    private static void generateMPlus(GroupTemplate gt) throws Exception{

        Template plusTemplate = gt.getTemplate("mplus.btl");

        Entity entity = new Entity();

        entity.setClassName(name(className, true));
        entity.setClassNameLowerCase(name(className, false));
        List<Item> items = new ArrayList<>();

        String path = System.getProperty("user.dir")+ module + "/target/classes/";
        URL url = new URL("file", null, path);
        URLClassLoader classLoader = new URLClassLoader(new URL[]{url});
        Class c = classLoader.loadClass(entityPackage+"."+className);
        Object obj = c.getDeclaredConstructor().newInstance();
        java.lang.reflect.Field[] fields = obj.getClass().getDeclaredFields();

        for (int i = 0; i < fields.length; i++) {

            java.lang.reflect.Field field = fields[i];
            field.setAccessible(true);
            // 字段名
            String fieldName = field.getName();
            String fieldType = field.getType().getName();
            // 白名单
            if("serialVersionUID".equals(fieldName)){
                continue;
            }
            TableField tableField = field.getAnnotation(TableField.class);
            if(tableField!=null&&!tableField.exist()){
                continue;
            }

            // 获得字段注解
            ApiModelProperty myFieldAnnotation = field.getAnnotation(ApiModelProperty.class);
            String fieldNameCN = fieldName;
            if (myFieldAnnotation != null) {
                fieldNameCN = myFieldAnnotation.value();
            }
            fieldNameCN = (fieldNameCN == null || fieldNameCN == "") ? fieldName : fieldNameCN;

            if(fieldType.startsWith("java.lang.")){
                fieldType = StrUtil.subAfter(fieldType, "java.lang.", false);
            }

            Item item = new Item();
            item.setType(fieldType);
            item.setUpperName(name(fieldName, true));
            item.setLowerName(name(fieldName, false));
            item.setLineName(camel2Underline(fieldName));
            item.setTitle(fieldNameCN);

            items.add(item);
        }

        // 绑定参数
        plusTemplate.binding("entity", entity);
        plusTemplate.binding("items", items);
        String result = plusTemplate.render();

        System.out.println("=================================================================================");
        System.out.println("=====生成条件构造代码Plus成功！请根据需要自行复制添加以下代码至控制层方法Controller中======");
        System.out.println("=================================条件构造代码起始线=================================");

        System.out.println(result);

        System.out.println("=================================条件构造代码终止线=================================");
        System.out.println("【代码方法添加位置："+ controllerPackage + "." + className +"Controller.java】");
        System.out.println("【若未读取到字段请主动编译下生成的模块代码】");
    }
}
