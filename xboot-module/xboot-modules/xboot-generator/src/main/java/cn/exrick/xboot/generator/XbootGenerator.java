package cn.exrick.xboot.generator;

import cn.exrick.xboot.core.common.exception.XbootException;
import cn.exrick.xboot.generator.bean.Entity;
import cn.exrick.xboot.generator.bean.Item;
import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.ClasspathResourceLoader;

import javax.persistence.Transient;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * 代码生成器 JPA
 * @author Exrickx
 */
@Slf4j
public class XbootGenerator {

    /**
     * 实体类名
     * 建议仅需修改
     */
    private static final String CLASS_NAME = "Student";

    /**
     * 类说明描述
     * 建议仅需修改
     */
    private static final String DESCRIPTION = "测试";

    /**
     * 作者名
     * 建议仅需修改
     */
    private static final String AUTHOR = "Exrick";

    /**
     * 是否生成树形结构相关接口
     * 建议仅需修改
     */
    private static final Boolean IS_TREE = false;

    /**
     * 数据库表名前缀
     * 下方请根据需要修改
     */
    private static final String TABLE_PRE = "t_";

    /**
     * 主键类型
     */
    private static final String PRIMARY_KEY_TYPE = "String";

    /**
     * 生成模块路径
     * (文件自动生成至该模块下)
     */
    private static final String MODULE = "/xboot-modules/xboot-your";

    /**
     * 实体类对应包
     * (文件自动生成至该包下)
     */
    private static final String ENTITY_PACKAGE = "cn.exrick.xboot.your.entity";

    /**
     * dao对应包
     * (文件自动生成至该包下)
     */
    private static final String DAO_PACKAGE = "cn.exrick.xboot.your.dao";

    /**
     * service对应包
     * (文件自动生成至该包下)
     */
    private static final String SERVICE_PACKAGE = "cn.exrick.xboot.your.service";

    /**
     * serviceImpl对应包
     * (文件自动生成至该包下)
     */
    private static final String SERVICE_IMPL_PACKAGE = "cn.exrick.xboot.your.serviceimpl";

    /**
     * controller对应包
     * (文件自动生成至该包下)
     */
    private static final String CONTROLLER_PACKAGE = "cn.exrick.xboot.your.controller";

    /**
     * 路径前缀
     */
    private static final String SYS_PATH = System.getProperty("user.dir") + MODULE + "/src/main/java/";

    /**
     * 运行该主函数即可生成代码
     * @param args
     * @throws IOException
     */
    public static void main(String[] args) throws Exception {

        // 模板路径
        ClasspathResourceLoader resourceLoader = new ClasspathResourceLoader("/btl/");
        Configuration cfg = Configuration.defaultConfiguration();
        GroupTemplate gt = new GroupTemplate(resourceLoader, cfg);

        // 生成代码
        generateCode(gt);

        // 读取你的实体类中的字段，补充生成条件构造分页查询代码【需自行复制控制台打印输出的代码自行覆盖】
        generatePlus(gt);

        // 根据类名删除生成的代码
        // deleteCode(className);
    }

    /**
     * 生成代码
     * @param gt
     * @throws IOException
     */
    private static void generateCode(GroupTemplate gt) throws Exception {

        Template entityTemplate = gt.getTemplate("entity.btl");
        Template daoTemplate = gt.getTemplate("dao.btl");
        Template serviceTemplate = gt.getTemplate("service.btl");
        Template serviceImplTemplate = gt.getTemplate("serviceImpl.btl");
        Template controllerTemplate = gt.getTemplate("controller.btl");
        if (Boolean.TRUE.equals(IS_TREE)) {
            controllerTemplate = gt.getTemplate("treeController.btl");
        }

        Entity entity = new Entity();
        entity.setEntityPackage(ENTITY_PACKAGE);
        entity.setDaoPackage(DAO_PACKAGE);
        entity.setServicePackage(SERVICE_PACKAGE);
        entity.setServiceImplPackage(SERVICE_IMPL_PACKAGE);
        entity.setControllerPackage(CONTROLLER_PACKAGE);
        entity.setAuthor(AUTHOR);
        entity.setClassName(name(CLASS_NAME, true));
        entity.setTableName(TABLE_PRE + camel2Underline(CLASS_NAME));
        entity.setClassNameLowerCase(name(CLASS_NAME, false));
        entity.setDescription(DESCRIPTION);
        entity.setPrimaryKeyType(PRIMARY_KEY_TYPE);
        entity.setIsTree(IS_TREE);

        OutputStream out = null;

        // 生成实体类代码
        final String varEntity = "entity";
        entityTemplate.binding(varEntity, entity);
        String entityResult = entityTemplate.render();
        log.info(entityResult);
        // 创建文件
        String entityFileUrl = SYS_PATH + dotToLine(ENTITY_PACKAGE) + "/" + name(CLASS_NAME, true) + ".java";
        File entityFile = new File(entityFileUrl);
        File entityDir = entityFile.getParentFile();
        if (!entityDir.exists()) {
            entityDir.mkdirs();
        }
        // 若文件存在则不重新生成
        if (!entityFile.exists() && entityFile.createNewFile()) {
            out = new FileOutputStream(entityFile);
            entityTemplate.renderTo(out);
        }

        // 生成dao代码
        daoTemplate.binding(varEntity, entity);
        String daoResult = daoTemplate.render();
        log.info(daoResult);
        // 创建文件
        String daoFileUrl = SYS_PATH + dotToLine(DAO_PACKAGE) + "/" + name(CLASS_NAME, true) + "Dao.java";
        File daoFile = new File(daoFileUrl);
        File daoDir = daoFile.getParentFile();
        if (!daoDir.exists()) {
            daoDir.mkdirs();
        }
        if (!daoFile.exists() && daoFile.createNewFile()) {
            // 若文件存在则不重新生成
            out = new FileOutputStream(daoFile);
            daoTemplate.renderTo(out);
        }

        // 生成service代码
        serviceTemplate.binding(varEntity, entity);
        String serviceResult = serviceTemplate.render();
        log.info(serviceResult);
        // 创建文件
        String serviceFileUrl = SYS_PATH + dotToLine(SERVICE_PACKAGE) + "/" + name(CLASS_NAME, true) + "Service.java";
        File serviceFile = new File(serviceFileUrl);
        File serviceDir = serviceFile.getParentFile();
        if (!serviceDir.exists()) {
            serviceDir.mkdirs();
        }
        if (!serviceFile.exists() && serviceFile.createNewFile()) {
            // 若文件存在则不重新生成
            out = new FileOutputStream(serviceFile);
            serviceTemplate.renderTo(out);
        }

        // 生成serviceImpl代码
        serviceImplTemplate.binding(varEntity, entity);
        String serviceImplResult = serviceImplTemplate.render();
        log.info(serviceImplResult);
        // 创建文件
        String serviceImplFileUrl = SYS_PATH + dotToLine(SERVICE_IMPL_PACKAGE) + "/" + name(CLASS_NAME, true) + "ServiceImpl.java";
        File serviceImplFile = new File(serviceImplFileUrl);
        File serviceImplDir = serviceImplFile.getParentFile();
        if (!serviceImplDir.exists()) {
            serviceImplDir.mkdirs();
        }
        if (!serviceImplFile.exists() && serviceImplFile.createNewFile()) {
            // 若文件存在则不重新生成
            out = new FileOutputStream(serviceImplFile);
            serviceImplTemplate.renderTo(out);
        }

        // 生成controller代码
        controllerTemplate.binding(varEntity, entity);
        String controllerResult = controllerTemplate.render();
        log.info(controllerResult);
        // 创建文件
        String controllerFileUrl = SYS_PATH + dotToLine(CONTROLLER_PACKAGE) + "/" + name(CLASS_NAME, true) + "Controller.java";
        File controllerFile = new File(controllerFileUrl);
        File controllerDir = controllerFile.getParentFile();
        if (!controllerDir.exists()) {
            controllerDir.mkdirs();
        }
        if (!controllerFile.exists() && controllerFile.createNewFile()) {
            // 若文件存在则不重新生成
            out = new FileOutputStream(controllerFile);
            controllerTemplate.renderTo(out);
        }

        if (out != null) {
            out.close();
        }
        log.info("生成代码成功！");
    }

    /**
     * 删除指定类代码
     * @param className
     * @throws IOException
     */
    @SneakyThrows
    private static void deleteCode(String className) {

        String entityFileUrl = SYS_PATH + dotToLine(ENTITY_PACKAGE) + "/" + name(className, true) + ".java";
        Files.delete(Paths.get(entityFileUrl));

        String daoFileUrl = SYS_PATH + dotToLine(DAO_PACKAGE) + "/" + name(className, true) + "Dao.java";
        Files.delete(Paths.get(daoFileUrl));

        String serviceFileUrl = SYS_PATH + dotToLine(SERVICE_PACKAGE) + "/" + name(className, true) + "Service.java";
        Files.delete(Paths.get(serviceFileUrl));

        String serviceImplFileUrl = SYS_PATH + dotToLine(SERVICE_IMPL_PACKAGE) + "/" + name(className, true) + "ServiceImpl.java";
        Files.delete(Paths.get(serviceImplFileUrl));

        String controllerFileUrl = SYS_PATH + dotToLine(CONTROLLER_PACKAGE) + "/" + name(className, true) + "Controller.java";
        Files.delete(Paths.get(controllerFileUrl));

        log.info("删除代码完毕！");
    }

    private static void generatePlus(GroupTemplate gt) {

        try {
            generateJPAPlus(gt);
        } catch (Exception e) {
            System.out.println("请确保实体类存在并且【已编译生成的模块代码】，记得完善填入字段后再生成条件构造代码哦！");
        }
    }

    private static void generateJPAPlus(GroupTemplate gt) throws Exception {

        Template plusTemplate = gt.getTemplate("plus.btl");

        Entity entity = new Entity();

        entity.setClassName(name(CLASS_NAME, true));
        entity.setClassNameLowerCase(name(CLASS_NAME, false));

        List<Item> items = new ArrayList<>();

        String path = ENTITY_PACKAGE + "." + name(CLASS_NAME, true);
        Class<Object> c = (Class<Object>) Class.forName(path);
        Object obj = c.getDeclaredConstructor().newInstance();
        java.lang.reflect.Field[] fields = obj.getClass().getDeclaredFields();

        for (int i = 0; i < fields.length; i++) {

            java.lang.reflect.Field field = fields[i];
            field.setAccessible(true);
            // 字段名
            String fieldName = field.getName();
            String fieldType = field.getType().getName();
            // 白名单
            if ("serialVersionUID".equals(fieldName) || field.getAnnotation(Transient.class) != null) {
                continue;
            }

            // 获得字段注解
            ApiModelProperty myFieldAnnotation = field.getAnnotation(ApiModelProperty.class);
            String fieldNameCN = fieldName;
            if (myFieldAnnotation != null) {
                fieldNameCN = myFieldAnnotation.value();
            }
            fieldNameCN = StrUtil.isBlank(fieldNameCN) ? fieldName : fieldNameCN;

            if (fieldType.startsWith("java.lang.")) {
                fieldType = StrUtil.subAfter(fieldType, "java.lang.", false);
            } else if (fieldType.equals("java.util.Date")) {
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
        System.out.println("【代码方法覆盖位置：" + SERVICE_IMPL_PACKAGE + "." + CLASS_NAME + "ServiceImpl.java】");
        System.out.println("【若未读取到字段请主动编译下生成的模块代码】");
    }


    /**
     * 点转斜线
     * @param str
     * @return
     */
    public static String dotToLine(String str) {
        return str.replace(".", "/");
    }

    /**
     * 驼峰法转下划线
     */
    public static String camel2Underline(String str) {

        if (StrUtil.isBlank(str)) {
            return "";
        }
        if (str.length() == 1) {
            return str.toLowerCase();
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 1; i < str.length(); i++) {
            if (Character.isUpperCase(str.charAt(i))) {
                sb.append("_" + Character.toLowerCase(str.charAt(i)));
            } else {
                sb.append(str.charAt(i));
            }
        }
        return (str.charAt(0) + sb.toString()).toLowerCase();
    }

    /**
     * 首字母是否大小写
     * @param name
     * @param isFirstUpper
     * @return
     */
    public static String name(String name, boolean isFirstUpper) {

        if (StrUtil.isBlank(name)) {
            throw new XbootException("name不能为空");
        }

        if (name.length() == 1) {
            if (isFirstUpper) {
                return name.toUpperCase();
            } else {
                return name.toLowerCase();
            }
        }

        StringBuilder sb = new StringBuilder();
        if (isFirstUpper) {
            sb.append(Character.toUpperCase(name.charAt(0)));
        } else {
            sb.append(Character.toLowerCase(name.charAt(0)));
        }
        sb.append(name.substring(1));
        return sb.toString();
    }
}
