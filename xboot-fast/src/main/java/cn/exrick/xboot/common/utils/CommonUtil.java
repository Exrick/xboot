package cn.exrick.xboot.common.utils;


import cn.exrick.xboot.common.constant.CommonConstant;
import cn.exrick.xboot.common.exception.XbootException;
import cn.hutool.core.util.StrUtil;

import java.util.Random;
import java.util.UUID;

/**
 * @author Exrickx
 */
public class CommonUtil {

    /**
     * 以UUID重命名
     *
     * @param fileName
     * @return
     */
    public static String renamePic(String fileName) {
        String extName = fileName.substring(fileName.lastIndexOf("."));
        return UUID.randomUUID().toString().replace("-", "") + extName;
    }

    /**
     * 随机6位数生成
     */
    public static String getRandomNum() {

        Random random = new Random();
        int num = random.nextInt(999999);
        //不足六位前面补0
        String str = String.format("%06d", num);
        return str;
    }

    /**
     * 批量递归删除时 判断target是否在ids中 避免重复删除
     * @param target
     * @param ids
     * @return
     */
    public static Boolean judgeIds(String target, String[] ids){

        Boolean flag = false;
        for(String id : ids){
            if(id.equals(target)){
                flag = true;
                break;
            }
        }
        return flag;
    }

    /**
     * 禁用词判断
     * @param param
     */
    public static void stopwords(String param){

        if (StrUtil.isBlank(param)) {
            return;
        }

        // 转换成小写
        param = param.toLowerCase();
        // 判断是否包含非法字符
        for (String keyword : CommonConstant.STOP_WORDS) {
            if (param.contains(keyword)) {
                throw new XbootException("名称包含禁用词：" + keyword);
            }
        }
    }
}
