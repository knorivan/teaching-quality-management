package cn.edu.jsu.rjxy.service;

import cn.edu.jsu.rjxy.entity.dto.EvaluateReaderDTO;
import cn.edu.jsu.rjxy.entity.vo.Evaluate;
import cn.edu.jsu.rjxy.entity.vo.Metadata;
import cn.edu.jsu.rjxy.entity.vo.ScoreForTeacher;
import cn.edu.jsu.rjxy.mappers.EvaluateMapper;
import cn.edu.jsu.rjxy.mappers.RegisterMapper;
import cn.edu.jsu.rjxy.mappers.ScoreForTeacherMapper;
import cn.edu.jsu.rjxy.mappers.StudentMapper;
import cn.edu.jsu.rjxy.mappers.MetadataMapper;
import cn.edu.jsu.rjxy.mappers.TeacherMapper;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service
public class EvaluateService {

  private static final String DEFAULT_TYPE = "all";
  private static final String EVALUATE_REGISTER_TYPE = "register";
  private static final String EVALUATE_TEACHER_TYPE = "teacher";
  private static final String EVALUATE_STUDENT_TYPE = "student";

  @Autowired
  private EvaluateMapper evaluateMapper;
  @Autowired
  private RegisterMapper registerMapper;
  @Autowired
  private TeacherMapper teacherMapper;
  @Autowired
  private StudentMapper studentMapper;
  @Autowired
  private MetadataMapper metadataMapper;
  @Autowired
  private ScoreForTeacherMapper scoreForTeacherMapper;

  public Evaluate getEvaluateById(long id) {
    return evaluateMapper.getById(id);
  }

  public List<EvaluateReaderDTO> getScoreEvaluates(long scoreForTeacherId, String type,
      Integer index, Integer size) {
    if (DEFAULT_TYPE.equals(type)) {
      type = null;
    }
    Integer step = null;
    if (index != null) {
      step = (index - 1) * size;
    }

    List<Evaluate> evaluates = evaluateMapper
        .getScoreEvaluates(scoreForTeacherId, type, step, size);

    List<EvaluateReaderDTO> readers = new ArrayList<>();
    for (Evaluate evaluate : evaluates) {
      if (EVALUATE_REGISTER_TYPE.equals(evaluate.getCreaterType())) {
        readers.add(new EvaluateReaderDTO(evaluate,
            metadataMapper.getEvaluateResultByValue(evaluate.getResult()),
            registerMapper.getById(evaluate.getCreater())));
      } else if (EVALUATE_TEACHER_TYPE.equals(evaluate.getCreaterType())) {
        readers.add(new EvaluateReaderDTO(evaluate,
            metadataMapper.getEvaluateResultByValue(evaluate.getResult()),
            teacherMapper.getById(evaluate.getCreater())));
      } else if (EVALUATE_STUDENT_TYPE.equals(evaluate.getCreaterType())) {
        readers.add(new EvaluateReaderDTO(evaluate,
            metadataMapper.getEvaluateResultByValue(evaluate.getResult()),
            studentMapper.getById(evaluate.getCreater())));
      }
    }
    return readers;
  }

  public int getScoreEvaluatesCount(long scoreForTeacherId, String type) {
    if (DEFAULT_TYPE.equals(type)) {
      type = null;
    }
    return evaluateMapper.getScoreEvaluatesCount(scoreForTeacherId, type);
  }

  public boolean addScoreEvaluate(long scoreForTeacherId, String title, String text, String result,
      long createrId, String createrType, boolean flag) {
    Evaluate evaluate = new Evaluate();
    evaluate.setScoreForTeacher(new ScoreForTeacher(scoreForTeacherId));
    evaluate.setTitle("".equals(title) ? null : title);
    evaluate.setText(text);
    evaluate.setResult(metadataMapper.getEvaluateResultByKey(result).getValue());
    evaluate.setCreater(createrId);
    evaluate.setCreaterType(createrType);
    evaluate.setFlag(flag);
    if (evaluateMapper.insertScoreEvaluate(evaluate)) {
      ScoreForTeacher scoreForTeacher = scoreForTeacherMapper.getById(scoreForTeacherId);
      scoreForTeacher.setEvaluateGrade(scoreForTeacher.getEvaluateGrade()+evaluate.getResult());
      scoreForTeacher.setEvaluateCount(scoreForTeacher.getEvaluateCount()+1);
      if (scoreForTeacherMapper.updateScoreForTeacher(scoreForTeacher)) {
        return true;
      }
    }
    return false;
  }

  public long getEvaluateTimeLine(long scoreForTeacherId, long createrId, String createrType) {
    Evaluate evaluate = evaluateMapper.getLastEvaluate(scoreForTeacherId, createrId, createrType);
    if(evaluate == null) {
      return new Date().getTime();
    }
    Metadata metadata = metadataMapper.getEvaluateCycle();
    return evaluate.getCreateTime().getTime()+((long) metadata.getValue())*24*60*60*1000;
  }
}
