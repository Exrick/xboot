package cn.exrick.xboot.generator;

import cn.exrick.xboot.common.exception.XbootException;
import cn.exrick.xboot.generator.bean.Entity;
import cn.exrick.xboot.generator.bean.Item;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.extern.slf4j.Slf4j;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.FileResourceLoader;

import javax.persistence.Transient;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * 代码生成器
 * @author Exrickx
 */
@Slf4j
public class XbootGenerator {

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
     * 是否生成树形结构相关接口
     * 建议仅需修改
     */
    private static final Boolean isTree = false;

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
     * 实体类对应包
     * (文件自动生成至该包下)
     */
    private static final String entityPackage = "cn.exrick.xboot.modules.your.entity";

    /**
     * dao对应包
     * (文件自动生成至该包下)
     */
    private static final String daoPackage = "cn.exrick.xboot.modules.your.dao";

    /**
     * service对应包
     * (文件自动生成至该包下)
     */
    private static final String servicePackage = "cn.exrick.xboot.modules.your.service";

    /**
     * serviceImpl对应包
     * (文件自动生成至该包下)
     */
    private static final String serviceImplPackage = "cn.exrick.xboot.modules.your.serviceimpl";

    /**
     * controller对应包
     * (文件自动生成至该包下)
     */
    private static final String controllerPackage = "cn.exrick.xboot.modules.your.controller";

    /**
     * 运行该主函数即可生成代码
     * @param args
     * @throws IOException
     */
    public static void main(String[] args) throws IOException {

        //模板路径
        String root = System.getProperty("user.dir")+"/src/main/java/cn/exrick/xboot/generator/template";
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
        Template daoTemplate = gt.getTemplate("dao.btl");
        Template serviceTemplate = gt.getTemplate("service.btl");
        Template serviceImplTemplate = gt.getTemplate("serviceImpl.btl");
        Template controllerTemplate = gt.getTemplate("controller.btl");
        if(isTree){
            controllerTemplate = gt.getTemplate("treeController.btl");
        }

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
        entity.setIsTree(isTree);

        OutputStream out = null;

        //生成实体类代码
        entityTemplate.binding("entity",entity);
        String entityResult = entityTemplate.render();
        System.out.println(entityResult);
        //创建文件
        String entityFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(entityPackage) + "/" + className + ".java";
        File entityFile = new File(entityFileUrl);
        File entityDir = entityFile.getParentFile();
        if (!entityDir.exists()) {
            entityDir.mkdirs();
        }
        if(!entityFile.exists()){
            //实体类若存在则不重新生成
            entityFile.createNewFile();
            out = new FileOutputStream(entityFile);
            entityTemplate.renderTo(out);
        }

        //生成dao代码
        daoTemplate.binding("entity",entity);
        String daoResult = daoTemplate.render();
        System.out.println(daoResult);
        //创建文件
        String daoFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(daoPackage) + "/" +className + "Dao.java";
        File daoFile = new File(daoFileUrl);
        File daoDir = daoFile.getParentFile();
        if (!daoDir.exists()) {
            daoDir.mkdirs();
        }
        daoFile.createNewFile();
        out = new FileOutputStream(daoFile);
        daoTemplate.renderTo(out);

        //生成service代码
        serviceTemplate.binding("entity",entity);
        String serviceResult = serviceTemplate.render();
        System.out.println(serviceResult);
        //创建文件
        String serviceFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(servicePackage) + "/" + className + "Service.java";
        File serviceFile = new File(serviceFileUrl);
        File serviceDir = serviceFile.getParentFile();
        if (!serviceDir.exists()) {
            serviceDir.mkdirs();
        }
        serviceFile.createNewFile();
        out = new FileOutputStream(serviceFile);
        serviceTemplate.renderTo(out);

        //生成serviceImpl代码
        serviceImplTemplate.binding("entity",entity);
        String serviceImplResult = serviceImplTemplate.render();
        System.out.println(serviceImplResult);
        //创建文件
        String serviceImplFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(serviceImplPackage) + "/" + className + "ServiceImpl.java";
        File serviceImplFile = new File(serviceImplFileUrl);
        File serviceImplDir = serviceImplFile.getParentFile();
        if (!serviceImplDir.exists()) {
            serviceImplDir.mkdirs();
        }
        serviceImplFile.createNewFile();
        out = new FileOutputStream(serviceImplFile);
        serviceImplTemplate.renderTo(out);

        //生成controller代码
        controllerTemplate.binding("entity",entity);
        String controllerResult = controllerTemplate.render();
        System.out.println(controllerResult);
        //创建文件
        String controllerFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(controllerPackage) + "/" + className + "Controller.java";
        File controllerFile = new File(controllerFileUrl);
        File controllerDir = controllerFile.getParentFile();
        if (!controllerDir.exists()) {
            controllerDir.mkdirs();
        }
        controllerFile.createNewFile();
        out = new FileOutputStream(controllerFile);
        controllerTemplate.renderTo(out);

        out.close();
        System.out.println("\n\n生成代码成功！\n\n\n");
    }

    /**
     * 删除指定类代码
     * @param className
     * @throws IOException
     */
    private static void deleteCode(String className) throws IOException{

        String entityFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(entityPackage) + "/" +className+".java";
        File entityFile = new File(entityFileUrl);
        if(entityFile.exists()){
            entityFile.delete();
        }
        String daoFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(daoPackage) + "/" +className+"Dao.java";
        File daoFile = new File(daoFileUrl);
        if(daoFile.exists()){
            daoFile.delete();
        }

        String serviceFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(servicePackage) + "/" +className+"Service.java";
        File serviceFile = new File(serviceFileUrl);
        if(serviceFile.exists()){
            serviceFile.delete();
        }

        String serviceImplFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(serviceImplPackage) + "/" +className+"ServiceImpl.java";
        File serviceImplFile = new File(serviceImplFileUrl);
        if(serviceImplFile.exists()){
            serviceImplFile.delete();
        }

        String controllerFileUrl = System.getProperty("user.dir")+"/src/main/java/"+ dotToLine(controllerPackage) + "/" +className+"Controller.java";
        File controllerFile = new File(controllerFileUrl);
        if(controllerFile.exists()){
            controllerFile.delete();
        }

        System.out.println("删除代码完毕！");
    }

    private static void generatePlus(GroupTemplate gt){

        try {
            generateJPAPlus(gt);
        }catch (Exception e){
            log.info("请确保实体类存在并且已完善填入字段后再生成条件构造代码哦！");
        }
    }

    private static void generateJPAPlus(GroupTemplate gt) throws Exception {

        Template plusTemplate = gt.getTemplate("plus.btl");

        Entity entity = new Entity();

        entity.setClassName(name(className, true));
        entity.setClassNameLowerCase(name(className, false));

        List<Item> items = new ArrayList<>();

        String path = entityPackage + "." + name(className, true);
        Class c = Class.forName(path);
        Object obj = c.getDeclaredConstructor().newInstance();
        java.lang.reflect.Field[] fields = obj.getClass().getDeclaredFields();

        for (int i = 0; i < fields.length; i++) {

            java.lang.reflect.Field field = fields[i];
            field.setAccessible(true);
            // 字段名
            String fieldName = field.getName();
            String fieldType = field.getType().getName();
            // 白名单
            if("serialVersionUID".equals(fieldName)||field.getAnnotation(Transient.class)!=null){
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
            }else if(fieldType.equals("java.util.Date")){
                fieldType = "Date";
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
        System.out.println("=====生成条件构造代码Plus成功！请根据需要自行复制覆盖以下代码至实现方法ServiceImpl中======");
        System.out.println("=================================条件构造代码起始线=================================");

        System.out.println(result);

        System.out.println("=================================条件构造代码终止线=================================");
        System.out.println("【代码方法覆盖位置："+ serviceImplPackage + "." + className +"ServiceImpl.java】");
    }

    /**
     * 点转斜线
     * @param str
     * @return
     */
    public static String dotToLine(String str){
        return str.replace(".", "/");
    }

    /**
     * 驼峰法转下划线
     */
    public static String camel2Underline(String str) {

        if (StrUtil.isBlank(str)) {
            return "";
        }
        if(str.length()==1){
            return str.toLowerCase();
        }
        StringBuffer sb = new StringBuffer();
        for(int i=1;i<str.length();i++){
            if(Character.isUpperCase(str.charAt(i))){
                sb.append("_"+Character.toLowerCase(str.charAt(i)));
            }else{
                sb.append(str.charAt(i));
            }
        }
        return (str.charAt(0)+sb.toString()).toLowerCase();
    }

    /**
     * 首字母是否大小写
     * @param name
     * @param isFirstUpper
     * @return
     */
    public static String name(String name, boolean isFirstUpper){

        if(StrUtil.isBlank(name)){
            throw new XbootException("name不能为空");
        }

        if(name.length()==1){
            if(isFirstUpper){
                return name.toUpperCase();
            } else {
                return name.toLowerCase();
            }
        }

        StringBuffer sb = new StringBuffer();
        if(isFirstUpper){
            sb.append(Character.toUpperCase(name.charAt(0)));
        } else {
            sb.append(Character.toLowerCase(name.charAt(0)));
        }
        sb.append(name.substring(1));
        return sb.toString();
    }
}
