package cn.edu.jsu.rjxy.controller.teacher;

import cn.edu.jsu.rjxy.entity.vo.QuestionnaireForTeacher;
import cn.edu.jsu.rjxy.entity.vo.Student;
import cn.edu.jsu.rjxy.entity.vo.Teacher;
import cn.edu.jsu.rjxy.service.FillInQuestionnaireService;
import cn.edu.jsu.rjxy.service.QuestionnaireService;
import cn.edu.jsu.rjxy.service.ScoreService;
import java.util.Arrays;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("TeacherQuestionnaireController")
public class QuestionnaireController {

  @Autowired
  QuestionnaireService questionnaireService;
  @Autowired
  ScoreService scoreService;
  @Autowired
  FillInQuestionnaireService fillInQuestionnaireService;

  @RequestMapping("/teacher/goQuestionnaire/{teacherId}/{id}/{token}")
  public String goQuestionnaire(@PathVariable long teacherId,
      @PathVariable long id,
      @PathVariable String token,
      HttpSession session, Model model) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "redirect:/logout/" + token;
    }
    model.addAttribute("id", id);
    model.addAttribute("token", token);
    model.addAttribute("teacher", teacherId);
    QuestionnaireForTeacher questionnaire = questionnaireService.teacherQuestionnaireIsExist(id);
    model.addAttribute("template", questionnaire);
    model.addAttribute("types", questionnaireService.getQuestionnaireQuestionType(questionnaire.getId()));
    model.addAttribute("scoreInfo", scoreService.getScoreByScoreForTeacherId(id));
    model.addAttribute("questions", questionnaireService.getQuestionnaireQuestions(questionnaire.getId()));
    return "/teacher/other/questionnaire";
  }

  @RequestMapping("/teacher/fillInQuestionnaire")
  @ResponseBody
  public String fillInQuestionnaire(long scoreId,
      long questionnaireId,
      @RequestParam(value = "results[]") Double[] results,
      @RequestParam(value = "ids[]") Long[] ids,
      String token,
      HttpSession session, Model model) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "logout";
    }
    double result = questionnaireService.getQuestionnaireResult(questionnaireId, Arrays.asList(ids), Arrays.asList(results));
    if (fillInQuestionnaireService.fillInQuestionnaire(questionnaireId, result, teacher.getId(), "teacher", scoreId)) {
      return Double.toString(result);
    }
    return "failure";
  }


}
