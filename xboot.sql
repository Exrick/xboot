/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : xboot

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2018-10-08 11:21:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('quartzScheduler', 'cn.exrick.xboot.quartz.jobs.SampleJob', 'DEFAULT', '0/1 * * * * ? ', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('quartzScheduler', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'DEFAULT', '0/1 * * * * ? ', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('quartzScheduler', 'cn.exrick.xboot.quartz.jobs.SampleJob', 'DEFAULT', null, 'cn.exrick.xboot.quartz.jobs.SampleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000001740009706172616D657465727400007800);
INSERT INTO `qrtz_job_details` VALUES ('quartzScheduler', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'DEFAULT', null, 'cn.exrick.xboot.quartz.jobs.SampleParamJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C77080000001000000001740009706172616D65746572740005576F726C647800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('quartzScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('quartzScheduler', 'cn.exrick.xboot.quartz.jobs.SampleJob', 'DEFAULT', 'cn.exrick.xboot.quartz.jobs.SampleJob', 'DEFAULT', null, '1534080837000', '1534080836000', '5', 'PAUSED', 'CRON', '1534080790000', '0', null, '0', '');
INSERT INTO `qrtz_triggers` VALUES ('quartzScheduler', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'DEFAULT', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'DEFAULT', null, '1537715980000', '1537715979000', '5', 'PAUSED', 'CRON', '1534081976000', '0', null, '0', '');

-- ----------------------------
-- Table structure for t_department
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('40327253309001728', '', '2018-08-10 20:58:27', '0', '', '2018-08-11 17:26:38', '40322811096469504', '3.00', '-1', '人工智障', null);
INSERT INTO `t_department` VALUES ('40322777781112832', '', '2018-08-10 20:40:40', '0', '', '2018-08-11 00:03:06', '0', '1.00', '0', '总部', '');
INSERT INTO `t_department` VALUES ('40322811096469504', '', '2018-08-10 20:40:48', '0', '', '2018-08-11 00:27:05', '40322777781112832', '1.00', '0', '技术部', '');
INSERT INTO `t_department` VALUES ('40322852833988608', '', '2018-08-10 20:40:58', '0', '', '2018-08-11 01:29:42', '40322811096469504', '1.00', '0', '研发中心', null);
INSERT INTO `t_department` VALUES ('40327204755738624', '', '2018-08-10 20:58:15', '0', '', '2018-08-10 22:02:15', '40322811096469504', '2.00', '0', '大数据', null);
INSERT INTO `t_department` VALUES ('40343262766043136', '', '2018-08-10 22:02:04', '0', '', '2018-08-11 00:02:53', '0', '2.00', '0', '成都分部', '');
INSERT INTO `t_department` VALUES ('40681289119961088', '', '2018-08-11 20:25:16', '0', '', '2018-08-11 22:47:48', '40652270295060480', '2.00', '0', 'VIP', '\0');
INSERT INTO `t_department` VALUES ('40344005342400512', '', '2018-08-10 22:05:01', '0', '', '2018-08-11 17:48:44', '40343262766043136', '2.00', '0', 'Vue', null);
INSERT INTO `t_department` VALUES ('40652270295060480', '', '2018-08-11 18:29:57', '0', '', '2018-08-12 18:45:01', '0', '3.00', '0', '人事部', '');
INSERT INTO `t_department` VALUES ('40389030113710080', '', '2018-08-11 01:03:56', '0', '', '2018-08-11 17:50:04', '40343262766043136', '1.00', '0', 'JAVA', '\0');
INSERT INTO `t_department` VALUES ('40652338142121984', null, '2018-08-11 18:30:13', '0', null, '2018-08-11 18:30:13', '40652270295060480', '1.00', '0', '游客', '\0');

-- ----------------------------
-- Table structure for t_file
-- ----------------------------
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `f_key` varchar(255) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_file
-- ----------------------------

-- ----------------------------
-- Table structure for t_github
-- ----------------------------
DROP TABLE IF EXISTS `t_github`;
CREATE TABLE `t_github` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `is_related` bit(1) DEFAULT NULL,
  `open_id` varchar(255) DEFAULT NULL,
  `relate_username` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_github
-- ----------------------------

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cost_time` int(11) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `ip_info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `request_param` varchar(255) DEFAULT NULL,
  `request_type` varchar(255) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_send` bit(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `content` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
INSERT INTO `t_message` VALUES ('43615268366192640', '', '2018-08-19 22:43:51', '0', '', '2018-08-24 23:02:13', '', '欢迎您注册账号使用X-Boot 点我查看使用须知', '0', '<p style=\"text-align: center;\">X-Boot是很棒的Web前后端分离开发平台，开源版本请遵循GPL v3.0开源协议，不得闭源，商用需求请联系作者签署授权协议。</p><p style=\"text-align: center;\">捐赠获取完整版：<a href=\"http://xpay.exrick.cn/pay?xboot\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">立即去捐赠获取</a></p><p style=\"text-align: center;\"><img src=\"https://i.loli.net/2018/08/24/5b801c8652227.png\" style=\"max-width:150px;\"><br></p><p style=\"text-align: center;\">（支持手机扫码支付）</p><p style=\"text-align: center;\">获取商用授权：<a href=\"http://wpa.qq.com/msgrd?v=3&amp;uin=1012139570&amp;site=qq&amp;menu=yes\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">立即联系作者获取商用授权</a></p>');

-- ----------------------------
-- Table structure for t_message_send
-- ----------------------------
DROP TABLE IF EXISTS `t_message_send`;
CREATE TABLE `t_message_send` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `message_id` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message_send
-- ----------------------------
INSERT INTO `t_message_send` VALUES ('43615268663988224', null, '2018-08-19 22:43:51', '0', null, '2018-08-19 22:43:51', '43615268366192640', '0', '682265633886209');
INSERT INTO `t_message_send` VALUES ('43615268663988225', null, '2018-08-19 22:43:51', '0', null, '2018-08-19 22:43:51', '43615268366192640', '0', '16739222421508096');
INSERT INTO `t_message_send` VALUES ('43615268663988226', '', '2018-08-19 22:43:51', '0', '', '2018-08-24 12:41:24', '43615268366192640', '2', '4363087427670016');
INSERT INTO `t_message_send` VALUES ('43615268663988227', '', '2018-08-19 22:43:51', '0', '', '2018-08-21 18:24:43', '43615268366192640', '1', '682265633886208');

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `button_type` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES ('5129710648430592', '', '2018-06-04 19:02:29', '0', '', '2018-09-29 23:11:56', '', 'sys', '', '0', '1.00', 'Main', '/sys', '系统管理', 'ios-settings', '1', '', '0', '');
INSERT INTO `t_permission` VALUES ('5129710648430593', '', '2018-06-04 19:02:32', '0', '', '2018-08-13 15:15:33', '', 'user-manage', '5129710648430592', '0', '1.10', 'sys/user-manage/userManage', 'user-manage', '用户管理', 'md-person', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('5129710648430594', '', '2018-06-04 19:02:35', '0', '', '2018-09-23 23:32:16', '', 'role-manage', '5129710648430592', '0', '1.60', 'sys/role-manage/roleManage', 'role-manage', '角色管理', 'md-contacts', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('5129710648430595', '', '2018-06-04 19:02:37', '0', '', '2018-09-23 23:32:02', '', 'menu-manage', '5129710648430592', '0', '1.70', 'sys/menu-manage/menuManage', 'menu-manage', '菜单权限管理', 'md-menu', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41375330996326400', '', '2018-08-13 18:23:08', '0', '', '2018-08-15 17:13:23', '', 'simple-table', '41373430515240960', '0', '4.10', 'xboot-vue-template/simple-table/simpleTable', 'simple-table', '简单表格', 'ios-grid-outline', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('15701400130424832', '', '2018-06-03 22:04:06', '0', '', '2018-09-19 22:16:44', '', '', '5129710648430593', '1', '1.11', '', '/xboot/user/admin/add*', '添加用户', '', '3', 'add', '0', '');
INSERT INTO `t_permission` VALUES ('15701915807518720', '', '2018-06-03 22:06:09', '0', '', '2018-06-06 14:46:51', '', '', '5129710648430593', '1', '1.13', '', '/xboot/user/admin/disable/**', '禁用用户', '', '3', 'disable', '0', null);
INSERT INTO `t_permission` VALUES ('15708892205944832', '', '2018-06-03 22:33:52', '0', '', '2018-06-28 16:44:48', '', '', '5129710648430593', '1', '1.14', '', '/xboot/user/admin/enable/**', '启用用户', '', '3', 'enable', '0', null);
INSERT INTO `t_permission` VALUES ('16392452747300864', '', '2018-06-05 19:50:06', '0', '', '2018-08-13 18:15:39', '', 'access', '', '0', '4.00', 'Main', '/access', '权限按钮测试页', 'md-lock', '1', '', '0', '');
INSERT INTO `t_permission` VALUES ('16392767785668608', '', '2018-06-05 19:51:21', '0', '', '2018-09-21 23:31:06', '', 'access_index', '16392452747300864', '0', '4.10', 'access/access', 'index', '权限按钮测试页', 'md-lock', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('16438800255291392', '', '2018-06-05 22:54:18', '0', '', '2018-08-13 18:15:51', '', '', '16392767785668608', '1', '4.11', '', 'test-add', '添加按钮测试', '', '3', 'add', '0', '');
INSERT INTO `t_permission` VALUES ('16438962738434048', '', '2018-06-05 22:54:55', '0', '', '2018-08-13 18:16:29', '', '', '16392767785668608', '1', '4.12', '', 'edit-test', '编辑按钮测试', '', '3', 'edit', '0', '');
INSERT INTO `t_permission` VALUES ('16439068543946752', '', '2018-06-05 22:55:20', '0', '', '2018-08-13 18:16:12', '', '', '16392767785668608', '1', '4.13', '', 'delete-test', '删除按钮测试', '', '3', 'delete', '0', '');
INSERT INTO `t_permission` VALUES ('16678126574637056', '', '2018-06-06 14:45:16', '0', '', '2018-09-19 22:16:48', '', '', '5129710648430593', '1', '1.12', '', '/xboot/user/admin/edit*', '编辑用户', '', '3', 'edit', '0', '');
INSERT INTO `t_permission` VALUES ('16678447719911424', '', '2018-06-06 14:46:32', '0', '', '2018-08-10 21:41:16', '', '', '5129710648430593', '1', '1.15', '', '/xboot/user/delByIds/**', '删除用户', '', '3', 'delete', '0', '');
INSERT INTO `t_permission` VALUES ('16687383932047360', '', '2018-06-06 15:22:03', '0', '', '2018-09-19 22:07:34', '', '', '5129710648430594', '1', '1.21', '', '/xboot/role/save*', '添加角色', '', '3', 'add', '0', '');
INSERT INTO `t_permission` VALUES ('16689632049631232', '', '2018-06-06 15:30:59', '0', '', '2018-09-19 22:07:37', '', '', '5129710648430594', '1', '1.22', '', '/xboot/role/edit*', '编辑角色', '', '3', 'edit', '0', '');
INSERT INTO `t_permission` VALUES ('16689745006432256', '', '2018-06-06 15:31:26', '0', '', '2018-08-10 21:41:23', '', '', '5129710648430594', '1', '1.23', '', '/xboot/role/delAllByIds/**', '删除角色', '', '3', 'delete', '0', '');
INSERT INTO `t_permission` VALUES ('16689883993083904', null, '2018-06-06 15:31:59', '0', null, '2018-06-06 15:31:59', null, null, '5129710648430594', '1', '1.24', null, '/xboot/role/editRolePerm/**', '分配权限', null, '3', 'editPerm', '0', null);
INSERT INTO `t_permission` VALUES ('16690313745666048', '', '2018-06-06 15:33:41', '0', '', '2018-09-19 22:07:46', '', '', '5129710648430594', '1', '1.25', '', '/xboot/role/setDefault*', '设为默认角色', '', '3', 'setDefault', '0', '');
INSERT INTO `t_permission` VALUES ('16694861252005888', '', '2018-06-06 15:51:46', '0', '', '2018-09-19 22:07:52', '', '', '5129710648430595', '1', '1.31', '', '/xboot/permission/add*', '添加菜单', '', '3', 'add', '0', '');
INSERT INTO `t_permission` VALUES ('16695107491205120', '', '2018-06-06 15:52:44', '0', '', '2018-09-19 22:07:57', '', '', '5129710648430595', '1', '1.32', '', '/xboot/permission/edit*', '编辑菜单', '', '3', 'edit', '0', '');
INSERT INTO `t_permission` VALUES ('16695243126607872', '', '2018-06-06 15:53:17', '0', '', '2018-08-10 21:41:33', '', '', '5129710648430595', '1', '1.33', '', '/xboot/permission/delByIds/**', '删除菜单', '', '3', 'delete', '0', '');
INSERT INTO `t_permission` VALUES ('41371711400054784', '', '2018-08-13 18:08:45', '0', '', '2018-08-14 12:31:15', '', 'actuator', '39915540965232640', '0', '2.30', 'sys/actuator/actuator', 'actuator', 'Actuator监控[付费]', 'logo-angular', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41370251991977984', null, '2018-08-13 18:02:57', '0', null, '2018-08-13 18:02:57', null, 'quartz-job', '39915540965232640', '0', '2.10', 'sys/quartz-manage/quartzManage', 'quartz-job', '定时任务', 'md-time', '2', '', '0', null);
INSERT INTO `t_permission` VALUES ('25014528525733888', '', '2018-06-29 14:51:09', '0', '', '2018-10-08 11:13:27', '', '', '5129710648430593', '1', '1.16', '', '无', '上传图片', '', '3', 'upload', '0', '');
INSERT INTO `t_permission` VALUES ('39915540965232640', null, '2018-08-09 17:42:28', '0', null, '2018-08-09 17:42:28', null, 'monitor', null, '0', '2.00', 'Main', '/monitor', '系统监控', 'ios-analytics', '1', null, '0', null);
INSERT INTO `t_permission` VALUES ('39916171171991552', '', '2018-08-09 17:44:57', '0', '', '2018-08-25 12:13:11', '', 'druid', '39915540965232640', '0', '2.40', 'sys/monitor/monitor', 'druid', 'SQL监控', 'md-analytics', '2', '', '0', 'http://xboot.exrick.cn/druid/login.html');
INSERT INTO `t_permission` VALUES ('39918482854252544', '', '2018-08-09 17:54:08', '0', '', '2018-08-25 12:13:27', '', 'swagger', '39915540965232640', '0', '2.50', 'sys/monitor/monitor', 'swagger', '接口文档', 'md-document', '2', '', '0', 'http://xboot.exrick.cn/swagger-ui.html');
INSERT INTO `t_permission` VALUES ('40238597734928384', null, '2018-08-10 15:06:10', '0', null, '2018-08-10 15:06:10', null, 'department-manage', '5129710648430592', '0', '1.20', 'sys/department-manage/departmentManage', 'department-manage', '部门管理', 'md-git-branch', '2', '', '0', null);
INSERT INTO `t_permission` VALUES ('42082442672082944', '', '2018-08-15 17:12:57', '0', '', '2018-09-25 15:17:59', '', 'new-window', '41373430515240960', '0', '4.60', 'xboot-vue-template/new-window/newWindow', 'new-window', '新窗口操作[付费]', 'ios-browsers', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41373430515240960', '', '2018-08-13 18:15:35', '0', '', '2018-08-15 14:29:48', '', 'xboot-vue-template', '', '0', '3.00', 'Main', '/xboot-vue-template', '前端Vue模版', 'ios-albums', '1', '', '0', '');
INSERT INTO `t_permission` VALUES ('41363147411427328', '', '2018-08-13 17:34:43', '0', '', '2018-08-20 20:05:21', '', 'log-manage', '39915540965232640', '0', '2.20', 'sys/log-manage/logManage', 'log-manage', '操作日志管理', 'md-list-box', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41363537456533504', '', '2018-08-13 17:36:16', '0', '', '2018-08-13 17:56:11', '', '', '41363147411427328', '1', '2.11', '', '/xboot/log/delByIds/**', '删除日志', '', '3', 'delete', '0', '');
INSERT INTO `t_permission` VALUES ('41364927394353152', '', '2018-08-13 17:41:48', '0', '', '2018-09-19 22:08:57', '', '', '41363147411427328', '1', '2.12', '', '/xboot/log/delAll*', '清空日志', '', '3', 'undefined', '0', '');
INSERT INTO `t_permission` VALUES ('41376192166629376', '', '2018-08-13 18:26:33', '0', '', '2018-08-15 17:13:34', '', 'search-table', '41373430515240960', '0', '4.20', 'xboot-vue-template/search-table/searchTable', 'search-table', '搜索表格[付费]', 'md-grid', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41377034236071936', '', '2018-08-13 18:29:54', '0', '', '2018-08-15 17:13:40', '', 'complex-table', '41373430515240960', '0', '4.30', 'xboot-vue-template/complex-table/complexTable', 'complex-table', '复杂表格[付费]', 'ios-grid', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41378916912336896', '', '2018-08-13 18:37:23', '0', '', '2018-09-25 15:19:50', '', 'tree', '41373430515240960', '0', '4.50', 'xboot-vue-template/tree/tree', 'tree', '树形结构[付费]', 'ios-git-network', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41469219249852416', null, '2018-08-14 00:36:13', '0', null, '2018-08-14 00:36:13', null, '', '41371711400054784', '1', '2.31', '', '无', '查看数据', '', '3', 'view', '0', null);
INSERT INTO `t_permission` VALUES ('42087054753927168', '', '2018-08-15 17:31:16', '0', '', '2018-09-25 15:18:05', '', 'html-edit', '41373430515240960', '0', '4.70', 'xboot-vue-template/html-edit/htmlEdit', 'html-edit', '富文本编辑[付费]', 'ios-create', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('43117268627886080', '', '2018-08-18 13:44:58', '0', '', '2018-08-18 20:55:04', '', 'message-manage', '5129710648430592', '0', '1.30', 'sys/message-manage/messageManage', 'message-manage', '消息管理[付费]', 'md-mail', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('44986029924421632', '', '2018-08-23 17:30:46', '0', '', '2018-09-23 23:26:53', '', 'social-manage', '5129710648430592', '0', '1.50', 'sys/social-manage/socialManage', 'social-manage', '社交账号绑定[付费]', 'md-share', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('45069342940860416', '', '2018-08-23 23:01:49', '0', '', '2018-08-24 10:01:09', '', '', '44986029924421632', '1', '1.42', '', '无', '查看社交账号数据', '', '3', 'view', '0', '');
INSERT INTO `t_permission` VALUES ('45235228800716800', '', '2018-08-24 10:01:00', '0', '', '2018-09-19 22:07:23', '', '', '44986029924421632', '1', '1.41', '', '/xboot/relate/delByIds*', '删除解绑', '', '3', 'delete', '0', '');
INSERT INTO `t_permission` VALUES ('45235621697949696', '', '2018-08-24 10:02:33', '0', '', '2018-09-19 22:06:57', '', '', '40238597734928384', '1', '1.21', '', '/xboot/department/add*', '添加部门', '', '3', 'add', '0', '');
INSERT INTO `t_permission` VALUES ('45235787867885568', '', '2018-08-24 10:03:13', '0', '', '2018-09-19 22:07:02', '', '', '40238597734928384', '1', '1.22', '', '/xboot/department/edit*', '编辑部门', '', '3', 'edit', '0', '');
INSERT INTO `t_permission` VALUES ('45235939278065664', null, '2018-08-24 10:03:49', '0', null, '2018-08-24 10:03:49', null, '', '40238597734928384', '1', '1.23', '', '/xboot/department/delByIds/*', '删除部门', '', '3', 'delete', '0', null);
INSERT INTO `t_permission` VALUES ('45236734832676864', '', '2018-08-24 10:06:59', '0', '', '2018-09-19 22:07:07', '', '', '43117268627886080', '1', '1.31', '', '/xboot/message/add*', '添加消息', '', '3', 'add', '0', '');
INSERT INTO `t_permission` VALUES ('45237010692050944', '', '2018-08-24 10:08:04', '0', '', '2018-09-19 22:07:12', '', '', '43117268627886080', '1', '1.32', '', '/xboot/message/edit*', '编辑消息', '', '3', 'edit', '0', '');
INSERT INTO `t_permission` VALUES ('45237170029465600', null, '2018-08-24 10:08:42', '0', null, '2018-08-24 10:08:42', null, '', '43117268627886080', '1', '1.33', '', '/xboot/message/delByIds/*', '删除消息', '', '3', 'delete', '0', null);
INSERT INTO `t_permission` VALUES ('45264987354042368', '', '2018-08-24 11:59:14', '0', '', '2018-09-19 22:08:11', '', '', '41370251991977984', '1', '2.11', '', '/xboot/quartzJob/add*', '添加定时任务', '', '3', 'add', '0', '');
INSERT INTO `t_permission` VALUES ('45265487029866496', '', '2018-08-24 12:01:14', '0', '', '2018-09-19 22:08:17', '', '', '41370251991977984', '1', '2.12', '', '/xboot/quartzJob/edit*', '编辑定时任务', '', '3', 'edit', '0', '');
INSERT INTO `t_permission` VALUES ('45265762415284224', '', '2018-08-24 12:02:19', '0', '', '2018-09-19 22:08:24', '', '', '41370251991977984', '1', '2.13', '', '/xboot/quartzJob/pause*', '暂停定时任务', '', '3', 'disable', '0', '');
INSERT INTO `t_permission` VALUES ('45265886315024384', '', '2018-08-24 12:02:49', '0', '', '2018-09-19 22:09:13', '', '', '41370251991977984', '1', '2.14', '', '/xboot/quartzJob/resume*', '恢复定时任务', '', '3', 'enable', '0', '');
INSERT INTO `t_permission` VALUES ('45266070000373760', null, '2018-08-24 12:03:33', '0', null, '2018-08-24 12:03:33', null, '', '41370251991977984', '1', '2.15', '', '/xboot/quartzJob/delByIds/*', '删除定时任务', '', '3', 'delete', '0', null);
INSERT INTO `t_permission` VALUES ('56309618086776832', null, '2018-09-23 23:26:40', '0', null, '2018-09-23 23:26:40', null, 'oss-manage', '5129710648430592', '0', '1.40', 'sys/oss-manage/ossManage', 'oss-manage', 'OSS对象存储[付费]', 'ios-folder', '2', '', '0', null);
INSERT INTO `t_permission` VALUES ('56898976661639168', '', '2018-09-25 14:28:34', '0', '', '2018-09-25 15:12:46', '', '', '5129710648430593', '1', '1.17', '', '/xboot/user/importData*', '导入用户', '', '3', 'input', '0', '');
INSERT INTO `t_permission` VALUES ('56911328312299520', '', '2018-09-25 15:17:39', '0', '', '2018-09-25 18:31:49', '', 'excel', '41373430515240960', '0', '4.40', 'xboot-vue-template/excel/excel', 'excel', 'Excel导入导出[付费]', 'md-exit', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('57009544286441472', null, '2018-09-25 21:47:55', '0', null, '2018-09-25 21:47:55', null, '', '43117268627886080', '1', '1.40', '', '/xboot/messageSend/save*', '添加已发送消息', '', '3', 'add', '0', null);
INSERT INTO `t_permission` VALUES ('57009744761589760', null, '2018-09-25 21:48:43', '0', null, '2018-09-25 21:48:43', null, '', '43117268627886080', '1', '1.50', '', '/xboot/messageSend/update*', '编辑已发送消息', '', '3', 'edit', '0', null);
INSERT INTO `t_permission` VALUES ('57009981228060672', null, '2018-09-25 21:49:39', '0', null, '2018-09-25 21:49:39', null, '', '43117268627886080', '1', '1.60', '', '/xboot/messageSend/delByIds/*', '删除已发送消息', '', '3', 'delete', '0', null);
INSERT INTO `t_permission` VALUES ('57212882168844288', '', '2018-09-26 11:15:55', '0', '', '2018-10-08 11:10:05', '', '', '56309618086776832', '1', '1.41', '', '无', '上传文件', '', '3', 'upload', '0', '');
INSERT INTO `t_permission` VALUES ('58480609315524608', '', '2018-09-29 23:13:24', '0', '', '2018-09-29 23:17:59', '', 'setting', '5129710648430592', '0', '1.80', 'sys/setting-manage/settingManage', 'setting', '系统配置[付费]', 'ios-settings-outline', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('61394706252173312', null, '2018-10-08 00:12:59', '0', null, '2018-10-08 00:12:59', null, '', '58480609315524608', '1', '1.81', '', '/xboot/setting/seeSecret/**', '查看私密配置', '', '3', 'view', '0', null);
INSERT INTO `t_permission` VALUES ('61417744146370560', '', '2018-10-08 01:44:32', '0', '', '2018-10-08 01:50:03', '', '', '58480609315524608', '1', '1.82', '', '/xboot/setting/*/set*', '编辑配置', '', '3', 'edit', '0', '');
INSERT INTO `t_permission` VALUES ('61560480518377472', null, '2018-10-08 11:11:43', '0', null, '2018-10-08 11:11:43', null, '', '56309618086776832', '1', '1.44', '', '/xboot/file/delete/*', '删除文件', '', '3', 'delete', '0', null);
INSERT INTO `t_permission` VALUES ('61560275261722624', null, '2018-10-08 11:10:54', '0', null, '2018-10-08 11:10:54', null, '', '56309618086776832', '1', '1.43', '', '/xboot/file/copy*', '复制文件', '', '3', 'edit', '0', null);
INSERT INTO `t_permission` VALUES ('61560041605435392', null, '2018-10-08 11:09:58', '0', null, '2018-10-08 11:09:58', null, '', '56309618086776832', '1', '1.42', '', '/xboot/file/rename*', '重命名文件', '', '3', 'edit', '0', null);

-- ----------------------------
-- Table structure for t_qq
-- ----------------------------
DROP TABLE IF EXISTS `t_qq`;
CREATE TABLE `t_qq` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `is_related` bit(1) DEFAULT NULL,
  `open_id` varchar(255) DEFAULT NULL,
  `relate_username` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_qq
-- ----------------------------

-- ----------------------------
-- Table structure for t_quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `t_quartz_job`;
CREATE TABLE `t_quartz_job` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `job_class_name` varchar(255) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_quartz_job
-- ----------------------------
INSERT INTO `t_quartz_job` VALUES ('41065738420621312', '', '2018-08-12 21:52:56', '0', '', '2018-09-23 23:19:39', '0/1 * * * * ? ', '带参测试 后台将每隔1秒执行输出日志', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'World', '-1');
INSERT INTO `t_quartz_job` VALUES ('41060689401352192', '', '2018-08-12 20:32:52', '0', '', '2018-08-12 21:33:56', '0/1 * * * * ? ', '无参测试 后台将每隔1秒执行输出日志', 'cn.exrick.xboot.quartz.jobs.SampleJob', '', '-1');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `default_role` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('496138616573952', '', '2018-04-22 23:03:49', '', '2018-08-12 16:14:31', 'ROLE_ADMIN', '0', null, '超级管理员 拥有所有权限');
INSERT INTO `t_role` VALUES ('496138616573953', '', '2018-05-02 21:40:03', '', '2018-08-16 13:33:15', 'ROLE_USER', '0', '', '普通注册用户 路过看看');
INSERT INTO `t_role` VALUES ('16457350655250432', '', '2018-06-06 00:08:00', '', '2018-08-16 13:33:30', 'ROLE_TEST', '0', null, '测试权限按钮显示');

-- ----------------------------
-- Table structure for t_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `permission_id` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
INSERT INTO `t_role_permission` VALUES ('16457624555884544', null, '2018-06-06 00:09:04', '0', null, '2018-06-06 00:09:04', '16392452747300864', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('16457624597827584', null, '2018-06-06 00:09:04', '0', null, '2018-06-06 00:09:04', '16392767785668608', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('16457624643964928', null, '2018-06-06 00:09:04', '0', null, '2018-06-06 00:09:04', '16439068543946752', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('61560538731122689', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16439068543946752', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538726928385', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16438962738434048', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538718539777', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16438800255291392', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61414448241315840', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '16439068543946752', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414448207761408', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '16438962738434048', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414448165818368', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '16438800255291392', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414448123875328', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '16392767785668608', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414448069349376', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '16392452747300864', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414448014823424', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '42087054753927168', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447985463296', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '42082442672082944', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447935131648', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '41378916912336896', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447884800000', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '56911328312299520', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447868022784', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '41377034236071936', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447847051264', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '41376192166629376', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447826079744', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '41375330996326400', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447813496832', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '41373430515240960', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447796719616', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '39918482854252544', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447758970880', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '39916171171991552', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447717027840', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '41371711400054784', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447675084800', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '41363147411427328', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447666696192', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '41370251991977984', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447649918976', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '39915540965232640', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447633141760', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '58480609315524608', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447603781632', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '5129710648430595', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447574421504', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '5129710648430594', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447524089856', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '44986029924421632', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447486341120', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '56309618086776832', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447431815168', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '43117268627886080', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447381483520', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '40238597734928384', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447368900608', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '5129710648430593', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61414447305986048', null, '2018-10-08 01:31:26', '0', null, '2018-10-08 01:31:26', '5129710648430592', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('61560538714345473', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16392767785668608', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538710151169', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16392452747300864', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538705956865', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '42087054753927168', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538701762561', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '42082442672082944', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538697568256', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41378916912336896', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538693373952', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '56911328312299520', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538684985345', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41377034236071936', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538680791041', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41376192166629376', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538676596736', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41375330996326400', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538668208128', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41373430515240960', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538575933441', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '39918482854252544', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538571739137', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '39916171171991552', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538567544833', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41469219249852416', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538563350529', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41371711400054784', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538559156225', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41364927394353152', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538554961921', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41363537456533504', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538550767616', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41363147411427328', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538542379008', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45266070000373760', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538529796096', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45265886315024384', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538504630272', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45265762415284224', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538462687232', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45265487029866496', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538437521408', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45264987354042368', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538429132801', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '41370251991977984', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538424938497', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '39915540965232640', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538420744193', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '61417744146370560', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538416549889', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '61394706252173312', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538412355585', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '58480609315524608', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538408161280', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16695243126607872', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538403966976', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16695107491205120', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538399772672', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16694861252005888', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538370412545', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '5129710648430595', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538324275200', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16690313745666048', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538320080896', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16689883993083904', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538315886592', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16689745006432256', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538311692288', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16689632049631232', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538307497984', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16687383932047360', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538303303680', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '5129710648430594', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538273943553', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45069342940860416', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538232000513', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45235228800716800', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538227806209', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '44986029924421632', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538219417601', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '61560480518377472', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538215223297', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '61560275261722624', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538211028993', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '61560041605435392', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538206834688', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '57212882168844288', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538202640384', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '56309618086776832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538194251777', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '57009981228060672', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538190057472', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '57009744761589760', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538177474560', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '57009544286441472', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538173280256', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45237170029465600', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538169085952', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45237010692050944', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538143920128', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45236734832676864', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538135531520', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '43117268627886080', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538097782784', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45235939278065664', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538072616960', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45235787867885568', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538064228352', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '45235621697949696', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538034868225', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '40238597734928384', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538030673921', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '56898976661639168', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538026479617', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '25014528525733888', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538022285313', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16678447719911424', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538018091008', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '15708892205944832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560538009702400', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '15701915807518720', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560537946787840', null, '2018-10-08 11:11:57', '0', null, '2018-10-08 11:11:57', '16678126574637056', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560537896456192', null, '2018-10-08 11:11:56', '0', null, '2018-10-08 11:11:56', '15701400130424832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560537850318848', null, '2018-10-08 11:11:56', '0', null, '2018-10-08 11:11:56', '5129710648430593', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('61560537766432768', null, '2018-10-08 11:11:56', '0', null, '2018-10-08 11:11:56', '5129710648430592', '496138616573952');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(1000) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `department_id` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('682265633886209', '', '2018-04-30 23:28:42', '', '2018-09-26 20:07:00', '', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012@qq.com', '18782059033', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '1', '-1', '0', 'Exrick', '0', '40322777781112832', null);
INSERT INTO `t_user` VALUES ('16739222421508096', '', '2018-06-06 18:48:02', '', '2018-10-08 00:04:32', '', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012139570@qq.com', '18782059033', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '1', '0', '0', 'test2', '0', '40652338142121984', '');
INSERT INTO `t_user` VALUES ('4363087427670016', '', '2018-05-03 15:09:42', '', '2018-10-08 00:04:46', '[\"510000\",\"510100\",\"510114\"]', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012139570@qq.com', '18782059033', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '1', '0', '0', 'test', '0', '40652338142121984', '');
INSERT INTO `t_user` VALUES ('682265633886208', '', '2018-05-01 16:13:51', '', '2018-10-08 00:05:09', '[\"510000\",\"510100\",\"510104\"]', 'http://p77xsahe9.bkt.clouddn.com/788eb3e78206429eb34fc7cd3e1e46f4.jpg', 'test', '1012139570@qq.com', '18782059033', 'Exrick', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '1', '0', '1', 'admin', '0', '40322777781112832', '天府1街');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('56658621068480512', null, null, '0', null, null, '496138616573953', '56658620485472256');
INSERT INTO `t_user_role` VALUES ('16056421829316608', null, '2018-06-04 21:34:50', '0', null, '2018-06-04 21:34:50', '496138616573953', '6118792149078016');
INSERT INTO `t_user_role` VALUES ('40720091502874624', null, '2018-08-11 22:59:27', '0', null, '2018-08-11 22:59:27', '496138616573952', '682265633886209');
INSERT INTO `t_user_role` VALUES ('56657505429753856', null, null, '0', null, null, '496138616573953', '56657504930631680');
INSERT INTO `t_user_role` VALUES ('56656870651203584', null, null, '0', null, null, '496138616573953', '56656870185635840');
INSERT INTO `t_user_role` VALUES ('61392579396112384', null, '2018-10-08 00:04:32', '0', null, '2018-10-08 00:04:32', '16457350655250432', '16739222421508096');
INSERT INTO `t_user_role` VALUES ('61392637076180992', null, '2018-10-08 00:04:46', '0', null, '2018-10-08 00:04:46', '496138616573953', '4363087427670016');
INSERT INTO `t_user_role` VALUES ('61392732320436225', null, '2018-10-08 00:05:09', '0', null, '2018-10-08 00:05:09', '496138616573952', '682265633886208');
INSERT INTO `t_user_role` VALUES ('40720091490291713', null, '2018-08-11 22:59:27', '0', null, '2018-08-11 22:59:27', '496138616573953', '682265633886209');
INSERT INTO `t_user_role` VALUES ('56659754742714369', null, null, '0', null, null, '496138616573953', '56659754142928896');
INSERT INTO `t_user_role` VALUES ('56636805901979648', null, null, '0', null, null, '496138616573953', '56636653837488128');
INSERT INTO `t_user_role` VALUES ('56636806413684736', null, null, '0', null, null, '496138616573953', '56636653837488129');
INSERT INTO `t_user_role` VALUES ('56659980958306305', null, null, '0', null, null, '496138616573953', '56659980517904384');
INSERT INTO `t_user_role` VALUES ('56660320579489793', null, null, '0', null, null, '496138616573953', '56660262198972416');
INSERT INTO `t_user_role` VALUES ('56660723303976960', null, null, '0', null, null, '496138616573953', '56660722494476288');
INSERT INTO `t_user_role` VALUES ('56661186489356288', null, null, '0', null, null, '496138616573953', '56661157917757440');
INSERT INTO `t_user_role` VALUES ('56661473023234048', null, null, '0', null, null, '496138616573953', '56661381977477120');
INSERT INTO `t_user_role` VALUES ('56661688652402689', null, null, '0', null, null, '496138616573953', '56661688086171648');
INSERT INTO `t_user_role` VALUES ('56662150545936385', null, null, '0', null, null, '496138616573953', '56662013635465216');
INSERT INTO `t_user_role` VALUES ('56662330548686849', null, null, '0', null, null, '496138616573953', '56662314463531008');
INSERT INTO `t_user_role` VALUES ('56662796732993536', null, null, '0', null, null, '496138616573953', '56662795734749184');
INSERT INTO `t_user_role` VALUES ('56663245204754433', null, null, '0', null, null, '496138616573953', '56663187927339008');
INSERT INTO `t_user_role` VALUES ('56663863185117184', null, null, '0', null, null, '496138616573953', '56663851369762816');

-- ----------------------------
-- Table structure for t_weibo
-- ----------------------------
DROP TABLE IF EXISTS `t_weibo`;
CREATE TABLE `t_weibo` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `is_related` bit(1) DEFAULT NULL,
  `open_id` varchar(255) DEFAULT NULL,
  `relate_username` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_weibo
-- ----------------------------
