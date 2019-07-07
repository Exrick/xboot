package cn.exrick.xboot.modules.your.service;

import cn.exrick.xboot.base.XbootBaseService;
import cn.exrick.xboot.modules.your.entity.Student;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import cn.exrick.xboot.common.vo.SearchVo;

import java.util.List;

/**
 * 测试接口
 * @author Exrick
 */
public interface StudentService extends XbootBaseService<Student,String> {

    /**
    * 多条件分页获取
    * @param student
    * @param searchVo
    * @param pageable
    * @return
    */
    Page<Student> findByCondition(Student student, SearchVo searchVo, Pageable pageable);
}