package cn.edu.jsu.rjxy.service;

import cn.edu.jsu.rjxy.entity.dto.ForQuestionReaderDTO;
import cn.edu.jsu.rjxy.entity.dto.QuestionReaderDTO;
import cn.edu.jsu.rjxy.entity.vo.ForQuestion;
import cn.edu.jsu.rjxy.entity.vo.Metadata;
import cn.edu.jsu.rjxy.entity.vo.Question;
import cn.edu.jsu.rjxy.entity.vo.ScoreForTeacher;
import cn.edu.jsu.rjxy.mappers.ForQuestionMapper;
import cn.edu.jsu.rjxy.mappers.MetadataMapper;
import cn.edu.jsu.rjxy.mappers.QuestionMapper;
import cn.edu.jsu.rjxy.mappers.RegisterMapper;
import cn.edu.jsu.rjxy.mappers.ScoreForTeacherMapper;
import cn.edu.jsu.rjxy.mappers.StudentMapper;
import cn.edu.jsu.rjxy.mappers.TeacherMapper;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service
public class QuestionService {

  private static final String DEFAULT_TYPE = "all";
  private static final String QUESTION_REGISTER_TYPE = "register";
  private static final String QUESTION_TEACHER_TYPE = "teacher";
  private static final String QUESTION_STUDENT_TYPE = "student";

  @Autowired
  private QuestionMapper questionMapper;
  @Autowired
  private ForQuestionMapper forQuestionMapper;
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

  public Question getQuestionById(long id) {
    return questionMapper.getById(id);
  }

  public QuestionReaderDTO getQuestionReaderById(long id) {
    Question question = questionMapper.getById(id);
    if (QUESTION_REGISTER_TYPE.equals(question.getCreaterType())) {
      return new QuestionReaderDTO(question,
          question.getResult() == null ?
              null : metadataMapper.getQuestionResultByValue(question.getResult()),
          registerMapper.getById(question.getCreater()));
    } else if (QUESTION_TEACHER_TYPE.equals(question.getCreaterType())) {
      return new QuestionReaderDTO(question,
          question.getResult() == null ?
              null : metadataMapper.getQuestionResultByValue(question.getResult()),
          teacherMapper.getById(question.getCreater()));
    } else if (QUESTION_STUDENT_TYPE.equals(question.getCreaterType())) {
      return new QuestionReaderDTO(question,
          question.getResult() == null ?
              null : metadataMapper.getQuestionResultByValue(question.getResult()),
          studentMapper.getById(question.getCreater()));
    } else {
      return null;
    }
  }

  public List<QuestionReaderDTO> getScoreQuestions(long scoreForTeacherId, String type,
      Integer index, Integer size) {
    if (DEFAULT_TYPE.equals(type)) {
      type = null;
    }
    Integer step = null;
    if (index != null && size != null) {
      step = (index - 1) * size;
    }

    List<Question> questions = questionMapper
        .getScoreQuestions(scoreForTeacherId, type, step, size);

    List<QuestionReaderDTO> readers = new ArrayList<>();
    for (Question question : questions) {
      if (QUESTION_REGISTER_TYPE.equals(question.getCreaterType())) {
        readers.add(new QuestionReaderDTO(question,
            question.getResult() == null ?
                null : metadataMapper.getQuestionResultByValue(question.getResult()),
            registerMapper.getById(question.getCreater())));
      } else if (QUESTION_TEACHER_TYPE.equals(question.getCreaterType())) {
        readers.add(new QuestionReaderDTO(question,
            question.getResult() == null ?
                null : metadataMapper.getQuestionResultByValue(question.getResult()),
            teacherMapper.getById(question.getCreater())));
      } else if (QUESTION_STUDENT_TYPE.equals(question.getCreaterType())) {
        readers.add(new QuestionReaderDTO(question,
            question.getResult() == null ?
                null : metadataMapper.getQuestionResultByValue(question.getResult()),
            studentMapper.getById(question.getCreater())));
      }
    }
    return readers;
  }

  public int getScoreQuestionsCount(long scoreForTeacherId, String type) {
    if (DEFAULT_TYPE.equals(type)) {
      type = null;
    }
    return questionMapper.getScoreQuestionsCount(scoreForTeacherId, type);
  }

  public boolean addScoreQuestion(long scoreForTeacherId, String title, String text, String result,
      long createrId, String createrType, boolean flag) throws Exception {
    Question question = new Question();
    question.setScoreForTeacher(new ScoreForTeacher(scoreForTeacherId));
    question.setTitle("".equals(title) ? null : title);
    question.setText(text);
    if (result != null) {
      question.setResult(metadataMapper.getQuestionResultByKey(result).getValue());
    }
    question.setCreater(createrId);
    question.setCreaterType(createrType);
    question.setFlag(flag);
    if (questionMapper.insertScoreQuestion(question)) {
      ScoreForTeacher scoreForTeacher = scoreForTeacherMapper.getById(scoreForTeacherId);
      if (question.getResult() != null) {
        scoreForTeacher.setQuestionGrade(scoreForTeacher.getQuestionGrade() + question.getResult());
        scoreForTeacher.setQuestionCount(scoreForTeacher.getQuestionCount() + 1);
      }
      if (scoreForTeacherMapper.updateScoreForTeacher(scoreForTeacher)) {
        return true;
      }
    }
    throw new RuntimeException("error");
  }

  public long getQuestionTimeLine(long scoreForTeacherId, long createrId, String createrType) {
    Question question = questionMapper.getLastQuestion(scoreForTeacherId, createrId, createrType);
    if (question == null) {
      return new Date().getTime();
    }
    Metadata metadata = metadataMapper.getQuestionCycle();
    return question.getCreateTime().getTime() + ((long) metadata.getValue()) * 24 * 60 * 60 * 1000;
  }

  public List<ForQuestionReaderDTO> getQuestionChildLists(long questionId, Integer index,
      Integer size) {
    Integer step = null;
    if (index != null && size != null) {
      step = (index - 1) * size;
    }
    List<ForQuestion> forQuestions = forQuestionMapper.getPageByQuestionId(questionId, step, size);

    List<ForQuestionReaderDTO> readers = new ArrayList<>();
    for (ForQuestion forQuestion : forQuestions) {
      if (QUESTION_REGISTER_TYPE.equals(forQuestion.getCreaterType())) {
        readers.add(new ForQuestionReaderDTO(forQuestion,
            registerMapper.getById(forQuestion.getCreater())));
      } else if (QUESTION_TEACHER_TYPE.equals(forQuestion.getCreaterType())) {
        readers.add(new ForQuestionReaderDTO(forQuestion,
            teacherMapper.getById(forQuestion.getCreater())));
      } else if (QUESTION_STUDENT_TYPE.equals(forQuestion.getCreaterType())) {
        readers.add(new ForQuestionReaderDTO(forQuestion,
            studentMapper.getById(forQuestion.getCreater())));
      }
    }
    return readers;
  }

  public int getQuestionChildCount(long questionId) {
    return forQuestionMapper.getCountByQuestionId(questionId);
  }

  public boolean checkCreater(long questionId, long stuId) {
    Question question = questionMapper.getById(questionId);
    return stuId == question.getCreater();
  }

  public boolean addQuestionChild(long questionId, String text, String result, Boolean flag,
      long creater, String createrType) throws Exception {
    ForQuestion forQuestion = new ForQuestion();
    forQuestion.setQuestion(questionMapper.getById(questionId));
    forQuestion.setText(text);
    forQuestion.setCreater(creater);
    forQuestion.setCreaterType(createrType);
    forQuestion.setFlag(flag);
    if (result != null) {
      Question question = questionMapper.getById(questionId);
      question.setResult(metadataMapper.getQuestionResultByKey(result).getValue());
      if (!questionMapper.updateScoreQuestion(question)) {
        throw new RuntimeException("error");
      }
      ScoreForTeacher scoreForTeacher = question.getScoreForTeacher();
      scoreForTeacher.setQuestionCount(scoreForTeacher.getQuestionCount() + 1);
      scoreForTeacher.setQuestionGrade(scoreForTeacher.getQuestionGrade() + question.getResult());
      if (!scoreForTeacherMapper.updateScoreForTeacher(scoreForTeacher)) {
        throw new RuntimeException("error");
      }
    }
    if (forQuestionMapper.insertForQuestion(forQuestion)) {
      return true;
    } else {
      throw new RuntimeException("error");
    }
  }
}
