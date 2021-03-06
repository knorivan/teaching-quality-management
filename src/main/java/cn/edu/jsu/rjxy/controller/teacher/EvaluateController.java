package cn.edu.jsu.rjxy.controller.teacher;

import cn.edu.jsu.rjxy.entity.vo.Student;
import cn.edu.jsu.rjxy.entity.vo.Teacher;
import cn.edu.jsu.rjxy.service.EvaluateService;
import cn.edu.jsu.rjxy.service.ScoreService;
import cn.edu.jsu.rjxy.util.JSONBaseUtil;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("teacherEvaluateController")
public class EvaluateController {

  @Autowired
  private ScoreService scoreService;
  @Autowired
  private EvaluateService evaluateService;


  private static final int NO_DATA = 0;
  private static final int DEFAULT_PAGE = 1;
  private static final int EVALUATE_PAGE_SIZE = 8;
  private static final String DEFAULT_TYPE = "all";

  private static final String ADD_EVALUATE_TYPE = "teacher";
  private static final String EVALUATE_CREATER_TYPE = "teacher";

  @RequestMapping("/teacher/goMyEvaluate/{id}/{token}")
  public String goMyEvaluate(@PathVariable String token, @PathVariable Long id, HttpSession session,
      Model model) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "forward:/logout/" + token;
    } else if (id == null) {
      return "/teacher/getMyScores/all/" + token;
    } else {
      model.addAttribute("scoreInfo", scoreService.getScoreByScoreForTeacherId(id));
      return "/teacher/myEvaluate";
    }
  }

  @RequestMapping("/teacher/goEvaluate/{teacherId}/{id}/{token}")
  public String goEvaluate(@PathVariable String token, @PathVariable Long id, @PathVariable Long teacherId, HttpSession session,
      Model model) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "forward:/logout/" + token;
    } else if (id == null || teacherId == null) {
      return "/teacher/getScores/all/" + token;
    } else {
      model.addAttribute("teacher", teacherId);
      model.addAttribute("timeLine",
          evaluateService.getEvaluateTimeLine(id, teacher.getId(), EVALUATE_CREATER_TYPE));
      model.addAttribute("scoreInfo", scoreService.getScoreByScoreForTeacherId(id));
      return "/teacher/other/evaluate";
    }
  }

  @RequestMapping("/teacher/getScoreEvaluates")
  @ResponseBody
  public Map<String, Object> getScoreEvaluates(HttpSession session, String token,
      long scoreForClassId, String type, Integer page) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (page == null) {
      page = DEFAULT_PAGE;
    }
    if (type == null) {
      type = DEFAULT_TYPE;
    }
    int scoreEvaluateCount = evaluateService.getScoreEvaluatesCount(scoreForClassId, type);
    return JSONBaseUtil.structuralResponseMap(
        evaluateService.getScoreEvaluates(scoreForClassId, type, page, EVALUATE_PAGE_SIZE),
        scoreEvaluateCount == NO_DATA ? NO_DATA
            : Math.ceil((double) scoreEvaluateCount / EVALUATE_PAGE_SIZE));
  }

  @RequestMapping("/teacher/evaluate")
  @ResponseBody
  public String evaluate(String token, long id, HttpSession session,
      String title, String text, String result, Boolean flag) {
    Teacher teacher = (Teacher) session.getAttribute(token);
    if (teacher == null) {
      return "logout";
    }
    if (evaluateService.addScoreEvaluate(id, title, text, result, teacher.getId(), ADD_EVALUATE_TYPE, flag)) {
      return "ok";
    } else {
      return "failure";
    }
  }

}
