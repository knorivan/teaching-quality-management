package cn.edu.jsu.rjxy.controller.teacher;

import cn.edu.jsu.rjxy.entity.vo.QuestionnaireForTeacher;
import cn.edu.jsu.rjxy.entity.vo.ScoreForTeacher;
import cn.edu.jsu.rjxy.entity.vo.Teacher;
import cn.edu.jsu.rjxy.service.FillInQuestionnaireService;
import cn.edu.jsu.rjxy.service.MessageService;
import cn.edu.jsu.rjxy.service.QuestionnaireService;
import cn.edu.jsu.rjxy.service.ScoreService;
import cn.edu.jsu.rjxy.service.ScoreTypeService;
import cn.edu.jsu.rjxy.util.JSONBaseUtil;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("teacherScoreController")
public class ScoreController {

  @Autowired
  private ScoreService scoreService;
  @Autowired
  private ScoreTypeService scoreTypeService;
  @Autowired
  private MessageService messageService;
  @Autowired
  private QuestionnaireService questionnaireService;
  @Autowired
  private FillInQuestionnaireService fillInQuestionnaireService;

  private static final int NO_DATA = 0;
  private static final int SCORES_PAGE_SIZE = 8;
  private static final String ALL_SCORE_TYPE = "all";
  private static final String NO_SEARCH = null;
  private static final String MESSAGE_RECIPIENT_TYPE = "teacher";
  private static final String NO_READ_MESSAGE_TYPE = "noread";
  private static final int INDEX_PAGE_NUMBER = 1;

  private static final String DEFAULT_MESSAGE_TYPE = "all";
  private static final int MESSAGE_PAGE_SIZE = 8;

  private static final String EVALUATE_CREATER_TYPE = "teacher";

  @Value("${img.url}")
  public String basePath;


  @RequestMapping("/teacher/myScores/{token}")
  public String goMyScores(@PathVariable String token, HttpSession session, Model model) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    model.addAttribute("scoreTypes", scoreTypeService.getAll());
    model.addAttribute("token", token);
    int scoreCount = scoreService
        .getTeachScoresCountInCurrentTerm(ALL_SCORE_TYPE, teacher.getId(), NO_SEARCH);
    model.addAttribute("scoreCount",
        scoreCount == NO_DATA ? NO_DATA : Math.ceil((double) scoreCount / SCORES_PAGE_SIZE));
    model.addAttribute("noReadMessage", messageService
        .getMessagesCountByRecipientAndRecipientTypeAndFlag(teacher.getId(), MESSAGE_RECIPIENT_TYPE,
            NO_READ_MESSAGE_TYPE));
    return "/teacher/myScores";
  }

  @RequestMapping("/teacher/getMyScores/{type}/{token}")
  @ResponseBody
  public Map<String, Object> getMyScores(@PathVariable String type, @PathVariable String token,
      HttpSession session, Integer page, String search) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (page == null) {
      page = INDEX_PAGE_NUMBER;
    }
    int scoreCount = scoreService.getTeachScoresCountInCurrentTerm(type, teacher.getId(), search);
    return JSONBaseUtil.structuralResponseMap(
        scoreService
            .getTeachScoresInCurrentTerm(type, teacher.getId(), page, SCORES_PAGE_SIZE, search),
        scoreCount == NO_DATA ? NO_DATA : Math.ceil((double) scoreCount / SCORES_PAGE_SIZE));
  }

  @RequestMapping("/teacher/goMyScore/{id}/{token}")
  public String goMyScore(@PathVariable Long id, @PathVariable String token, HttpSession session,
      Model model) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "redirect:/logout/" + token;
    } else if (id == null) {
      return "/teacher/getMyScores/all/" + token;
    }
    model.addAttribute("scoreInfo", scoreService.getScoreByScoreForTeacherId(id));
    model.addAttribute("token", token);
    return "/teacher/myScore";
  }

  @RequestMapping("/teacher/setRemarks")
  @ResponseBody
  public String setRemarks(Long id, String token, String remarks,
      HttpSession session) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "logout";
    }
    if (id == null) {
      return "failure";
    }
    ScoreForTeacher scoreForTeacher = scoreService.getById(id);
    if (scoreForTeacher != null) {
      scoreForTeacher.setRemarks(remarks);
      if (scoreService.updateScoreForTeacher(scoreForTeacher)) {
        return "ok";
      }
    }
    return "failure";
  }


  @RequestMapping("/teacher/goScores/{id}/{token}")
  public String goScores(@PathVariable String token, HttpSession session, @PathVariable Long id,
      Model model) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "redirect:/logout/" + token;
    }
    if (id == null) {
      return "/teacher/myScores/" + token;
    }
    model.addAttribute("teacher", id);
    model.addAttribute("scoreTypes", scoreTypeService.getAll());
    model.addAttribute("token", token);
    int scoreCount = scoreService
        .getTeachScoresCountInCurrentTerm(ALL_SCORE_TYPE, id, NO_SEARCH);
    model.addAttribute("scoreCount", Math.ceil((double) scoreCount / SCORES_PAGE_SIZE));
    return "/teacher/other/scores";
  }


  @RequestMapping("/teacher/getScores/{type}/{token}")
  @ResponseBody
  public Map<String, Object> getScores(@PathVariable String type, @PathVariable String token,
      HttpSession session, Long id, Integer page, String search) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (id == null) {
      return JSONBaseUtil.structuralResponseMap("", 0);
    }
    if (page == null) {
      page = INDEX_PAGE_NUMBER;
    }
    int scoreCount = scoreService.getTeachScoresCountInCurrentTerm(type, id, search);
    return JSONBaseUtil.structuralResponseMap(
        scoreService
            .getTeachScoresInCurrentTerm(type, id, page, SCORES_PAGE_SIZE, search),
        scoreCount == NO_DATA ? NO_DATA : Math.ceil((double) scoreCount / SCORES_PAGE_SIZE));
  }

  @RequestMapping("/teacher/goScore/{teacherId}/{id}/{token}")
  public String goScore(@PathVariable long teacherId, @PathVariable Long id,
      @PathVariable String token, HttpSession session, Model model) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "redirect:/logout/" + token;
    } else if (id == null) {
      return "/teacher/getScores/all/" + token;
    }
    QuestionnaireForTeacher questionnaire = questionnaireService.teacherQuestionnaireIsExist(id);
    model.addAttribute("questionnaire", questionnaire);
    if (questionnaire != null) {
      model.addAttribute("result", fillInQuestionnaireService.getByQuestionnaireAndCreater(questionnaire.getId(), teacher.getId(), EVALUATE_CREATER_TYPE));
    }
    model.addAttribute("teacher", teacherId);
    model.addAttribute("scoreInfo", scoreService.getScoreByScoreForTeacherId(id));
    model.addAttribute("token", token);
    return "/teacher/other/score";
  }
}
