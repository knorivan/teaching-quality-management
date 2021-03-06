/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50018
Source Host           : 127.0.0.1:3306
Source Database       : teach

Target Server Type    : MYSQL
Target Server Version : 50018
File Encoding         : 65001

Date: 2018-04-21 00:12:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL auto_increment,
  `account` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `creater` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', 'admin', '1', '2018-03-12 21:16:26');

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '班级名称',
  `major` int(11) NOT NULL COMMENT '所在专业',
  `term` int(11) NOT NULL COMMENT '学期，因为大学每个学期可能学生都不一样',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES ('1', '2014级软件一班', '1', '1');

-- ----------------------------
-- Table structure for evaluate
-- ----------------------------
DROP TABLE IF EXISTS `evaluate`;
CREATE TABLE `evaluate` (
  `id` int(11) NOT NULL auto_increment,
  `score_for_teacher` int(11) NOT NULL,
  `title` varchar(255) default NULL,
  `text` text NOT NULL,
  `result` decimal(10,2) NOT NULL,
  `creater` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `creater_type` varchar(32) NOT NULL,
  `flag` tinyint(1) NOT NULL COMMENT '是否匿名标记',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of evaluate
-- ----------------------------
INSERT INTO `evaluate` VALUES ('1', '1', null, '很好', '90.00', '1', '2017-12-15 15:05:26', 'student', '0');
INSERT INTO `evaluate` VALUES ('2', '1', null, '很认真负责，对学生很友好', '80.00', '2', '2017-12-27 20:06:35', 'student', '0');
INSERT INTO `evaluate` VALUES ('3', '1', null, '讲课细致认真，能及时解决学生问题', '90.00', '3', '2018-01-17 23:08:30', 'student', '0');
INSERT INTO `evaluate` VALUES ('4', '1', null, '老师授课有条理，有重点，对同学既热情又严格', '90.00', '4', '2018-02-21 23:10:25', 'student', '0');
INSERT INTO `evaluate` VALUES ('5', '1', null, '最开始，老师授课速度有些快，但是，后来学生提建议给老师，老师欣然接受并调整了授课速度。所以，总体感觉老师讲得很好', '80.00', '5', '2018-02-02 23:11:04', 'student', '0');
INSERT INTO `evaluate` VALUES ('6', '1', null, '老师对学生课堂作业的批改总结认真，能及时，准确的发现同学们存在的问题并认真讲解，解决问题', '80.00', '1', '2018-02-13 23:11:39', 'student', '1');
INSERT INTO `evaluate` VALUES ('7', '1', null, '关心学生，认真负责', '80.00', '2', '2018-02-13 23:13:15', 'student', '0');
INSERT INTO `evaluate` VALUES ('8', '1', null, '很能带动学生学习积极性', '90.00', '2', '2018-02-21 23:14:16', 'teacher', '0');
INSERT INTO `evaluate` VALUES ('9', '1', null, '挺好', '90.00', '1', '2018-03-05 18:04:45', 'student', '1');
INSERT INTO `evaluate` VALUES ('10', '1', null, '很好', '90.00', '1', '2018-03-28 18:08:30', 'student', '1');
INSERT INTO `evaluate` VALUES ('12', '1', null, '很棒哦', '80.00', '1', '2018-04-04 21:26:42', 'register', '0');
INSERT INTO `evaluate` VALUES ('13', '1', null, '还不错哦', '90.00', '3', '2018-04-20 02:47:33', 'teacher', '0');

-- ----------------------------
-- Table structure for fill_in_questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `fill_in_questionnaire`;
CREATE TABLE `fill_in_questionnaire` (
  `id` int(11) NOT NULL auto_increment,
  `questionnaire` int(11) NOT NULL,
  `result` decimal(5,2) NOT NULL,
  `creater` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `creater_type` varchar(32) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fill_in_questionnaire
-- ----------------------------
INSERT INTO `fill_in_questionnaire` VALUES ('1', '3', '77.25', '1', '2018-04-19 22:23:27', 'student');
INSERT INTO `fill_in_questionnaire` VALUES ('2', '3', '76.25', '3', '2018-04-20 00:28:14', 'teacher');

-- ----------------------------
-- Table structure for for_question
-- ----------------------------
DROP TABLE IF EXISTS `for_question`;
CREATE TABLE `for_question` (
  `id` int(11) NOT NULL auto_increment,
  `question` int(11) NOT NULL,
  `text` text NOT NULL,
  `creater` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `creater_type` varchar(32) NOT NULL,
  `flag` tinyint(1) NOT NULL COMMENT '是否匿名标记',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of for_question
-- ----------------------------
INSERT INTO `for_question` VALUES ('1', '2', '1', '1', '2018-03-14 11:38:39', 'student', '1');
INSERT INTO `for_question` VALUES ('2', '1', '123213123123123123123', '1', '2018-03-28 22:34:19', 'student', '0');
INSERT INTO `for_question` VALUES ('3', '2', '你说呢', '1', '2018-03-28 22:35:02', 'student', '1');
INSERT INTO `for_question` VALUES ('5', '2', '我也不知道啊', '1', '2018-03-28 23:09:03', 'student', '0');
INSERT INTO `for_question` VALUES ('6', '2', '那怎么办呢', '1', '2018-03-28 23:09:55', 'student', '1');
INSERT INTO `for_question` VALUES ('7', '2', '接着问呗', '1', '2018-03-28 23:10:04', 'student', '1');
INSERT INTO `for_question` VALUES ('8', '1', '你说呢', '3', '2018-04-20 02:52:13', 'teacher', '0');
INSERT INTO `for_question` VALUES ('9', '1', '哈哈', '3', '2018-04-20 02:54:57', 'teacher', '0');

-- ----------------------------
-- Table structure for major
-- ----------------------------
DROP TABLE IF EXISTS `major`;
CREATE TABLE `major` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键',
  `number` varchar(32) NOT NULL COMMENT '专业编号',
  `name` varchar(64) NOT NULL COMMENT '专业名称',
  `schooling` tinyint(4) NOT NULL COMMENT '学制',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of major
-- ----------------------------
INSERT INTO `major` VALUES ('1', '010101', '哲学', '4');
INSERT INTO `major` VALUES ('2', '010102', '逻辑学', '4');
INSERT INTO `major` VALUES ('3', '01010K', '宗教学', '4');
INSERT INTO `major` VALUES ('4', '020101', '经济学', '4');
INSERT INTO `major` VALUES ('5', '020102', '经济统计学', '4');
INSERT INTO `major` VALUES ('6', '020201K', '财政学', '4');
INSERT INTO `major` VALUES ('7', '020202', '税收学', '4');
INSERT INTO `major` VALUES ('8', '020301K', '金融学', '4');
INSERT INTO `major` VALUES ('9', '020302', '金融工程', '4');
INSERT INTO `major` VALUES ('10', '020303', '保险学', '4');
INSERT INTO `major` VALUES ('11', '020304', '投资学', '4');
INSERT INTO `major` VALUES ('12', '020401', '国际经济与贸易', '4');
INSERT INTO `major` VALUES ('13', '020402', '贸易经济', '4');
INSERT INTO `major` VALUES ('14', '030101K', '法学', '4');
INSERT INTO `major` VALUES ('15', '030201', '政治学与行政学', '4');
INSERT INTO `major` VALUES ('16', '030202', '国际政治', '4');
INSERT INTO `major` VALUES ('17', '030203', '外交学', '4');
INSERT INTO `major` VALUES ('18', '030301', '社会学', '4');
INSERT INTO `major` VALUES ('19', '030302', '社会工作', '4');
INSERT INTO `major` VALUES ('20', '030401', '民族学', '4');
INSERT INTO `major` VALUES ('21', '030501', '科学社会主义', '4');
INSERT INTO `major` VALUES ('22', '030502', '中国共产党历史', '4');
INSERT INTO `major` VALUES ('23', '030503', '思想政治教育', '4');
INSERT INTO `major` VALUES ('24', '030601K', '治安学', '4');
INSERT INTO `major` VALUES ('25', '030602K', '侦查学', '4');
INSERT INTO `major` VALUES ('26', '030603K', '边防管理', '4');
INSERT INTO `major` VALUES ('27', '040101', '教育学', '4');
INSERT INTO `major` VALUES ('28', '040102', '科学教育', '4');
INSERT INTO `major` VALUES ('29', '040103', '人文教育', '4');
INSERT INTO `major` VALUES ('30', '040104', '教育技术学', '4');
INSERT INTO `major` VALUES ('31', '040105', '艺术教育', '4');
INSERT INTO `major` VALUES ('32', '040106', '学前教育', '4');
INSERT INTO `major` VALUES ('33', '040107', '小学教育', '4');
INSERT INTO `major` VALUES ('34', '040108', '特殊教育', '4');
INSERT INTO `major` VALUES ('35', '040201', '体育教育', '4');
INSERT INTO `major` VALUES ('36', '040202K', '运动训练', '4');
INSERT INTO `major` VALUES ('37', '040203', '社会体育指导与管理', '4');
INSERT INTO `major` VALUES ('38', '040204K', '武术与民族传统体育', '4');
INSERT INTO `major` VALUES ('39', '040205', '运动人体科学', '4');
INSERT INTO `major` VALUES ('40', '050101', '汉语言文学', '4');
INSERT INTO `major` VALUES ('41', '050102', '汉语言', '4');
INSERT INTO `major` VALUES ('42', '050103', '汉语国际教育', '4');
INSERT INTO `major` VALUES ('43', '050104', '中国少数名族语言文学', '4');
INSERT INTO `major` VALUES ('44', '050105', '古典文献学', '4');
INSERT INTO `major` VALUES ('45', '080902', '软件工程', '4');
INSERT INTO `major` VALUES ('46', '080903', '网络工程', '4');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `creater` int(11) NOT NULL,
  `creater_type` varchar(64) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '评教通知', '评教通知', '1', 'admin', '2018-03-17 17:47:20');
INSERT INTO `message` VALUES ('2', '关于报送吉首大学“十三五”专业综合改革试点项目2018年度建设计划的通知（教通[2018]6号）', '各相关学院： \r\n   根据《关于公布吉首大学“十三五”专业综合改革试点项目的通知》（教通〔2016〕45号）文件精神，为进一步加强管理，推动专业综合改革试点项目取得实效，根据项目管理要求，通信工程、土木工程、数学与应用数学、食品科学与工程、汉语言文学、旅游管理、管理工程、新闻学、软件工程、临床医学等10个专业综合改革试点项目须向学校报送本年度建设计划并做好本年度建设工作。请各单位与项目负责人认真研究本年度专业综合改革工作，将建设任务项目化、落实责任主体，并根据建设与改革任务合理配置资源、安排经费，并于3月30日前将年度建设计划报送教务处教学改革与教学建设科。\r\n联系人：教学改革与教学建设科宋海龙（吉首校区0743-8564146, jsujyk@126.com），教科办杨艳（张家界校区 0744-2110918，531386348@qq.com）。\r\n\r\n附件：吉首大学“十三五”专业综合改革试点项目年度建设计划\r\n各相关学院： \r\n   根据《关于公布吉首大学“十三五”专业综合改革试点项目的通知》（教通〔2016〕45号）文件精神，为进一步加强管理，推动专业综合改革试点项目取得实效，根据项目管理要求，通信工程、土木工程、数学与应用数学、食品科学与工程、汉语言文学、旅游管理、管理工程、新闻学、软件工程、临床医学等10个专业综合改革试点项目须向学校报送本年度建设计划并做好本年度建设工作。请各单位与项目负责人认真研究本年度专业综合改革工作，将建设任务项目化、落实责任主体，并根据建设与改革任务合理配置资源、安排经费，并于3月30日前将年度建设计划报送教务处教学改革与教学建设科。\r\n联系人：教学改革与教学建设科宋海龙（吉首校区0743-8564146, jsujyk@126.com），教科办杨艳（张家界校区 0744-2110918，531386348@qq.com）。\r\n\r\n附件：吉首大学“十三五”专业综合改革试点项目年度建设计划\r\n', '1', 'admin', '2018-03-18 11:05:03');
INSERT INTO `message` VALUES ('3', '吉首大学关于2018年6月全国大学英语四、六级考试报名工作的通知', '各学院（部）、教学单位：\r\n2018年上半年全国大学英语四、六级考试（以下简称CET）定于6月16日进行，为认真做好本次的报名工作，现将有关事项通知如下：\r\n一、报名条件\r\n1、CET4限：\r\nA、普通高校在籍14级、15级、16级本科生，在籍研究生及17级英语高级班本科生；\r\nB、专科、高职院校获得大学英语应用能力A级证书的在校生，其他类别学生不得报考。\r\n2、CET6限CET4成绩必须在425分（含425分）以上的学生；\r\n严禁四、六级同时报名，严禁没有资格的学生报名，严禁越级别、跨校报名。报名、采集照片和考试时严禁弄虚作假，一经发现停考一年。情节严重的、触犯考规的，按照相关法律法规和学校相关规定进行处理。\r\n3、考生报名要本着对学校及自己负责的态度，抓紧时间认真报名，不要胡报乱报。报错考试级别以及报了名后又不想参考的考生要在报名期间内修改级别或删除报名信息。报名时间过后一律不修改考试级别及删除、添加考生信息，报名时间过后报了名的学生便视为必考考生，考试可以不参加但必须缴纳报名费用。\r\n二、报名方式、时间和核对数据及缴费：\r\n1、报名方式：\r\n考生必须到省考试院规定网站报名 （http://shekao.hneao.cn/cet/）\r\n2、报名时间、核对数据及缴费\r\n（1）3月16日－3月20日17:00期间，为在籍全日制学生网上报名时间，逾期一律不予补报。\r\n（2）3月21日，各学院到考试中心领取考生信息核对表，\r\n根据所领取的报名表核对信息、签名、缴费。\r\n（3）信息表必须经学生签字后由学院保存，存在错误信息的由学生本人于3月23日之前来考试中心修改。\r\n3、缴 费\r\n CET4级：26元  CET6级：28元\r\n缴费时间为3月22日8：00——3月25日18:00，\r\n缴费方式：①关注吉首大学财务处微信公众号，自行缴纳报名费。（具体操作步骤请浏览吉首大学财务处主页“信息公告”栏目关于财务处开通微信公众号的公告http://caiwu.jsu.edu.cn/）逾期不交报名费的作自动弃考处理，将删除其报名信息失去考试资格，不再另行通知。\r\n三、相片信息采集核对和处理\r\n1、报名系统中没相片的考生按照要求于3月25日之前拍摄，电子相片交所在学院教务秘书，由学院统一交考试中心，逾期作自动退出考试处理，不退还报名费。\r\n2、采集照片要求：（1）以浅蓝色为背景；（2）图中大小：192×144像素（3）照片只能以“身份证号”命名，不要添加其他任何信息。\r\n                                 联系电话：0743－8563983', '1', 'admin', '2018-03-16 11:06:08');
INSERT INTO `message` VALUES ('4', '关于2017-2018学年度第1学期吉首校区《大学计算机基础》与《数据分析与处理》课程补考机试安排的通知', '相关学院：\r\n现将2017-2018学年度第1学期《大学计算机基础》与《数据分析与处理》课程补考的机试安排情况公布如下（详见附件），请学院及时通知到机考相关学生。\r\n附件1、2017-2018-1《大学计算机基础》补考机试安排（老校区）\r\n   2、2017-2018-1《大学计算机基础》补考机试安排（新校区）\r\n   3、2017-2018-1《数据分析与处理》补考机试安排（新校区）\r\n   4、大学计算机基础补考名单及安排\r\n   5、数据分析处理补考名单及安排', '1', 'admin', '2018-03-08 11:06:47');
INSERT INTO `message` VALUES ('5', '关于2018届毕业生补充采集像片工作的通知', '凡因实习和个人原因未能参加毕业生学历证书电子注册像片集体采集的学生，务必参加本次照片采集。此次仍不采集的学生，因缺少像片而导制证书无法制作、学历无法进行电子注册等后果自行承担。\r\n一、采集方式：将照片发送至指定邮箱2447423951@qq.com\r\n    （1）照片规规格要求：浅蓝色背景数码标准证件照片，裁剪后像素为640*480，大小30-200K以内。正面相，露眉毛，头发梳理整齐，眼部不得有遮挡,可佩戴不反光眼镜，不佩戴饰物。着装不能为蓝色、黄色或背景相近色。\r\n    （2）照片命名方式：学号+姓名\r\n    因照片用于教育部学历注册，为保证图片真实性，请保持图片原样，不得PS改变面貌特征，否则后果自担。\r\n二、支付费用方式：采用支付宝支付。支付宝账号：13163274955，每人15元。支付时请备注清楚（建议采用“学号+姓名”吉首大学2018届毕业生）。\r\n三、截止时间：2018年3月31日\r\n    若仍有疑问可咨询图像采集公司客服电话：027-8788551/67849420 或教务处学籍科电话：0743－8564016。\r\n    附件:2018届预计毕业生未照片学生名单附件：2018届预计毕业生未照相名单.xls', '1', 'admin', '2018-03-07 11:07:17');
INSERT INTO `message` VALUES ('6', '关于统计2017年吉首大学本科教学奖励情况的通知（教通[2018]5号）', '各学院及相关单位：\r\n根据《吉首大学教学奖励办法》（2017年修订版，以下简称“奖励办法”，见附件1）文件精神，经研究决定对2017年本科教学获奖的单位及个人进行统计表彰，现将有关事项通知如下：\r\n一、奖励统计范围\r\n以《奖励办法》中规定的奖励项目为准。\r\n二、奖励申报要求\r\n1、请各单位认真组织申报工作，并指派专人按《奖励办法》要求对申报项目与材料进行严格审核，确保数据准确、材料真实可靠。\r\n2、课堂教学竞赛、微课竞赛、教学质量奖、优秀实习（毕业论文）指导老师、教学管理先进单位与个人等项目不需要统计，教务处将根据文件直接汇总。\r\n3、请各单位认真审核并填写《统计表》（见附件2），上交统计表和获奖材料（包括获奖文件或证书复印件、论文复印件、汇总表电子版）。\r\n4、所有材料请于3月20日前报送教务处教学改革与教学建设科，张家界校区报送校区教科办审核。\r\n联系人：宋海龙（吉首校区0743-8564146, jsujyk@126.com）\r\n杨艳（张家界校区0744-2110918，531386348@qq.com）\r\n附件：1、吉首大学教学工作奖励办法（2017版）\r\n2、吉首大学2017年本科教学奖励情况统计表\r\n吉首大学教务处', '1', 'admin', '2018-03-15 11:07:54');
INSERT INTO `message` VALUES ('7', '关于开展2018年度学科竞赛项目立项申报工作的通知', '各相关学院：\r\n为进一步深化我校大学生科技创新工作，充分发挥学科竞赛在培养学生实践动手能力、创新创业精神、团队合作意识、提高学生综合素质等方面的积极作用，促进学科竞赛与教学、科研、校企合作等人才培养工作有机结合，以教促赛，以赛促学，教学相长，为学生展示实践创新成果搭建平台，形成以学生为本的竞赛体系，根据《吉首大学本科生学科竞赛管理暂行办法》（2016年9月），教务处决定启动2018年度学科竞赛项目的立项申报工作。现将有关事宜通知如下：\r\n一、申报要求\r\n1．学院应成立学科竞赛管理工作小组，对本单位申报的学科竞赛项目进行遴选，教育部、教育厅等主管行政部门指定的A类学科竞赛必须参加，以学院创新工作室为单位，每个工作室申报总数原则上不得超过4个（体育科学学院单列）。\r\n2．以学院实验室、创新工作室为依托，有必要的训练场地和实验条件。\r\n3．有明确的负责人和健全的组织机构，根据学科竞赛的差异性，需成立不同的指导团队为大学生的学科竞赛活动进行必要的指导。\r\n4．各竞赛承办单位需加强学科竞赛管理及内涵建设工作，各竞赛承办单位应精心组织策划，注重专业知识的融入。并加深校企合作，有条件的学院可以邀请企业、校外教育基地、实习基地的专家参与竞赛的策划。\r\n二、申报范围\r\n学科竞赛应为学科类、技能类、创新类、创业类、教育类竞赛之一，统称学科竞赛，学校重点资助以下学科竞赛项目：\r\n1.教育行政部门主办学科技能竞赛作依托的规定项目（A类）；\r\n2.社会影响面广、行业认可度高的竞赛的项目（B类C类）；\r\n3.学生参与范围广、受益面大的学科竞赛项目（D类）。\r\n三、经学校审定并通过立项的学科竞赛，学校将按照《吉首大学本科生学科竞赛管理办法》给予相应的经费支持,对未列入竞赛计划而组织参加的赛事学校原则上不予资金支持和奖励。\r\n四、望各学院认真做好项目的申报工作，积极鼓励和支持学生参加2018年大学生学科竞赛项目，请各学院于2018年3月14日下午5:30前将申报材料纸质版一式两份送交教务处实践教学科（新实验大楼903办公室，张家界校区送教科办办公室），电子版发送至jsusjk@163.com。', '1', 'admin', '2018-03-07 11:08:27');
INSERT INTO `message` VALUES ('8', '关于开展2018年辅修专业（双学位）工作的通知', '各学院、各相关部门：\r\n   为适应国家经济建设和社会发展对跨学科专业人才的需求，培养知识面宽、适应能力强的复合型人才，增强学生的适应能力与竞争能力，经相关学院申报，学校审核，学校将继续开展辅修专业（双学位）教育工作，具体见附件。', '1', 'admin', '2018-03-13 11:09:22');
INSERT INTO `message` VALUES ('9', '2017年教风学风专项检查情况通报（三）', ' 2017年6月6日、8日，教务处分别组织对吉首校区、张家界校区的课堂教学情况进行检查，本次共检查109个教学班，其中张家界校区40个、吉首校区69个。全校平均到课率92.7%，其中张家界校区94.3%、吉首校区91.8%。学生到课率情况通报见附表。', '1', 'admin', '2018-03-06 11:09:49');

-- ----------------------------
-- Table structure for metadata
-- ----------------------------
DROP TABLE IF EXISTS `metadata`;
CREATE TABLE `metadata` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(255) NOT NULL,
  `value` decimal(10,2) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of metadata
-- ----------------------------
INSERT INTO `metadata` VALUES ('1', 'evaluate.perfect', '90.00');
INSERT INTO `metadata` VALUES ('2', 'evaluate.good', '80.00');
INSERT INTO `metadata` VALUES ('3', 'evaluate.medium', '70.00');
INSERT INTO `metadata` VALUES ('4', 'evaluate.dissatisfactory', '60.00');
INSERT INTO `metadata` VALUES ('5', 'question.perfect', '90.00');
INSERT INTO `metadata` VALUES ('6', 'question.good', '80.00');
INSERT INTO `metadata` VALUES ('7', 'question.medium', '70.00');
INSERT INTO `metadata` VALUES ('8', 'question.dissatisfactory', '60.00');
INSERT INTO `metadata` VALUES ('9', 'evaluate.cycle', '15.00');
INSERT INTO `metadata` VALUES ('10', 'question.cycle', '1.00');

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(11) NOT NULL auto_increment,
  `score_for_teacher` int(11) NOT NULL,
  `title` varchar(255) default NULL,
  `text` text NOT NULL,
  `result` decimal(10,2) default NULL,
  `creater` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `creater_type` varchar(32) NOT NULL,
  `flag` tinyint(1) NOT NULL COMMENT '是否匿名标记',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('1', '1', '什么情况下使用瀑布模型', '见标题', '80.00', '1', '2018-03-26 15:17:05', 'student', '0');
INSERT INTO `question` VALUES ('2', '1', '怎么区分系统边界', '见标题', '90.00', '1', '2018-02-09 15:17:29', 'student', '0');

-- ----------------------------
-- Table structure for questionnaire_bank
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire_bank`;
CREATE TABLE `questionnaire_bank` (
  `id` int(11) NOT NULL auto_increment,
  `type` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `remarks` text,
  `content_A` varchar(255) NOT NULL,
  `result_A` decimal(10,0) NOT NULL,
  `content_B` varchar(255) NOT NULL,
  `result_B` decimal(10,0) NOT NULL,
  `content_C` varchar(255) default NULL,
  `result_C` decimal(10,0) default NULL,
  `content_D` varchar(255) default NULL,
  `result_D` decimal(10,0) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questionnaire_bank
-- ----------------------------
INSERT INTO `questionnaire_bank` VALUES ('1', '1', '教学责任心强，以身作则，为人师表', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('2', '1', '引导学生端正学习态度，指导学生采用有效的学习方法', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('3', '1', '注重学生个性发展，因材施教', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('4', '3', '电子课件设计清晰、简明，图文并茂', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('5', '2', '教姿教态端正', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('6', '2', '语言准确、生动，板书工整', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('7', '2', '讲授逻辑清楚、条理清晰，教学时间分配合理', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('8', '3', '讲授知识系统、准确，重点突出，说理充分', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('9', '3', '密切联系实际，内容熟练充实、信息量大，举例恰当', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('10', '3', '认真布置、批改作业，定期组织答疑', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('11', '4', '教法灵活，讲课通俗易懂，能引导、启发学生积极思维 ', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('12', '4', '合理运用现代化辅助教学手段 ', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('13', '5', '遵守学院规章制度，按时上下课', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('14', '5', '课堂教学组织严密，管理严格', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('15', '6', '能够完成教学任务，学生能够接受并掌握课程内容', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('16', '6', '学生能初步运用课程内容解决本学科或相关学科中的具体问题', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('17', '6', '促进了学生思维能力和学习能力的提高', '', '很好', '10', '好', '8', '一般', '6', '差', '4');
INSERT INTO `questionnaire_bank` VALUES ('18', '2', '普通话授课，语言准确、生动，板书工整', '', '很好', '10', '好', '8', '一般', '6', '差', '4');

-- ----------------------------
-- Table structure for questionnaire_for_teacher
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire_for_teacher`;
CREATE TABLE `questionnaire_for_teacher` (
  `id` int(11) NOT NULL auto_increment,
  `score_for_teacher` int(11) NOT NULL,
  `creater` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `updater` int(11) default NULL,
  `update_time` datetime default NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questionnaire_for_teacher
-- ----------------------------
INSERT INTO `questionnaire_for_teacher` VALUES ('3', '1', '1', '2018-04-19 06:34:38', null, null, '2018-04-19 06:34:38', '2018-04-21 00:00:00');

-- ----------------------------
-- Table structure for questionnaire_for_teacher_questions
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire_for_teacher_questions`;
CREATE TABLE `questionnaire_for_teacher_questions` (
  `id` int(11) NOT NULL auto_increment,
  `questionnaire` int(11) NOT NULL,
  `question` int(11) NOT NULL,
  `coefficient` decimal(2,1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questionnaire_for_teacher_questions
-- ----------------------------
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('33', '3', '1', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('34', '3', '2', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('35', '3', '3', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('36', '3', '5', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('37', '3', '6', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('38', '3', '7', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('39', '3', '8', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('40', '3', '9', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('41', '3', '10', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('42', '3', '11', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('43', '3', '12', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('44', '3', '13', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('45', '3', '14', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('46', '3', '15', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('47', '3', '16', '1.0');
INSERT INTO `questionnaire_for_teacher_questions` VALUES ('48', '3', '17', '1.0');

-- ----------------------------
-- Table structure for questionnaire_question_type
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire_question_type`;
CREATE TABLE `questionnaire_question_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questionnaire_question_type
-- ----------------------------
INSERT INTO `questionnaire_question_type` VALUES ('1', '教书育人');
INSERT INTO `questionnaire_question_type` VALUES ('2', '教学基本功');
INSERT INTO `questionnaire_question_type` VALUES ('3', '教学内容');
INSERT INTO `questionnaire_question_type` VALUES ('4', '教学方法');
INSERT INTO `questionnaire_question_type` VALUES ('5', '教学管理');
INSERT INTO `questionnaire_question_type` VALUES ('6', '教学效果');
INSERT INTO `questionnaire_question_type` VALUES ('7', '教学准备');
INSERT INTO `questionnaire_question_type` VALUES ('8', '师生互动');

-- ----------------------------
-- Table structure for questionnaire_template
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire_template`;
CREATE TABLE `questionnaire_template` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `creater` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `updater` int(11) default NULL,
  `update_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questionnaire_template
-- ----------------------------
INSERT INTO `questionnaire_template` VALUES ('1', '软件工程通用模板', '1', '2018-04-09 00:19:35', '1', '2018-04-17 20:51:19');
INSERT INTO `questionnaire_template` VALUES ('9', '软件工程通用模板二', '1', '2018-04-18 01:27:01', '1', '2018-04-18 01:27:01');

-- ----------------------------
-- Table structure for questionnaire_template_questions
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire_template_questions`;
CREATE TABLE `questionnaire_template_questions` (
  `id` int(11) NOT NULL auto_increment,
  `template` int(11) NOT NULL,
  `question` int(11) NOT NULL,
  `coefficient` decimal(2,1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questionnaire_template_questions
-- ----------------------------
INSERT INTO `questionnaire_template_questions` VALUES ('1', '1', '1', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('2', '1', '2', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('3', '1', '3', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('4', '1', '5', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('5', '1', '6', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('6', '1', '7', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('7', '1', '8', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('8', '1', '9', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('9', '1', '10', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('10', '1', '11', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('11', '1', '12', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('12', '1', '13', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('13', '1', '14', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('14', '1', '15', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('15', '1', '16', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('16', '1', '17', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('17', '9', '1', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('18', '9', '2', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('19', '9', '3', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('20', '9', '5', '0.5');
INSERT INTO `questionnaire_template_questions` VALUES ('21', '9', '6', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('22', '9', '7', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('23', '9', '18', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('24', '9', '4', '1.0');
INSERT INTO `questionnaire_template_questions` VALUES ('25', '9', '8', '1.0');

-- ----------------------------
-- Table structure for receive_message
-- ----------------------------
DROP TABLE IF EXISTS `receive_message`;
CREATE TABLE `receive_message` (
  `id` int(11) NOT NULL auto_increment,
  `message` int(11) NOT NULL,
  `recipient` int(11) NOT NULL,
  `recipient_type` varchar(64) NOT NULL,
  `flag` tinyint(1) NOT NULL COMMENT '已读或未读标记',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of receive_message
-- ----------------------------
INSERT INTO `receive_message` VALUES ('1', '1', '1', 'student', '1');
INSERT INTO `receive_message` VALUES ('2', '2', '1', 'student', '0');
INSERT INTO `receive_message` VALUES ('3', '3', '1', 'student', '0');
INSERT INTO `receive_message` VALUES ('4', '4', '1', 'student', '0');
INSERT INTO `receive_message` VALUES ('5', '5', '1', 'student', '0');
INSERT INTO `receive_message` VALUES ('6', '6', '1', 'student', '0');
INSERT INTO `receive_message` VALUES ('7', '7', '1', 'student', '0');
INSERT INTO `receive_message` VALUES ('8', '8', '1', 'student', '0');
INSERT INTO `receive_message` VALUES ('9', '9', '1', 'student', '1');
INSERT INTO `receive_message` VALUES ('10', '1', '1', 'teacher', '1');
INSERT INTO `receive_message` VALUES ('11', '2', '1', 'teacher', '0');
INSERT INTO `receive_message` VALUES ('12', '3', '1', 'teacher', '0');
INSERT INTO `receive_message` VALUES ('13', '4', '1', 'teacher', '0');
INSERT INTO `receive_message` VALUES ('14', '5', '1', 'teacher', '0');
INSERT INTO `receive_message` VALUES ('15', '6', '1', 'teacher', '0');
INSERT INTO `receive_message` VALUES ('16', '7', '1', 'teacher', '0');
INSERT INTO `receive_message` VALUES ('17', '8', '1', 'teacher', '0');
INSERT INTO `receive_message` VALUES ('18', '9', '1', 'teacher', '1');

-- ----------------------------
-- Table structure for register
-- ----------------------------
DROP TABLE IF EXISTS `register`;
CREATE TABLE `register` (
  `id` int(11) NOT NULL auto_increment,
  `number` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `password` varchar(16) NOT NULL,
  `header` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of register
-- ----------------------------
INSERT INTO `register` VALUES ('1', '020934', '德信', '123456', '\\register\\00A1D6C23FE16336EE4E2D82F5093D4D.jpg');

-- ----------------------------
-- Table structure for report
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `id` int(11) NOT NULL auto_increment,
  `reported_id` int(11) NOT NULL,
  `reported_type` varchar(64) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `creater` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `handler` int(11) default NULL,
  `handle_time` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of report
-- ----------------------------
INSERT INTO `report` VALUES ('1', '13', 'evaluate', '不知道为什么', '1', '2018-04-20 04:35:36', null, null);
INSERT INTO `report` VALUES ('2', '8', 'evaluate', '瞎点的', '1', '2018-04-20 04:36:59', null, null);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `id` int(11) NOT NULL auto_increment,
  `number` varchar(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `major` int(11) NOT NULL,
  `term` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `credit` decimal(10,0) default NULL COMMENT '学分',
  `hours` decimal(10,0) default NULL COMMENT '学时 单位：课时',
  `test_way` varchar(64) default NULL COMMENT '考核方式',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES ('1', '602044', '软件工程', '45', '1', '1', '3', '30', null);
INSERT INTO `score` VALUES ('2', '602045', '编译原理', '45', '1', '1', '3', '30', null);
INSERT INTO `score` VALUES ('3', '602046', '计算机系统', '45', '1', '1', '3', '20', null);
INSERT INTO `score` VALUES ('4', '602047', '数据结构与算法', '45', '1', '1', '4', '30', null);
INSERT INTO `score` VALUES ('5', '602048', 'Java Web', '45', '1', '1', '3', '25', null);
INSERT INTO `score` VALUES ('6', '602054', 'C++', '45', '1', '1', '2', '20', null);
INSERT INTO `score` VALUES ('7', '602059', 'C程序设计基础', '45', '1', '1', '2', '20', null);
INSERT INTO `score` VALUES ('8', '911138', '茶艺', '1', '1', '4', '2', '18', null);
INSERT INTO `score` VALUES ('9', '942345', '旅游', '1', '1', '4', '2', '18', null);

-- ----------------------------
-- Table structure for score_for_teacher
-- ----------------------------
DROP TABLE IF EXISTS `score_for_teacher`;
CREATE TABLE `score_for_teacher` (
  `id` int(11) NOT NULL auto_increment,
  `score` int(11) NOT NULL,
  `teacher` int(11) NOT NULL,
  `result` decimal(10,2) default NULL COMMENT '成绩',
  `evaluate_grade` decimal(10,2) unsigned zerofill NOT NULL,
  `evaluate_count` int(11) unsigned zerofill NOT NULL,
  `question_grade` decimal(10,2) unsigned zerofill NOT NULL,
  `question_count` int(11) unsigned zerofill NOT NULL,
  `assessment_grade` decimal(10,2) unsigned zerofill NOT NULL,
  `assessment_count` int(11) unsigned zerofill NOT NULL,
  `remarks` varchar(255) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of score_for_teacher
-- ----------------------------
INSERT INTO `score_for_teacher` VALUES ('1', '1', '1', '79.50', '00001030.00', '00000000012', '00000170.00', '00000000002', '00000153.50', '00000000002', '');
INSERT INTO `score_for_teacher` VALUES ('2', '2', '1', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);
INSERT INTO `score_for_teacher` VALUES ('3', '3', '1', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);
INSERT INTO `score_for_teacher` VALUES ('4', '4', '2', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);
INSERT INTO `score_for_teacher` VALUES ('5', '5', '2', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);
INSERT INTO `score_for_teacher` VALUES ('6', '6', '3', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);
INSERT INTO `score_for_teacher` VALUES ('7', '7', '2', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);
INSERT INTO `score_for_teacher` VALUES ('8', '8', '3', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);
INSERT INTO `score_for_teacher` VALUES ('9', '9', '3', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);
INSERT INTO `score_for_teacher` VALUES ('10', '1', '3', null, '00000000.00', '00000000000', '00000000.00', '00000000000', '00000000.00', '00000000000', null);

-- ----------------------------
-- Table structure for score_type
-- ----------------------------
DROP TABLE IF EXISTS `score_type`;
CREATE TABLE `score_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of score_type
-- ----------------------------
INSERT INTO `score_type` VALUES ('1', '专业必修');
INSERT INTO `score_type` VALUES ('2', '专业选修');
INSERT INTO `score_type` VALUES ('3', '通识必修');
INSERT INTO `score_type` VALUES ('4', '通识选修');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键',
  `number` varchar(32) NOT NULL COMMENT '学号',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `sex` tinyint(1) NOT NULL COMMENT '性别',
  `id_card` char(18) NOT NULL COMMENT '身份证',
  `header` varchar(255) default NULL COMMENT '头像',
  `password` varchar(16) NOT NULL COMMENT '密码',
  `time_of_enrollment` datetime NOT NULL COMMENT '入学时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '20144206068', '欧文惠', '1', '430407199602102037', '\\student\\D5E9FC3A89A8870A5B3EF9CA14ADF0E4.jpg', '102037', '2014-09-15 22:21:36');
INSERT INTO `student` VALUES ('2', '20144206999', '阿萨辛', '1', '430408199702163548', null, '163548', '2014-09-14 22:48:08');
INSERT INTO `student` VALUES ('3', '20144206998', '冯超', '1', '430408199701126482', null, '126482', '2014-09-14 22:48:08');
INSERT INTO `student` VALUES ('4', '20144206997', '华瑞', '0', '430406199708120315', null, '120315', '2014-09-14 22:48:08');
INSERT INTO `student` VALUES ('5', '20144206996', '张春霞', '0', '430406199702162315', null, '162315', '2014-09-14 22:48:08');

-- ----------------------------
-- Table structure for study
-- ----------------------------
DROP TABLE IF EXISTS `study`;
CREATE TABLE `study` (
  `id` int(11) NOT NULL auto_increment,
  `score_for_teacher` int(11) NOT NULL,
  `student` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of study
-- ----------------------------
INSERT INTO `study` VALUES ('1', '1', '1');
INSERT INTO `study` VALUES ('2', '1', '2');
INSERT INTO `study` VALUES ('3', '1', '3');
INSERT INTO `study` VALUES ('4', '1', '4');
INSERT INTO `study` VALUES ('5', '1', '5');
INSERT INTO `study` VALUES ('6', '2', '1');
INSERT INTO `study` VALUES ('7', '2', '2');
INSERT INTO `study` VALUES ('8', '2', '3');
INSERT INTO `study` VALUES ('9', '2', '4');
INSERT INTO `study` VALUES ('10', '2', '5');
INSERT INTO `study` VALUES ('11', '3', '1');
INSERT INTO `study` VALUES ('12', '3', '2');
INSERT INTO `study` VALUES ('13', '3', '3');
INSERT INTO `study` VALUES ('14', '3', '4');
INSERT INTO `study` VALUES ('15', '3', '5');
INSERT INTO `study` VALUES ('16', '4', '1');
INSERT INTO `study` VALUES ('17', '4', '2');
INSERT INTO `study` VALUES ('18', '4', '3');
INSERT INTO `study` VALUES ('19', '4', '4');
INSERT INTO `study` VALUES ('20', '4', '5');
INSERT INTO `study` VALUES ('21', '5', '1');
INSERT INTO `study` VALUES ('22', '5', '2');
INSERT INTO `study` VALUES ('23', '5', '3');
INSERT INTO `study` VALUES ('24', '5', '4');
INSERT INTO `study` VALUES ('25', '5', '5');
INSERT INTO `study` VALUES ('26', '6', '1');
INSERT INTO `study` VALUES ('27', '6', '2');
INSERT INTO `study` VALUES ('28', '6', '3');
INSERT INTO `study` VALUES ('29', '6', '4');
INSERT INTO `study` VALUES ('30', '6', '5');
INSERT INTO `study` VALUES ('31', '7', '1');
INSERT INTO `study` VALUES ('32', '7', '2');
INSERT INTO `study` VALUES ('33', '7', '3');
INSERT INTO `study` VALUES ('34', '7', '4');
INSERT INTO `study` VALUES ('35', '7', '5');
INSERT INTO `study` VALUES ('36', '8', '1');
INSERT INTO `study` VALUES ('37', '8', '2');
INSERT INTO `study` VALUES ('38', '8', '3');
INSERT INTO `study` VALUES ('39', '8', '4');
INSERT INTO `study` VALUES ('40', '8', '5');
INSERT INTO `study` VALUES ('41', '9', '1');
INSERT INTO `study` VALUES ('42', '9', '2');
INSERT INTO `study` VALUES ('43', '9', '3');
INSERT INTO `study` VALUES ('44', '9', '4');
INSERT INTO `study` VALUES ('45', '9', '5');

-- ----------------------------
-- Table structure for stu_for_class
-- ----------------------------
DROP TABLE IF EXISTS `stu_for_class`;
CREATE TABLE `stu_for_class` (
  `id` int(11) NOT NULL auto_increment,
  `stu_id` int(11) NOT NULL COMMENT '学生编号',
  `class_id` int(11) NOT NULL COMMENT '班级编号',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of stu_for_class
-- ----------------------------
INSERT INTO `stu_for_class` VALUES ('1', '1', '1');
INSERT INTO `stu_for_class` VALUES ('2', '2', '1');
INSERT INTO `stu_for_class` VALUES ('3', '3', '1');
INSERT INTO `stu_for_class` VALUES ('4', '4', '1');
INSERT INTO `stu_for_class` VALUES ('5', '5', '1');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `id` int(11) NOT NULL auto_increment,
  `number` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `password` varchar(16) NOT NULL,
  `major` int(11) NOT NULL,
  `business` varchar(64) default NULL COMMENT '职称',
  `email` varchar(128) default '',
  `phone` varchar(16) default '',
  `QQ` varchar(32) default '',
  `wechat` varchar(64) default '',
  `header` varchar(255) default NULL,
  `evaluate` varchar(255) default NULL COMMENT '总评',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '010943', '欧辰', '1', '123456', '45', '讲师', null, null, null, null, '\\teacher\\697F5DD87CA456E3E57F1364A6ECC2F2.jpg', null);
INSERT INTO `teacher` VALUES ('2', '010944', '张珊', '0', '123456', '45', '教授', null, null, null, null, null, null);
INSERT INTO `teacher` VALUES ('3', '010945', '学尔森', '1', '123456', '45', '讲师', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for term
-- ----------------------------
DROP TABLE IF EXISTS `term`;
CREATE TABLE `term` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键',
  `name` varchar(128) NOT NULL COMMENT '学期名称 例如2014—2015下',
  `start_time` datetime NOT NULL COMMENT '学期开始时间',
  `end_time` datetime NOT NULL COMMENT '学期结束时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of term
-- ----------------------------
INSERT INTO `term` VALUES ('1', '2017-2018年下学期', '2018-03-01 00:00:00', '2018-07-02 00:00:00');
