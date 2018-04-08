package cn.edu.jsu.rjxy.mappers;

import cn.edu.jsu.rjxy.entity.vo.QuestionnaireTemplate;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface QuestionnaireTemplateMapper {

  @Select("SELECT * FROM questionnaire_template WHERE id=#{id}")
  QuestionnaireTemplate getById(@Param("id") long id);

  List<QuestionnaireTemplate> getPage(@Param("step") Integer step, @Param("size") Integer size, @Param("search") String search);

  int getCount(@Param("search") String search);
}
