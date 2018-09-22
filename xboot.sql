/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50527
Source Host           : localhost:3306
Source Database       : xboot

Target Server Type    : MYSQL
Target Server Version : 50527
File Encoding         : 65001

Date: 2018-09-22 19:03:01
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
INSERT INTO `qrtz_triggers` VALUES ('quartzScheduler', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'DEFAULT', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'DEFAULT', null, '1534081989000', '1534081988000', '5', 'PAUSED', 'CRON', '1534081976000', '0', null, '0', '');

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
INSERT INTO `t_permission` VALUES ('5129710648430592', '', '2018-06-04 19:02:29', '0', '', '2018-08-09 15:25:01', '', 'sys', '', '0', '1.00', 'Main', '/form', '系统管理', 'ios-settings', '1', '', '0', null);
INSERT INTO `t_permission` VALUES ('5129710648430593', '', '2018-06-04 19:02:32', '0', '', '2018-08-13 15:15:33', '', 'user-manage', '5129710648430592', '0', '1.10', 'sys/user-manage/userManage', 'user-manage', '用户管理', 'md-person', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('5129710648430594', '', '2018-06-04 19:02:35', '0', '', '2018-08-23 17:31:27', '', 'role-manage', '5129710648430592', '0', '1.50', 'sys/role-manage/roleManage', 'role-manage', '角色管理', 'md-contacts', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('5129710648430595', '', '2018-06-04 19:02:37', '0', '', '2018-08-23 17:31:33', '', 'menu-manage', '5129710648430592', '0', '1.60', 'sys/menu-manage/menuManage', 'menu-manage', '菜单权限管理', 'md-menu', '2', '', '0', '');
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
INSERT INTO `t_permission` VALUES ('25014528525733888', '', '2018-06-29 14:51:09', '0', '', '2018-09-19 22:16:59', '', '', '5129710648430593', '1', '1.16', '', 'upload*', '上传图片', '', '3', 'upload', '0', '');
INSERT INTO `t_permission` VALUES ('39915540965232640', null, '2018-08-09 17:42:28', '0', null, '2018-08-09 17:42:28', null, 'monitor', null, '0', '2.00', 'Main', '/monitor', '系统监控', 'ios-analytics', '1', null, '0', null);
INSERT INTO `t_permission` VALUES ('39916171171991552', '', '2018-08-09 17:44:57', '0', '', '2018-08-25 12:13:11', '', 'druid', '39915540965232640', '0', '2.40', 'sys/monitor/monitor', 'druid', 'SQL监控', 'md-analytics', '2', '', '0', 'http://xboot.exrick.cn/druid/login.html');
INSERT INTO `t_permission` VALUES ('39918482854252544', '', '2018-08-09 17:54:08', '0', '', '2018-08-25 12:13:27', '', 'swagger', '39915540965232640', '0', '2.50', 'sys/monitor/monitor', 'swagger', '接口文档', 'md-document', '2', '', '0', 'http://xboot.exrick.cn/swagger-ui.html');
INSERT INTO `t_permission` VALUES ('40238597734928384', null, '2018-08-10 15:06:10', '0', null, '2018-08-10 15:06:10', null, 'department-manage', '5129710648430592', '0', '1.20', 'sys/department-manage/departmentManage', 'department-manage', '部门管理', 'md-git-branch', '2', '', '0', null);
INSERT INTO `t_permission` VALUES ('42082442672082944', '', '2018-08-15 17:12:57', '0', '', '2018-08-15 17:13:12', '', 'new-window', '41373430515240960', '0', '4.50', 'xboot-vue-template/new-window/newWindow', 'new-window', '新窗口操作[付费]', 'ios-browsers', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41373430515240960', '', '2018-08-13 18:15:35', '0', '', '2018-08-15 14:29:48', '', 'xboot-vue-template', '', '0', '3.00', 'Main', '/xboot-vue-template', '前端Vue模版', 'ios-albums', '1', '', '0', '');
INSERT INTO `t_permission` VALUES ('41363147411427328', '', '2018-08-13 17:34:43', '0', '', '2018-08-20 20:05:21', '', 'log-manage', '39915540965232640', '0', '2.20', 'sys/log-manage/logManage', 'log-manage', '操作日志管理', 'md-list-box', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41363537456533504', '', '2018-08-13 17:36:16', '0', '', '2018-08-13 17:56:11', '', '', '41363147411427328', '1', '2.11', '', '/xboot/log/delByIds/**', '删除日志', '', '3', 'delete', '0', '');
INSERT INTO `t_permission` VALUES ('41364927394353152', '', '2018-08-13 17:41:48', '0', '', '2018-09-19 22:08:57', '', '', '41363147411427328', '1', '2.12', '', '/xboot/log/delAll*', '清空日志', '', '3', 'undefined', '0', '');
INSERT INTO `t_permission` VALUES ('41376192166629376', '', '2018-08-13 18:26:33', '0', '', '2018-08-15 17:13:34', '', 'search-table', '41373430515240960', '0', '4.20', 'xboot-vue-template/search-table/searchTable', 'search-table', '搜索表格[付费]', 'md-grid', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41377034236071936', '', '2018-08-13 18:29:54', '0', '', '2018-08-15 17:13:40', '', 'complex-table', '41373430515240960', '0', '4.30', 'xboot-vue-template/complex-table/complexTable', 'complex-table', '复杂表格[付费]', 'ios-grid', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41378916912336896', '', '2018-08-13 18:37:23', '0', '', '2018-08-13 22:20:19', '', 'tree', '41373430515240960', '0', '4.40', 'xboot-vue-template/tree/tree', 'tree', '树形结构[付费]', 'ios-git-network', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('41469219249852416', null, '2018-08-14 00:36:13', '0', null, '2018-08-14 00:36:13', null, '', '41371711400054784', '1', '2.31', '', '无', '查看数据', '', '3', 'view', '0', null);
INSERT INTO `t_permission` VALUES ('42087054753927168', '', '2018-08-15 17:31:16', '0', '', '2018-08-15 17:31:27', '', 'html-edit', '41373430515240960', '0', '4.60', 'xboot-vue-template/html-edit/htmlEdit', 'html-edit', '富文本编辑[付费]', 'ios-create', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('43117268627886080', '', '2018-08-18 13:44:58', '0', '', '2018-08-18 20:55:04', '', 'message-manage', '5129710648430592', '0', '1.30', 'sys/message-manage/messageManage', 'message-manage', '消息管理[付费]', 'md-mail', '2', '', '0', '');
INSERT INTO `t_permission` VALUES ('44986029924421632', '', '2018-08-23 17:30:46', '0', '', '2018-08-23 17:31:02', '', 'social-manage', '5129710648430592', '0', '1.40', 'sys/social-manage/socialManage', 'social-manage', '社交账号绑定[付费]', 'md-share', '2', '', '0', '');
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
INSERT INTO `t_quartz_job` VALUES ('41065738420621312', '', '2018-08-12 21:52:56', '0', '', '2018-08-12 21:53:08', '0/1 * * * * ? ', '带参测试 后台将每隔1秒执行输出日志', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'World', '-1');
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
INSERT INTO `t_role_permission` VALUES ('45331074925989889', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '42087054753927168', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074921795584', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '42082442672082944', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074917601280', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41378916912336896', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074913406976', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41377034236071936', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074905018368', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41376192166629376', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074900824064', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41375330996326400', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074892435456', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41373430515240960', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074888241152', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '39918482854252544', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074879852544', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '39916171171991552', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074875658240', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41469219249852416', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074867269632', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41371711400054784', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074858881025', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41364927394353152', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074854686720', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41363537456533504', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074850492416', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41363147411427328', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074842103808', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45266070000373760', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074837909504', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45265886315024384', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('44986333730443264', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '16438800255291392', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333738831872', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '16438962738434048', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333747220480', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '16439068543946752', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('45331074833715200', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45265762415284224', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074825326592', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45265487029866496', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074816937984', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45264987354042368', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074808549376', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '41370251991977984', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074804355072', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '39915540965232640', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074795966465', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16695243126607872', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074791772160', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16695107491205120', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074787577856', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16694861252005888', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074783383552', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '5129710648430595', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074774994944', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16690313745666048', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074770800640', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16689883993083904', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074762412032', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16689745006432256', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073642532865', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16689632049631232', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('44986333717860352', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '16392767785668608', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333701083136', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '16392452747300864', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333692694528', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '42087054753927168', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333684305920', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '42082442672082944', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333675917312', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '41378916912336896', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333671723008', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '41377034236071936', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333659140096', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '41376192166629376', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333650751488', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '41375330996326400', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333629779968', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '41373430515240960', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333625585664', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '39918482854252544', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333617197056', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '39916171171991552', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333608808448', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '41371711400054784', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333604614144', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '41363147411427328', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('45331073638338560', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16687383932047360', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('44986333592031232', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '41370251991977984', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333583642624', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '39915540965232640', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333550088192', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '5129710648430595', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('45331073629949952', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '5129710648430594', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073621561344', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45069342940860416', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073613172737', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45235228800716800', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073608978432', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '44986029924421632', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073604784128', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45237170029465600', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073596395521', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45237010692050944', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073592201216', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45236734832676864', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073588006912', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '43117268627886080', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073583812608', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45235939278065664', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('44986333541699584', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '5129710648430594', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333533310976', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '44986029924421632', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333524922368', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '43117268627886080', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333508145152', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '40238597734928384', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333482979328', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '5129710648430593', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('44986333470396416', null, '2018-08-23 17:31:58', '0', null, '2018-08-23 17:31:58', '5129710648430592', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('45331073575424000', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45235787867885568', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073567035392', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '45235621697949696', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073558646784', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '40238597734928384', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073550258176', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '25014528525733888', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073546063872', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16678447719911424', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073537675265', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '15708892205944832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073533480960', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '15701915807518720', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073529286656', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16678126574637056', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073525092352', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '15701400130424832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073516703744', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '5129710648430593', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331073214713856', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '5129710648430592', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074934378496', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16392452747300864', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074938572800', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16392767785668608', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074942767104', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16438800255291392', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074951155712', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16438962738434048', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('45331074959544320', null, '2018-08-24 16:21:51', '0', null, '2018-08-24 16:21:51', '16439068543946752', '496138616573952');

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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('682265633886209', '', '2018-04-30 23:28:42', '', '2018-08-11 22:59:27', '', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012@qq.com', '18782059033', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '1', '-1', '0', 'Exrick', '0', '40322777781112832');
INSERT INTO `t_user` VALUES ('16739222421508096', '', '2018-06-06 18:48:02', '', '2018-08-11 20:17:04', '', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012139570@qq.com', '18782059038', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '1', '0', '0', 'test2', '0', '40652338142121984');
INSERT INTO `t_user` VALUES ('4363087427670016', '', '2018-05-03 15:09:42', '', '2018-08-11 20:17:11', '[\"510000\",\"510100\",\"510114\"]', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012139570@qq.com', '18782059038', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '1', '0', '0', 'test', '0', '40652338142121984');
INSERT INTO `t_user` VALUES ('682265633886208', '', '2018-05-01 16:13:51', '', '2018-08-11 20:16:58', '[\"510000\",\"510100\",\"510104\"]', 'http://p77xsahe9.bkt.clouddn.com/788eb3e78206429eb34fc7cd3e1e46f4.jpg', '', '1012139570@qq.com', '18782059038', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '1', '0', '1', 'admin', '0', '40322777781112832');

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
INSERT INTO `t_user_role` VALUES ('16056421829316608', null, '2018-06-04 21:34:50', '0', null, '2018-06-04 21:34:50', '496138616573953', '6118792149078016');
INSERT INTO `t_user_role` VALUES ('40720091502874624', null, '2018-08-11 22:59:27', '0', null, '2018-08-11 22:59:27', '496138616573952', '682265633886209');
INSERT INTO `t_user_role` VALUES ('40679225224597504', null, '2018-08-11 20:17:04', '0', null, '2018-08-11 20:17:04', '16457350655250432', '16739222421508096');
INSERT INTO `t_user_role` VALUES ('40679199995858945', null, '2018-08-11 20:16:58', '0', null, '2018-08-11 20:16:58', '496138616573952', '682265633886208');
INSERT INTO `t_user_role` VALUES ('40679257113890816', null, '2018-08-11 20:17:11', '0', null, '2018-08-11 20:17:11', '496138616573953', '4363087427670016');
INSERT INTO `t_user_role` VALUES ('40720091490291713', null, '2018-08-11 22:59:27', '0', null, '2018-08-11 22:59:27', '496138616573953', '682265633886209');

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
