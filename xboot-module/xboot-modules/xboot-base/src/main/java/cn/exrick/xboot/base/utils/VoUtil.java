package cn.exrick.xboot.base.utils;

import cn.exrick.xboot.base.vo.MenuVo;
import cn.exrick.xboot.core.entity.Permission;
import cn.hutool.core.bean.BeanUtil;

/**
 * @author Exrick
 */
public class VoUtil {

    public static MenuVo permissionToMenuVo(Permission p){

        MenuVo menuVo = new MenuVo();
        BeanUtil.copyProperties(p, menuVo);
        return menuVo;
    }
}
