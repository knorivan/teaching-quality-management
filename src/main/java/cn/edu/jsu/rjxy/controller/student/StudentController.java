package cn.edu.jsu.rjxy.controller.student;

import cn.edu.jsu.rjxy.entity.vo.QuestionnaireForTeacher;
import cn.edu.jsu.rjxy.entity.vo.Student;
import cn.edu.jsu.rjxy.mappers.QuestionMapper;
import cn.edu.jsu.rjxy.service.EvaluateService;
import cn.edu.jsu.rjxy.service.FillInQuestionnaireService;
import cn.edu.jsu.rjxy.service.MessageService;
import cn.edu.jsu.rjxy.service.QuestionService;
import cn.edu.jsu.rjxy.service.QuestionnaireService;
import cn.edu.jsu.rjxy.service.ScoreService;
import cn.edu.jsu.rjxy.service.ScoreTypeService;
import cn.edu.jsu.rjxy.service.StudentService;
import cn.edu.jsu.rjxy.util.HeaderUploadUtil;
import cn.edu.jsu.rjxy.util.MD5Util;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class StudentController {

  @Autowired
  private ScoreTypeService scoreTypeService;
  @Autowired
  private ScoreService scoreService;
  @Autowired
  private MessageService messageService;
  @Autowired
  private StudentService studentService;
  @Autowired
  private EvaluateService evaluateService;
  @Autowired
  private QuestionService questionService;
  @Autowired
  private QuestionnaireService questionnaireService;
  @Autowired
  private FillInQuestionnaireService fillInQuestionnaireService;

  private static final int NO_DATA = 0;
  private static final int SCORES_PAGE_SIZE = 8;
  private static final String ALL_SCORE_TYPE = "all";
  private static final String NO_SEARCH = null;
  private static final String MESSAGE_RECIPIENT_TYPE = "student";
  private static final String NO_READ_MESSAGE_TYPE = "noread";

  private static final String DEFAULT_MESSAGE_TYPE = "all";
  private static final int MESSAGE_PAGE_SIZE = 8;

  private static final String EVALUATE_CREATER_TYPE = "student";

  @Value("${img.url}")
  public String basePath;

  private static final String USER_TYPE = "student";

  @RequestMapping("/student/login/{token}")
  public String login(@PathVariable String token, HttpSession session, Model model) {
    Student student = (Student) session.getAttribute(token);
    model.addAttribute("scoreTypes", scoreTypeService.getAll());
    model.addAttribute("token", token);
    int scoreCount = scoreService
        .getScoresCountInCurrentTerm(ALL_SCORE_TYPE, student.getId(), NO_SEARCH);
    model.addAttribute("scoreCount",
        scoreCount == NO_DATA ? NO_DATA : Math.ceil((double) scoreCount / SCORES_PAGE_SIZE));
    model.addAttribute("noReadMessage", messageService
        .getMessagesCountByRecipientAndRecipientTypeAndFlag(student.getId(), MESSAGE_RECIPIENT_TYPE,
            NO_READ_MESSAGE_TYPE));
    return "/student/scores";
  }

  @RequestMapping("/student/goScore/{id}/{token}")
  public String goScore(@PathVariable Long id, @PathVariable String token, HttpSession session,
      Model model) {
    Student student = (Student) session.getAttribute(token);
    if (student == null) {
      return "forward:/logout/" + token;
    } else if (id == null) {
      return "/student/getScores/all/" + token;
    }
    QuestionnaireForTeacher questionnaire = questionnaireService.teacherQuestionnaireIsExist(id);
    model.addAttribute("questionnaire", questionnaire);
    if (questionnaire != null) {
      model.addAttribute("result", fillInQuestionnaireService.getByQuestionnaireAndCreater(questionnaire.getId(), student.getId(), EVALUATE_CREATER_TYPE));
    }
    model.addAttribute("scoreInfo", scoreService.getScoreByScoreForTeacherId(id));
    model.addAttribute("token", token);
    return "/student/score";
  }

  @RequestMapping("/student/goEvaluate/{id}/{token}")
  public String goEvaluate(@PathVariable String token, @PathVariable Long id, HttpSession session,
      Model model) {
    Student student = (Student) session.getAttribute(token);
    if (student == null) {
      return "forward:/logout/" + token;
    } else if (id == null) {
      return "/student/getScores/all/" + token;
    } else {
      model.addAttribute("scoreInfo", scoreService.getScoreByScoreForTeacherId(id));
      model.addAttribute("timeLine",
          evaluateService.getEvaluateTimeLine(id, student.getId(), EVALUATE_CREATER_TYPE));
      return "/student/evaluate";
    }
  }

  @RequestMapping("/student/goQuestions/{id}/{token}")
  public String goQuestions(@PathVariable String token, @PathVariable Long id, HttpSession session,
      Model model) {
    Student student = (Student) session.getAttribute(token);
    if (student == null) {
      return "forward:/logout/" + token;
    } else if (id == null) {
      return "/student/getScores/all/" + token;
    } else {
      model.addAttribute("scoreInfo", scoreService.getScoreByScoreForTeacherId(id));
      model.addAttribute("timeLine",
          questionService.getQuestionTimeLine(id, student.getId(), EVALUATE_CREATER_TYPE));
      return "/student/questions";
    }
  }

  @RequestMapping("/student/goMessage/{token}")
  public String goMessage(@PathVariable String token, HttpSession session, Model model) {
    Student student = (Student) session.getAttribute(token);
    if (student == null) {
      return "forward:/logout/" + token;
    }
    int messageCount = messageService
        .getMessagesCountByRecipientAndRecipientTypeAndFlag(student.getId(), MESSAGE_RECIPIENT_TYPE,
            DEFAULT_MESSAGE_TYPE);
    model.addAttribute("count",
        messageCount == NO_DATA ? NO_DATA : Math.ceil((double) messageCount / MESSAGE_PAGE_SIZE));
    return "/student/message";
  }

  @RequestMapping("/student/goPassword/{token}")
  public String goPassword(@PathVariable String token, HttpSession session) {
    Student student = (Student) session.getAttribute(token);
    if (student == null) {
      return "forward:/logout/" + token;
    } else {
      return "/student/changePassword";
    }
  }

  @RequestMapping("/student/checkPassword")
  @ResponseBody
  public String chechPassword(String token, String password, HttpSession session) {
    Student student = (Student) session.getAttribute(token);
    if (student == null) {
      return "logout";
    }
    if (password != null && student.getPassword().equals(password)) {
      return "ok";
    } else {
      return "error";
    }
  }

  @RequestMapping("/student/changePassword")
  @ResponseBody
  public String changePassword(String token, String password, HttpSession session) {
    Student student = (Student) session.getAttribute(token);
    if (student == null) {
      return "logout";
    }
    if (studentService.setPassword(student.getId(), password)) {
      session.setAttribute(token, studentService.getStudent(student.getId()));
      return "ok";
    } else {
      return "error";
    }
  }

  @RequestMapping("/student/goHeader/{token}")
  public String goHeader(@PathVariable String token, HttpSession session, Model model) {
    Student student = (Student) session.getAttribute(token);
    model.addAttribute("message", "");
    if (student != null) {
      return "/student/changeHeader";
    } else {
      return "forward:/logout/" + token;
    }
  }

  //https://my.oschina.net/qjedu/blog/1550704
  @RequestMapping("/student/changeHeader/{token}")
  public String changeHeader(@RequestParam(value = "file") MultipartFile file,
      @PathVariable String token, HttpSession session, Model model) {
    Student student = (Student) session.getAttribute(token);
    if (student == null) {
      return "forward:/logout/" + token;
    }
    if (file.isEmpty()) {
      model.addAttribute("message", "文件为空");
      return "/student/changeHeader";
    }
    // 设置文件名
    String fileName = MD5Util.getMD5(student.getNumber().toString());
    // 获取文件的后缀名
    String suffixName = file.getOriginalFilename()
        .substring(file.getOriginalFilename().lastIndexOf("."));
    fileName += suffixName;
    if (HeaderUploadUtil.uploadHeader(file, basePath, fileName, USER_TYPE)) {
      if (studentService
          .setHeader(student.getId(), File.separator + "student" + File.separator + fileName)) {
        student = studentService.getLoginer(student.getNumber(), student.getPassword());
        session.setAttribute(token, student);
        model.addAttribute("message", "上传成功");
      } else {
        model.addAttribute("message", "上传失败");
      }
    } else {
      model.addAttribute("message", "上传失败");
    }
    return "/student/changeHeader";
  }


}
