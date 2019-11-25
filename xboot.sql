/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : xboot-opensource

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 29/04/2019 09:57:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_department
-- ----------------------------
BEGIN;
INSERT INTO `t_department` VALUES ('40322777781112832', '', '2018-08-10 20:40:40', 0, '', '2018-08-11 00:03:06', '0', 1.00, 0, '总部', b'1');
INSERT INTO `t_department` VALUES ('40322811096469504', '', '2018-08-10 20:40:48', 0, '', '2019-03-14 18:50:44', '40322777781112832', 1.00, 0, '技术部', b'1');
INSERT INTO `t_department` VALUES ('40322852833988608', '', '2018-08-10 20:40:58', 0, '', '2018-08-11 01:29:42', '40322811096469504', 1.00, 0, '研发中心', NULL);
INSERT INTO `t_department` VALUES ('40327204755738624', '', '2018-08-10 20:58:15', 0, '', '2018-08-10 22:02:15', '40322811096469504', 2.00, 0, '大数据', NULL);
INSERT INTO `t_department` VALUES ('40327253309001728', '', '2018-08-10 20:58:27', 0, '', '2018-08-11 17:26:38', '40322811096469504', 3.00, -1, '人工智障', NULL);
INSERT INTO `t_department` VALUES ('40343262766043136', '', '2018-08-10 22:02:04', 0, '', '2018-08-11 00:02:53', '0', 2.00, 0, '成都分部', b'1');
INSERT INTO `t_department` VALUES ('40344005342400512', '', '2018-08-10 22:05:01', 0, '', '2018-08-11 17:48:44', '40343262766043136', 2.00, 0, 'Vue', NULL);
INSERT INTO `t_department` VALUES ('40389030113710080', '', '2018-08-11 01:03:56', 0, '', '2018-08-11 17:50:04', '40343262766043136', 1.00, 0, 'JAVA', b'0');
INSERT INTO `t_department` VALUES ('40652270295060480', '', '2018-08-11 18:29:57', 0, '', '2018-08-12 18:45:01', '0', 3.00, 0, '人事部', b'1');
INSERT INTO `t_department` VALUES ('40652338142121984', NULL, '2018-08-11 18:30:13', 0, NULL, '2018-08-11 18:30:13', '40652270295060480', 1.00, 0, '游客', b'0');
INSERT INTO `t_department` VALUES ('40681289119961088', '', '2018-08-11 20:25:16', 0, '', '2018-08-11 22:47:48', '40652270295060480', 2.00, 0, 'VIP', b'0');
COMMIT;

-- ----------------------------
-- Table structure for t_department_header
-- ----------------------------
DROP TABLE IF EXISTS `t_department_header`;
CREATE TABLE `t_department_header` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_department_header
-- ----------------------------
BEGIN;
INSERT INTO `t_department_header` VALUES ('118575966346809344', NULL, '2019-03-14 19:10:54', 0, NULL, '2019-03-14 19:10:54', '40322777781112832', 0, '682265633886209');
COMMIT;

-- ----------------------------
-- Table structure for t_dict
-- ----------------------------
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE `t_dict` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dict
-- ----------------------------
BEGIN;
INSERT INTO `t_dict` VALUES ('75135930788220928', 'admin', '2018-11-14 22:15:43', 0, 'admin', '2018-11-27 01:39:06', '', '性别', 'sex', 0.00);
INSERT INTO `t_dict` VALUES ('75388696739713024', 'admin', '2018-11-15 15:00:07', 0, 'admin', '2018-11-27 01:39:22', '', '按钮权限类型', 'permission_type', 3.00);
COMMIT;

-- ----------------------------
-- Table structure for t_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_data`;
CREATE TABLE `t_dict_data` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dict_id` varchar(255) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `t_dict_data` VALUES ('75158227712479232', 'admin', '2018-11-14 23:44:19', 0, 'admin', '2019-04-28 22:15:11', '', '75135930788220928', 0.00, 0, '男', '男');
INSERT INTO `t_dict_data` VALUES ('75159254272577536', 'admin', '2018-11-14 23:48:24', 0, 'admin', '2019-04-28 22:15:17', '', '75135930788220928', 1.00, 0, '女', '女');
INSERT INTO `t_dict_data` VALUES ('75159898425397248', 'admin', '2018-11-14 23:50:57', 0, 'admin', '2019-04-28 22:15:22', '', '75135930788220928', 2.00, -1, '保密', '保密');
INSERT INTO `t_dict_data` VALUES ('75390787835138048', 'admin', '2018-11-15 15:08:26', 0, 'admin', '2018-11-15 15:08:26', '', '75388696739713024', 0.00, 0, '查看操作(view)', 'view');
INSERT INTO `t_dict_data` VALUES ('75390886501945344', 'admin', '2018-11-15 15:08:49', 0, 'admin', '2018-11-15 15:08:57', '', '75388696739713024', 1.00, 0, '添加操作(add)', 'add');
INSERT INTO `t_dict_data` VALUES ('75390993939042304', 'admin', '2018-11-15 15:09:15', 0, 'admin', '2018-11-15 15:09:15', '', '75388696739713024', 2.00, 0, '编辑操作(edit)', 'edit');
INSERT INTO `t_dict_data` VALUES ('75391067532300288', 'admin', '2018-11-15 15:09:32', 0, 'admin', '2018-11-15 15:09:32', '', '75388696739713024', 3.00, 0, '删除操作(delete)', 'delete');
INSERT INTO `t_dict_data` VALUES ('75391126902673408', 'admin', '2018-11-15 15:09:46', 0, 'admin', '2018-11-15 15:09:46', '', '75388696739713024', 4.00, 0, '清空操作(clear)', 'clear');
INSERT INTO `t_dict_data` VALUES ('75391192883269632', 'admin', '2018-11-15 15:10:02', 0, 'admin', '2018-11-15 15:10:02', '', '75388696739713024', 5.00, 0, '启用操作(enable)', 'enable');
INSERT INTO `t_dict_data` VALUES ('75391251024711680', 'admin', '2018-11-15 15:10:16', 0, 'admin', '2018-11-15 15:10:16', '', '75388696739713024', 6.00, 0, '禁用操作(disable)', 'disable');
INSERT INTO `t_dict_data` VALUES ('75391297124306944', 'admin', '2018-11-15 15:10:27', 0, 'admin', '2018-11-15 15:10:27', '', '75388696739713024', 7.00, 0, '搜索操作(search)', 'search');
INSERT INTO `t_dict_data` VALUES ('75391343379091456', 'admin', '2018-11-15 15:10:38', 0, 'admin', '2018-11-15 15:10:38', '', '75388696739713024', 8.00, 0, '上传文件(upload)', 'upload');
INSERT INTO `t_dict_data` VALUES ('75391407526776832', 'admin', '2018-11-15 15:10:53', 0, 'admin', '2018-11-15 15:10:53', '', '75388696739713024', 9.00, 0, '导出操作(output)', 'output');
INSERT INTO `t_dict_data` VALUES ('75391475042488320', 'admin', '2018-11-15 15:11:09', 0, 'admin', '2018-11-15 15:11:09', '', '75388696739713024', 10.00, 0, '导入操作(input)', 'input');
INSERT INTO `t_dict_data` VALUES ('75391522182270976', 'admin', '2018-11-15 15:11:21', 0, 'admin', '2018-11-15 15:11:21', '', '75388696739713024', 11.00, 0, '分配权限(editPerm)', 'editPerm');
INSERT INTO `t_dict_data` VALUES ('75391576364290048', 'admin', '2018-11-15 15:11:34', 0, 'admin', '2018-11-15 15:11:34', '', '75388696739713024', 12.00, 0, '设为默认(setDefault)', 'setDefault');
INSERT INTO `t_dict_data` VALUES ('75391798033256448', 'admin', '2018-11-15 15:12:26', 0, 'admin', '2018-11-15 15:12:26', '', '75388696739713024', 13.00, 0, '其他操作(other)', 'other');
COMMIT;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `log_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_quartz_job
-- ----------------------------
BEGIN;
INSERT INTO `t_quartz_job` VALUES ('41060689401352192', '', '2018-08-12 20:32:52', 0, 'admin', '2018-11-20 09:51:38', '0/1 * * * * ? ', '无参测试 后台将每隔1秒执行输出日志', 'cn.exrick.xboot.quartz.jobs.SampleJob', '', -1);
INSERT INTO `t_quartz_job` VALUES ('41065738420621312', '', '2018-08-12 21:52:56', 0, '', '2018-09-23 23:19:39', '0/1 * * * * ? ', '带参测试 后台将每隔1秒执行输出日志', 'cn.exrick.xboot.quartz.jobs.SampleParamJob', 'World', -1);
COMMIT;

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
  `data_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
BEGIN;
INSERT INTO `t_role` VALUES ('16457350655250432', '', '2018-06-06 00:08:00', 'admin', '2018-11-02 20:42:24', 'ROLE_TEST', 0, NULL, '测试权限按钮显示', 1);
INSERT INTO `t_role` VALUES ('496138616573952', '', '2018-04-22 23:03:49', 'admin', '2018-11-15 23:02:59', 'ROLE_ADMIN', 0, NULL, '超级管理员 拥有所有权限', 0);
INSERT INTO `t_role` VALUES ('496138616573953', '', '2018-05-02 21:40:03', 'admin', '2018-11-01 22:59:48', 'ROLE_USER', 0, b'1', '普通注册用户 路过看看', 0);
COMMIT;

-- ----------------------------
-- Table structure for t_role_department
-- ----------------------------
DROP TABLE IF EXISTS `t_role_department`;
CREATE TABLE `t_role_department` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_department
-- ----------------------------
BEGIN;
INSERT INTO `t_role_department` VALUES ('70763874256687105', 'admin', '2018-11-02 20:42:43', 0, 'admin', '2018-11-02 20:42:43', '40322777781112832', '16457350655250432');
INSERT INTO `t_role_department` VALUES ('70763874265075712', 'admin', '2018-11-02 20:42:43', 0, 'admin', '2018-11-02 20:42:43', '40322811096469504', '16457350655250432');
INSERT INTO `t_role_department` VALUES ('70763874277658624', 'admin', '2018-11-02 20:42:43', 0, 'admin', '2018-11-02 20:42:43', '40322852833988608', '16457350655250432');
COMMIT;

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
  `show_always` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
BEGIN;
INSERT INTO `t_permission` VALUES ('5129710648430592', '', '2018-06-04 19:02:29', 0, '', '2018-09-29 23:11:56', '', 'sys', '125909152017944576', 0, 1.00, 'Main', '/sys', '系统管理', 'ios-settings', 1, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('5129710648430593', '', '2018-06-04 19:02:32', 0, '', '2018-08-13 15:15:33', '', 'user-manage', '5129710648430592', 0, 1.10, 'sys/user-manage/userManage', 'user-manage', '用户管理', 'md-person', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('5129710648430594', '', '2018-06-04 19:02:35', 0, '', '2018-10-13 13:51:36', '', 'role-manage', '5129710648430592', 0, 1.60, 'sys/role-manage/roleManage', 'role-manage', '角色权限管理', 'md-contacts', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('5129710648430595', '', '2018-06-04 19:02:37', 0, '', '2018-09-23 23:32:02', '', 'menu-manage', '5129710648430592', 0, 1.70, 'sys/menu-manage/menuManage', 'menu-manage', '菜单权限管理', 'md-menu', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41375330996326400', '', '2018-08-13 18:23:08', 0, 'admin', '2019-02-05 16:27:32', '', 'simple-table', '41373430515240960', 0, 3.20, 'xboot-vue-template/simple-table/simpleTable', 'simple-table', '简单表格', 'ios-grid-outline', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('15701400130424832', '', '2018-06-03 22:04:06', 0, '', '2018-09-19 22:16:44', '', '', '5129710648430593', 1, 1.11, '', '/xboot/user/admin/add*', '添加用户', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('15701915807518720', '', '2018-06-03 22:06:09', 0, '', '2018-06-06 14:46:51', '', '', '5129710648430593', 1, 1.13, '', '/xboot/user/admin/disable/**', '禁用用户', '', 3, 'disable', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('15708892205944832', '', '2018-06-03 22:33:52', 0, '', '2018-06-28 16:44:48', '', '', '5129710648430593', 1, 1.14, '', '/xboot/user/admin/enable/**', '启用用户', '', 3, 'enable', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('16392452747300864', '', '2018-06-05 19:50:06', 0, 'admin', '2019-07-08 16:36:35', '', 'access', '125909152017944576', 0, 9.00, 'Main', '/access', '权限按钮测试页', 'md-lock', 1, '', 0, '', b'0');
INSERT INTO `t_permission` VALUES ('16392767785668608', '', '2018-06-05 19:51:21', 0, 'admin', '2018-10-23 12:34:38', '', 'access_index', '16392452747300864', 0, 5.10, 'access/access', 'index', '权限按钮测试页', 'md-lock', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16438800255291392', '', '2018-06-05 22:54:18', 0, 'admin', '2018-10-23 12:34:51', '', '', '16392767785668608', 1, 5.11, '', 'test-add', '添加按钮测试', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16438962738434048', '', '2018-06-05 22:54:55', 0, 'admin', '2018-10-23 12:35:05', '', '', '16392767785668608', 1, 5.12, '', 'test-edit', '编辑按钮测试', '', 3, 'edit', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16439068543946752', '', '2018-06-05 22:55:20', 0, 'admin', '2018-10-23 12:34:54', '', '', '16392767785668608', 1, 5.13, '', 'test-delete', '删除按钮测试', '', 3, 'delete', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16678126574637056', '', '2018-06-06 14:45:16', 0, '', '2018-09-19 22:16:48', '', '', '5129710648430593', 1, 1.12, '', '/xboot/user/admin/edit*', '编辑用户', '', 3, 'edit', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16678447719911424', '', '2018-06-06 14:46:32', 0, '', '2018-08-10 21:41:16', '', '', '5129710648430593', 1, 1.15, '', '/xboot/user/delByIds/**', '删除用户', '', 3, 'delete', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16687383932047360', '', '2018-06-06 15:22:03', 0, '', '2018-09-19 22:07:34', '', '', '5129710648430594', 1, 1.21, '', '/xboot/role/save*', '添加角色', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16689632049631232', '', '2018-06-06 15:30:59', 0, '', '2018-09-19 22:07:37', '', '', '5129710648430594', 1, 1.22, '', '/xboot/role/edit*', '编辑角色', '', 3, 'edit', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16689745006432256', '', '2018-06-06 15:31:26', 0, '', '2018-08-10 21:41:23', '', '', '5129710648430594', 1, 1.23, '', '/xboot/role/delAllByIds/**', '删除角色', '', 3, 'delete', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16689883993083904', '', '2018-06-06 15:31:59', 0, 'admin', '2018-12-09 16:01:14', '', '', '5129710648430594', 1, 1.24, '', '/xboot/role/editRolePerm**', '分配权限', '', 3, 'editPerm', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16690313745666048', '', '2018-06-06 15:33:41', 0, 'admin', '2018-12-09 16:02:45', '', '', '5129710648430594', 1, 1.26, '', '/xboot/role/setDefault*', '设为默认角色', '', 3, 'setDefault', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16694861252005888', '', '2018-06-06 15:51:46', 0, '', '2018-09-19 22:07:52', '', '', '5129710648430595', 1, 1.31, '', '/xboot/permission/add*', '添加菜单', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16695107491205120', '', '2018-06-06 15:52:44', 0, '', '2018-09-19 22:07:57', '', '', '5129710648430595', 1, 1.32, '', '/xboot/permission/edit*', '编辑菜单', '', 3, 'edit', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('16695243126607872', '', '2018-06-06 15:53:17', 0, '', '2018-08-10 21:41:33', '', '', '5129710648430595', 1, 1.33, '', '/xboot/permission/delByIds/**', '删除菜单', '', 3, 'delete', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41371711400054784', '', '2018-08-13 18:08:45', 0, 'admin', '2019-07-08 16:37:25', '', 'actuator', '39915540965232640', 0, 2.30, 'sys/actuator/actuator', 'actuator', 'Actuator监控', 'logo-angular', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41370251991977984', NULL, '2018-08-13 18:02:57', 0, NULL, '2018-08-13 18:02:57', NULL, 'quartz-job', '39915540965232640', 0, 2.10, 'sys/quartz-manage/quartzManage', 'quartz-job', '定时任务', 'md-time', 2, '', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('25014528525733888', '', '2018-06-29 14:51:09', 0, '', '2018-10-08 11:13:27', '', '', '5129710648430593', 1, 1.16, '', '无', '上传图片', '', 3, 'upload', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('39915540965232640', '', '2018-08-09 17:42:28', 0, 'admin', '2019-03-01 17:58:00', '', 'monitor', '125909152017944576', 0, 3.00, 'Main', '/monitor', '系统监控', 'ios-analytics', 1, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('39916171171991552', '', '2018-08-09 17:44:57', 0, '', '2018-08-25 12:13:11', '', 'druid', '39915540965232640', 0, 2.40, 'sys/monitor/monitor', 'druid', 'SQL监控', 'md-analytics', 2, '', 0, 'http://xboot.exrick.cn/druid/login.html', NULL);
INSERT INTO `t_permission` VALUES ('39918482854252544', '', '2018-08-09 17:54:08', 0, '', '2018-08-25 12:13:27', '', 'swagger', '39915540965232640', 0, 2.50, 'sys/monitor/monitor', 'swagger', '接口文档', 'md-document', 2, '', 0, 'http://xboot.exrick.cn/swagger-ui.html', NULL);
INSERT INTO `t_permission` VALUES ('40238597734928384', NULL, '2018-08-10 15:06:10', 0, NULL, '2018-08-10 15:06:10', NULL, 'department-manage', '5129710648430592', 0, 1.20, 'sys/department-manage/departmentManage', 'department-manage', '部门管理', 'md-git-branch', 2, '', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('42082442672082944', '', '2018-08-15 17:12:57', 0, 'admin', '2019-02-05 16:27:25', '', 'new-window', '41373430515240960', 0, 3.10, 'xboot-vue-template/new-window/newWindow', 'new-window', '新窗口操作', 'ios-browsers', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41373430515240960', '', '2018-08-13 18:15:35', 0, 'admin', '2019-03-01 17:59:06', '', 'vue-template', '125909152017944576', 0, 5.00, 'Main', '/vue-template', '后台Vue模版', 'ios-albums', 1, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41363147411427328', '', '2018-08-13 17:34:43', 0, '', '2018-08-20 20:05:21', '', 'log-manage', '39915540965232640', 0, 2.20, 'sys/log-manage/logManage', 'log-manage', '操作日志管理', 'md-list-box', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41363537456533504', '', '2018-08-13 17:36:16', 0, '', '2018-08-13 17:56:11', '', '', '41363147411427328', 1, 2.11, '', '/xboot/log/delByIds/**', '删除日志', '', 3, 'delete', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41364927394353152', '', '2018-08-13 17:41:48', 0, '', '2018-09-19 22:08:57', '', '', '41363147411427328', 1, 2.12, '', '/xboot/log/delAll*', '清空日志', '', 3, 'undefined', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41376192166629376', '', '2018-08-13 18:26:33', 0, 'admin', '2018-10-20 22:47:26', '', 'search-table', '41373430515240960', 0, 3.40, 'xboot-vue-template/search-table/searchTable', 'search-table', '搜索表格[付费]', 'md-grid', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41377034236071936', '', '2018-08-13 18:29:54', 0, 'admin', '2018-10-20 22:47:33', '', 'complex-table', '41373430515240960', 0, 3.50, 'xboot-vue-template/complex-table/complexTable', 'complex-table', '复杂表格[付费]', 'ios-grid', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41378916912336896', '', '2018-08-13 18:37:23', 0, 'admin', '2019-02-05 16:26:59', '', 'tree', '41373430515240960', 0, 3.21, 'xboot-vue-template/tree/tree', 'tree', '树形结构', 'ios-git-network', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('41469219249852416', NULL, '2018-08-14 00:36:13', 0, NULL, '2018-08-14 00:36:13', NULL, '', '41371711400054784', 1, 2.31, '', '无', '查看数据', '', 3, 'view', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('43117268627886080', '', '2018-08-18 13:44:58', 0, '', '2018-08-18 20:55:04', '', 'message-manage', '5129710648430592', 0, 1.30, 'sys/message-manage/messageManage', 'message-manage', '消息管理[付费]', 'md-mail', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('44986029924421632', '', '2018-08-23 17:30:46', 0, '', '2018-09-23 23:26:53', '', 'social-manage', '5129710648430592', 0, 1.50, 'sys/social-manage/socialManage', 'social-manage', '社交账号绑定[付费]', 'md-share', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45069342940860416', '', '2018-08-23 23:01:49', 0, '', '2018-08-24 10:01:09', '', '', '44986029924421632', 1, 1.42, '', '无', '查看社交账号数据', '', 3, 'view', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45235228800716800', '', '2018-08-24 10:01:00', 0, '', '2018-09-19 22:07:23', '', '', '44986029924421632', 1, 1.41, '', '/xboot/relate/delByIds*', '删除解绑', '', 3, 'delete', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45235621697949696', '', '2018-08-24 10:02:33', 0, '', '2018-09-19 22:06:57', '', '', '40238597734928384', 1, 1.21, '', '/xboot/department/add*', '添加部门', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45235787867885568', '', '2018-08-24 10:03:13', 0, '', '2018-09-19 22:07:02', '', '', '40238597734928384', 1, 1.22, '', '/xboot/department/edit*', '编辑部门', '', 3, 'edit', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45235939278065664', NULL, '2018-08-24 10:03:49', 0, NULL, '2018-08-24 10:03:49', NULL, '', '40238597734928384', 1, 1.23, '', '/xboot/department/delByIds/*', '删除部门', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('45236734832676864', '', '2018-08-24 10:06:59', 0, '', '2018-09-19 22:07:07', '', '', '43117268627886080', 1, 1.31, '', '/xboot/message/add*', '添加消息', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45237010692050944', '', '2018-08-24 10:08:04', 0, '', '2018-09-19 22:07:12', '', '', '43117268627886080', 1, 1.32, '', '/xboot/message/edit*', '编辑消息', '', 3, 'edit', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45237170029465600', NULL, '2018-08-24 10:08:42', 0, NULL, '2018-08-24 10:08:42', NULL, '', '43117268627886080', 1, 1.33, '', '/xboot/message/delByIds/*', '删除消息', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('45264987354042368', '', '2018-08-24 11:59:14', 0, '', '2018-09-19 22:08:11', '', '', '41370251991977984', 1, 2.11, '', '/xboot/quartzJob/add*', '添加定时任务', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45265487029866496', '', '2018-08-24 12:01:14', 0, '', '2018-09-19 22:08:17', '', '', '41370251991977984', 1, 2.12, '', '/xboot/quartzJob/edit*', '编辑定时任务', '', 3, 'edit', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45265762415284224', '', '2018-08-24 12:02:19', 0, '', '2018-09-19 22:08:24', '', '', '41370251991977984', 1, 2.13, '', '/xboot/quartzJob/pause*', '暂停定时任务', '', 3, 'disable', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45265886315024384', '', '2018-08-24 12:02:49', 0, '', '2018-09-19 22:09:13', '', '', '41370251991977984', 1, 2.14, '', '/xboot/quartzJob/resume*', '恢复定时任务', '', 3, 'enable', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('45266070000373760', NULL, '2018-08-24 12:03:33', 0, NULL, '2018-08-24 12:03:33', NULL, '', '41370251991977984', 1, 2.15, '', '/xboot/quartzJob/delByIds/*', '删除定时任务', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('56309618086776832', '', '2018-09-23 23:26:40', 0, 'admin', '2018-11-15 15:17:43', '', 'oss-manage', '5129710648430592', 0, 1.40, 'sys/oss-manage/ossManage', 'oss-manage', '文件对象存储[付费]', 'ios-folder', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('56898976661639168', '', '2018-09-25 14:28:34', 0, '', '2018-09-25 15:12:46', '', '', '5129710648430593', 1, 1.17, '', '/xboot/user/importData*', '导入用户', '', 3, 'input', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('56911328312299520', '', '2018-09-25 15:17:39', 0, 'admin', '2018-10-20 22:47:36', '', 'excel', '41373430515240960', 0, 3.60, 'xboot-vue-template/excel/excel', 'excel', 'Excel导入导出[付费]', 'md-exit', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('57009544286441472', NULL, '2018-09-25 21:47:55', 0, NULL, '2018-09-25 21:47:55', NULL, '', '43117268627886080', 1, 1.40, '', '/xboot/messageSend/save*', '添加已发送消息', '', 3, 'add', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('57009744761589760', NULL, '2018-09-25 21:48:43', 0, NULL, '2018-09-25 21:48:43', NULL, '', '43117268627886080', 1, 1.50, '', '/xboot/messageSend/update*', '编辑已发送消息', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('57009981228060672', NULL, '2018-09-25 21:49:39', 0, NULL, '2018-09-25 21:49:39', NULL, '', '43117268627886080', 1, 1.60, '', '/xboot/messageSend/delByIds/*', '删除已发送消息', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('57212882168844288', '', '2018-09-26 11:15:55', 0, '', '2018-10-08 11:10:05', '', '', '56309618086776832', 1, 1.41, '', '无', '上传文件', '', 3, 'upload', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('58480609315524608', '', '2018-09-29 23:13:24', 0, 'admin', '2018-11-14 13:24:26', '', 'setting', '5129710648430592', 0, 1.90, 'sys/setting-manage/settingManage', 'setting', '系统配置[付费]', 'ios-settings-outline', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('61394706252173312', NULL, '2018-10-08 00:12:59', 0, NULL, '2018-10-08 00:12:59', NULL, '', '58480609315524608', 1, 1.81, '', '/xboot/setting/seeSecret/**', '查看私密配置', '', 3, 'view', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('61417744146370560', '', '2018-10-08 01:44:32', 0, '', '2018-10-08 01:50:03', '', '', '58480609315524608', 1, 1.82, '', '/xboot/setting/*/set*', '编辑配置', '', 3, 'edit', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('61560480518377472', NULL, '2018-10-08 11:11:43', 0, NULL, '2018-10-08 11:11:43', NULL, '', '56309618086776832', 1, 1.44, '', '/xboot/file/delete/*', '删除文件', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('61560275261722624', NULL, '2018-10-08 11:10:54', 0, NULL, '2018-10-08 11:10:54', NULL, '', '56309618086776832', 1, 1.43, '', '/xboot/file/copy*', '复制文件', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('61560041605435392', NULL, '2018-10-08 11:09:58', 0, NULL, '2018-10-08 11:09:58', NULL, '', '56309618086776832', 1, 1.42, '', '/xboot/file/rename*', '重命名文件', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('63482475359244288', '', '2018-10-13 18:29:02', 0, 'admin', '2018-10-20 22:47:45', '', 'custom-tree', '41373430515240960', 0, 3.80, 'xboot-vue-template/custom-tree/customTree', 'custom-tree', '自定义树[付费]', 'md-git-network', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('63741744973352960', '', '2018-10-14 11:39:17', 0, 'admin', '2019-02-05 16:27:11', '', 'render', '41373430515240960', 0, 3.30, 'xboot-vue-template/render/render', 'render', 'Render函数示例[付费]', 'md-aperture', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('64290663792906240', '', '2018-10-16 00:00:29', 0, 'admin', '2018-10-20 22:47:49', '', 'tree&table', '41373430515240960', 0, 3.90, 'xboot-vue-template/tree&table/tree&table', 'tree&table', '树+表格[付费]', 'md-list', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('66790433014943744', 'admin', '2018-10-22 21:33:42', 0, 'admin', '2018-10-22 21:37:12', '', 'card-list', '41373430515240960', 0, 3.91, 'xboot-vue-template/card-list/cardList', 'card-list', '卡片列表[付费]', 'md-card', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('67027909637836800', 'admin', '2018-10-23 13:17:19', 0, 'admin', '2019-11-25 16:38:59', '', 'banner', '67027338952445952', 0, 4.10, 'xboot-product-template/banner/Banner', 'banner', '轮播组件[付费]', 'md-book', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('67027338952445952', 'admin', '2018-10-23 13:15:03', 0, 'admin', '2019-03-01 17:58:19', '', 'product-template', '125909152017944576', 0, 6.00, 'Main', '/product-template', '前台产品级组件', 'md-ribbon', 1, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('67042515441684480', 'admin', '2018-10-23 14:15:22', 0, 'admin', '2019-11-25 16:39:12', '', 'product', '67027338952445952', 0, 4.20, 'xboot-product-template/product/Product', 'product', '产品组件[付费]', 'md-pricetags', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('67082402312228864', 'admin', '2018-10-23 16:53:53', 0, 'admin', '2019-11-25 16:39:20', '', 'category', '67027338952445952', 0, 4.30, 'xboot-product-template/category/Category', 'category', '分类栏组件[付费]', 'md-apps', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('75002207560273920', 'admin', '2018-11-14 13:24:21', 0, 'admin', '2018-11-20 20:06:22', '', 'dict', '5129710648430592', 0, 1.80, 'sys/dict-manage/dictManage', 'dict', '数据字典管理', 'md-bookmarks', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('76606430504816640', 'admin', '2018-11-18 23:38:57', 0, 'admin', '2019-03-01 17:57:53', '', 'activiti', '125909152017944576', 0, 2.00, 'Main', '/activiti', '工作流程', 'md-git-compare', 1, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('76607201262702592', 'admin', '2018-11-18 23:42:01', 0, 'admin', '2018-11-20 19:41:58', '', 'model-manage', '76606430504816640', 0, 1.00, 'activiti/model-manage/modelManage', 'model-manage', '模型管理[付费]', 'md-cube', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('76914082455752704', 'admin', '2018-11-19 20:01:28', 0, 'admin', '2018-11-20 19:41:50', '', 'process-manage', '76606430504816640', 0, 0.90, 'activiti/process-manage/processManage', 'process-manage', '流程管理[付费]', 'md-calendar', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('76215889006956544', 'admin', '2018-11-17 21:47:05', 0, 'admin', '2018-11-17 21:47:53', '', '', '75002207560273920', 1, 1.81, '', '/xboot/dict/add*', '添加字典', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('76216071333351424', 'admin', '2018-11-17 21:47:48', 0, 'admin', '2018-11-17 21:47:48', NULL, '', '75002207560273920', 1, 1.82, '', '/xboot/dict/edit*', '编辑字典', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('76216264070008832', 'admin', '2018-11-17 21:48:34', 0, 'admin', '2018-11-17 21:48:34', NULL, '', '75002207560273920', 1, 1.83, '', '/xboot/dict/delByIds/**', '删除字典', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('76216459709124608', 'admin', '2018-11-17 21:49:21', 0, 'admin', '2018-11-17 21:49:21', NULL, '', '75002207560273920', 1, 1.84, '', '/xboot/dictData/add*', '添加字典数据', '', 3, 'add', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('76216594207870976', 'admin', '2018-11-17 21:49:53', 0, 'admin', '2018-11-17 21:49:53', NULL, '', '75002207560273920', 1, 1.85, '', '/xboot/dictData/edit*', '编辑字典数据', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('76216702639017984', 'admin', '2018-11-17 21:50:18', 0, 'admin', '2018-11-17 21:50:18', NULL, '', '75002207560273920', 1, 1.86, '', '/xboot/dictData/delByIds/**', '删除字典数据', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('80539147005071360', 'admin', '2018-11-29 20:06:10', 0, 'admin', '2018-12-04 14:14:41', '', 'category-manage', '76606430504816640', 0, 2.00, 'activiti/category-manage/categoryManage', 'category-manage', '流程分类管理[付费]', 'md-bookmark', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('81319435670917120', 'admin', '2018-12-01 23:46:45', 0, 'admin', '2018-12-02 15:37:03', '', 'process-ins-manage', '76606430504816640', 0, 0.70, 'activiti/process-ins-manage/processInsManage', 'process-ins-manage', '运行中的流程[付费]', 'md-fastforward', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('81558529864896512', 'admin', '2018-12-02 15:36:50', 0, 'admin', '2018-12-08 14:50:38', '', 'apply-manage', '76606430504816640', 0, 0.00, 'activiti/apply-manage/applyManage', 'apply-manage', '我的申请[付费]', 'md-clipboard', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('81716172680073216', 'admin', '2018-12-03 02:03:15', 0, 'admin', '2018-12-03 02:03:15', NULL, 'todo-manage', '76606430504816640', 0, 0.10, 'activiti/todo-manage/todoManage', 'todo-manage', '我的待办[付费]', 'ios-pricetag', 2, '', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('82269650301227008', 'admin', '2018-12-04 14:42:34', 0, 'admin', '2018-12-04 14:42:34', NULL, 'done-manage', '76606430504816640', 0, 0.20, 'activiti/done-manage/doneManage', 'done-manage', '我的已办[付费]', 'ios-pricetag-outline', 2, '', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('129837236362416128', 'admin', '2019-04-14 20:59:10', 0, 'admin', '2019-07-08 16:43:04', '', 'flutter', '127996320085446656', 0, 1.00, 'Main', '/flutter', 'XBoot Flutter App', 'md-phone-portrait', 1, '', 0, '', b'0');
INSERT INTO `t_permission` VALUES ('84082369492946944', 'admin', '2018-12-09 14:45:40', 0, 'admin', '2018-12-09 14:46:59', '', '', '81558529864896512', 1, 0.00, '', '/xboot/leave/add*', '添加请假申请', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('84082920431554560', 'admin', '2018-12-09 14:47:51', 0, 'admin', '2018-12-09 14:47:51', NULL, '', '81558529864896512', 1, 1.00, '', '/xboot/actBusiness/delByIds/**', '删除草稿申请', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84083562503999488', 'admin', '2018-12-09 14:50:25', 0, 'admin', '2018-12-09 14:50:25', NULL, '', '81716172680073216', 1, 0.00, '', '/xboot/actTask/pass**', '审批通过', '', 3, 'enable', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84083641302388736', 'admin', '2018-12-09 14:50:43', 0, 'admin', '2018-12-09 14:50:43', NULL, '', '81716172680073216', 1, 1.00, '', '/xboot/actTask/back**', '审批驳回', '', 3, 'disable', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84084404707659776', 'admin', '2018-12-09 14:53:45', 0, 'admin', '2018-12-09 14:53:45', NULL, '', '81716172680073216', 1, 3.00, '', '/xboot/actTask/delegate**', '委托代办', '', 3, 'other', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84084724590448640', 'admin', '2018-12-09 14:55:02', 0, 'admin', '2018-12-09 14:55:02', NULL, '', '82269650301227008', 1, 0.00, '', '/xboot/actTask/deleteHistoric/**', '删除已办任务', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84084965817454592', 'admin', '2018-12-09 14:55:59', 0, 'admin', '2018-12-09 14:55:59', NULL, '', '81319435670917120', 1, 0.00, '', '/xboot/actProcess/delInsByIds/**', '删除运行流程', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84085542324539392', 'admin', '2018-12-09 14:58:17', 0, 'admin', '2018-12-09 14:58:17', NULL, '', '76914082455752704', 1, 0.00, '', '/xboot/actProcess/updateInfo/**', '编辑流程信息', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84085810797744128', 'admin', '2018-12-09 14:59:21', 0, 'admin', '2018-12-09 14:59:21', NULL, '', '76914082455752704', 1, 1.00, '', '/xboot/actProcess/editNodeUser**', '流程节点设置', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84085980943880192', 'admin', '2018-12-09 15:00:01', 0, 'admin', '2018-12-09 15:00:01', NULL, '', '76914082455752704', 1, 2.00, '', '/xboot/actProcess/convertToModel/**', '流程转模型', '', 3, 'other', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84086163001839616', 'admin', '2018-12-09 15:00:45', 0, 'admin', '2018-12-09 15:01:37', '', '', '76914082455752704', 1, 3.00, '', '/xboot/actProcess/delByIds/**', '删除流程定义', '', 3, 'delete', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('84086362248056832', 'admin', '2018-12-09 15:01:32', 0, 'admin', '2018-12-09 15:01:32', NULL, '', '76914082455752704', 1, 4.00, '', '/xboot/actModel/deployByFile**', '文件部署流程', '', 3, 'other', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84086882907983872', 'admin', '2018-12-09 15:03:36', 0, 'admin', '2018-12-09 15:03:36', NULL, '', '76607201262702592', 1, 0.00, '', '/xboot/actModel/add**', '添加模型', '', 3, 'add', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84087009940869120', 'admin', '2018-12-09 15:04:06', 0, 'admin', '2018-12-09 15:04:06', NULL, '', '76607201262702592', 1, 1.00, '', '/xboot/actModel/delByIds/**', '删除模型', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84087154040377344', 'admin', '2018-12-09 15:04:41', 0, 'admin', '2018-12-09 15:04:41', NULL, '', '76607201262702592', 1, 2.00, '', '/xboot/actModel/deploy/**', '部署模型', '', 3, 'other', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84087344352727040', 'admin', '2018-12-09 15:05:26', 0, 'admin', '2018-12-09 15:05:33', '', '', '80539147005071360', 1, 0.00, '', '/xboot/actCategory/add**', '添加流程分类', '', 3, 'add', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('84087480852156416', 'admin', '2018-12-09 15:05:59', 0, 'admin', '2018-12-09 15:05:59', NULL, '', '80539147005071360', 1, 1.00, '', '/xboot/actCategory/edit**', '编辑流程分类', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84087593041399808', 'admin', '2018-12-09 15:06:25', 0, 'admin', '2018-12-09 15:06:25', NULL, '', '80539147005071360', 1, 2.00, '', '/xboot/actCategory/delByIds/**', '删除流程分类', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84101728340807680', 'admin', '2018-12-09 16:02:35', 0, 'admin', '2018-12-09 16:02:35', NULL, '', '5129710648430594', 1, 1.25, '', '/xboot/role/editRoleDep**', '分配数据权限', '', 3, 'editPerm', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84125128593510400', 'admin', '2018-12-09 17:35:34', 0, 'admin', '2018-12-09 17:35:34', NULL, '', '81558529864896512', 1, 2.00, '', '/xboot/actBusiness/apply*', '提交申请', '', 3, 'add', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('84125319526617088', 'admin', '2018-12-09 17:36:20', 0, 'admin', '2018-12-09 17:36:20', NULL, '', '81558529864896512', 1, 3.00, '', '/xboot/actBusiness/cancel*', '撤回申请', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('117534960889368576', 'admin', '2019-03-11 22:14:19', 0, 'admin', '2019-03-11 22:14:19', NULL, '', '76914082455752704', 1, 1.00, '', '/xboot/actProcess/updateStatus**', '编辑流程状态', '', 3, 'edit', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('103658022701633536', 'admin', '2019-02-01 15:12:20', 0, 'admin', '2019-02-01 18:38:29', '', 'test', '102235632889237504', 0, 3.00, 'xboot-vue-generator/test', 'test', '代码生成测试页', 'ios-bug', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('102240052523831296', 'admin', '2019-01-28 17:17:49', 0, 'admin', '2019-02-01 20:41:38', '', 'tree-generator', '102235632889237504', 0, 1.00, 'xboot-vue-generator/treeGenerator', 'tree', '树形结构生成[付费]', 'md-git-branch', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('102237605176807424', 'admin', '2019-01-28 17:08:06', 0, 'admin', '2019-02-01 20:41:31', '', 'table-generator', '102235632889237504', 0, 0.00, 'xboot-vue-generator/tableGenerator', 'table', '增删改表格生成[付费]', 'md-grid', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('102235632889237504', 'admin', '2019-01-28 17:00:15', 0, 'admin', '2019-03-01 17:58:50', '', 'vue-generator', '125909152017944576', 0, 4.00, 'Main', '/vue-generator', 'Vue代码生成', 'md-send', 1, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('109147152181104640', 'admin', '2019-02-16 18:44:09', 0, 'admin', '2019-02-16 18:45:18', '', '', '81716172680073216', 1, 2.00, '', '/xboot/actTask/backAll/**', '审批驳回至发起人', '', 3, 'disable', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('113603617897844736', 'admin', '2019-03-01 01:52:34', 0, 'admin', '2019-03-01 02:03:15', '', 'library', '113603512293658624', 0, 0.00, 'xboot-library/xboot-library', 'library', '第三方依赖工具/组件', 'ios-link', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('113603512293658624', 'admin', '2019-03-01 01:52:09', 0, 'admin', '2019-07-08 16:36:55', '', 'library', '125909152017944576', 0, 8.00, 'Main', '/library', '第三方依赖工具/组件', 'ios-link', 1, '', 0, '', b'0');
INSERT INTO `t_permission` VALUES ('113602342657462272', 'admin', '2019-03-01 01:47:30', 0, 'admin', '2019-03-01 02:03:26', '', 'components', '113602149589454848', 0, 0.00, 'xboot-components/xboot-components', 'components', 'XBoot业务组件', 'md-cube', 2, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('113602149589454848', 'admin', '2019-03-01 01:46:44', 0, 'admin', '2019-07-08 16:37:07', '', 'components', '125909152017944576', 0, 7.00, 'Main', '/components', 'XBoot业务组件', 'md-cube', 1, '', 0, '', b'0');
INSERT INTO `t_permission` VALUES ('118593568372690944', 'admin', '2019-03-14 20:20:51', 0, 'admin', '2019-03-14 20:20:51', NULL, 'process-finish-manage', '76606430504816640', 0, 0.80, 'activiti/process-finish-manage/processFinishManage', 'process-finish-manage', '结束的流程[付费]', 'md-power', 2, '', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('118594264144809984', 'admin', '2019-03-14 20:23:36', 0, 'admin', '2019-03-14 20:23:36', NULL, '', '118593568372690944', 1, 0.00, '', '/xboot/actProcess/delHistoricInsByIds/**', '删除结束流程', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('125909152017944576', 'admin', '2019-04-04 00:50:22', 0, 'admin', '2019-04-10 21:34:38', '', 'xboot', '', -1, 0.00, '', '', 'XBoot管理系统', 'md-home', 0, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('127995258721013760', 'admin', '2019-04-09 05:59:49', 0, 'admin', '2019-10-07 22:30:31', '', 'doc', '', -1, 2.00, '', '', 'XBoot开发文档', 'md-document', 0, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('127996320085446656', 'admin', '2019-04-09 19:04:02', 0, 'admin', '2019-07-08 16:40:48', '', 'app', '', -1, 2.00, '', '', '小程序与Flutter App', 'md-phone-portrait', 0, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('127996726786134016', 'admin', '2019-04-09 19:05:39', 0, 'admin', '2019-10-07 22:31:05', '', 'xpay', '', -1, 4.00, '', '', 'XPay支付系统', 'md-cash', 0, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('127997001756315648', 'admin', '2019-04-09 19:06:44', 0, 'admin', '2019-10-07 22:30:55', '', 'xmall', '', -1, 5.00, '', '', 'XMall商城', 'md-cart', 0, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('128364633437245440', 'admin', '2019-04-10 19:27:35', 0, 'admin', '2019-10-07 22:31:16', '', 'xboot-show', '', -1, 3.00, '', '', 'XBoot宣传官网', 'md-paper-plane', 0, '', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('129840863491657728', 'admin', '2019-04-14 21:13:35', 0, 'admin', '2019-04-14 21:13:35', NULL, 'redis', '39915540965232640', 0, 2.21, 'sys/redis/redis', 'redis', 'Redis缓存管理', 'md-barcode', 2, '', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('129837953827475456', 'admin', '2019-04-14 21:02:01', 0, 'admin', '2019-04-14 21:02:01', NULL, 'single-window', '41373430515240960', 0, 0.00, 'xboot-vue-template/single-window/singleWindow', 'single-window', '动态组件单页操作', 'md-easel', 2, '', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('129837352062291968', 'admin', '2019-04-14 20:59:38', 0, 'admin', '2019-04-14 20:59:38', NULL, 'flutter', '129837236362416128', 0, 0.00, 'flutter/flutter', 'flutter', 'XBoot Flutter App', 'md-phone-portrait', 2, '', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('129841267742871552', 'admin', '2019-04-14 21:15:11', 0, 'admin', '2019-04-14 21:15:56', '', '', '129840863491657728', 1, 0.00, '', '/xboot/redis/getAllByPage**', '获取Redis', '', 3, 'view', 0, '', NULL);
INSERT INTO `t_permission` VALUES ('129849583458062336', 'admin', '2019-04-14 21:48:14', 0, 'admin', '2019-04-14 21:48:14', NULL, '', '129840863491657728', 1, 1.00, '', '/xboot/redis/save', '添加Redis', '', 3, 'add', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('129849746075422720', 'admin', '2019-04-14 21:48:52', 0, 'admin', '2019-04-14 21:48:52', NULL, '', '129840863491657728', 1, 2.00, '', '/xboot/redis/delByKeys**', '删除Redis', '', 3, 'delete', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('129849893157081088', 'admin', '2019-04-14 21:49:28', 0, 'admin', '2019-04-14 21:49:28', NULL, '', '129840863491657728', 1, 3.00, '', '/xboot/redis/delAll', '清空Redis', '', 3, 'clear', 0, NULL, NULL);
INSERT INTO `t_permission` VALUES ('160573807516454912', 'admin', '2019-07-08 16:35:20', 0, 'admin', '2019-07-08 16:35:20', NULL, '', '5129710648430593', 1, 1.18, '', '/xboot/user/resetPass', '重置密码', '', 3, 'other', 0, NULL, b'1');
INSERT INTO `t_permission` VALUES ('160575004944109568', 'admin', '2019-07-08 16:40:05', 0, 'admin', '2019-07-08 16:44:19', '', 'admin', '39915540965232640', 0, 2.31, 'sys/monitor/monitor', 'admin', 'Admin监控', 'md-speedometer', 2, '', 0, 'http://xboot.exrick.cn/xboot/admin', b'1');
INSERT INTO `t_permission` VALUES ('160575335685951488', 'admin', '2019-07-08 16:41:24', 0, 'admin', '2019-07-08 16:42:15', '', 'weapp', '127996320085446656', 0, 0.00, 'Main', '/weapp', '微信小程序', 'ios-apps', 1, '', 0, '', b'0');
INSERT INTO `t_permission` VALUES ('160575718567186432', 'admin', '2019-07-08 16:42:55', 0, 'admin', '2019-07-08 16:42:55', NULL, 'weapp', '160575335685951488', 0, 0.00, 'weapp/weapp', 'weapp', '微信小程序', 'ios-apps', 2, '', 0, NULL, b'1');
INSERT INTO `t_permission` VALUES ('171104546104283136', 'admin', '2019-08-06 18:00:44', 0, 'admin', '2019-08-06 18:00:44', NULL, '', '81716172680073216', 1, 0.10, '', '/xboot/actTask/passAll/**', '批量通过', '', 3, 'other', 0, NULL, b'1');
INSERT INTO `t_permission` VALUES ('171104787318706176', 'admin', '2019-08-06 18:01:41', 0, 'admin', '2019-08-06 18:01:41', NULL, '', '81716172680073216', 1, 1.10, '', '/xboot/actTask/backAll/**', '批量驳回', '', 3, 'other', 0, NULL, b'1');
INSERT INTO `t_permission` VALUES ('175861999454916608', 'admin', '2019-08-19 21:05:09', 0, 'admin', '2019-08-19 21:05:09', NULL, 'sso', '175861914318934016', 0, 0.00, 'sso/sso', 'sso', '单点登录测试站', 'md-log-in', 2, '', 0, NULL, b'1');
INSERT INTO `t_permission` VALUES ('175861914318934016', 'admin', '2019-08-19 21:04:48', 0, 'admin', '2019-08-19 21:04:48', NULL, 'sso', '125909152017944576', 0, 10.00, 'Main', '/sso', '单点登录测试站', 'md-log-in', 1, '', 0, NULL, b'0');
INSERT INTO `t_permission` VALUES ('211251678651879424', 'admin', '2019-11-25 12:51:06', 0, 'admin', '2019-11-25 12:51:06', NULL, 'client', '211251162815401984', 0, 0.00, 'open/client/client', 'client', '接入网站管理', 'md-browsers', 2, '', 0, NULL, b'1');
INSERT INTO `t_permission` VALUES ('211251162815401984', 'admin', '2019-11-25 12:49:03', 0, 'admin', '2019-11-25 13:45:46', '', 'open', '125909152017944576', 0, 2.10, 'Main', '/open', '开放平台', 'ios-apps', 1, '', 0, '', b'1');
INSERT INTO `t_permission` VALUES ('210156371755143168', 'admin', '2019-11-22 12:18:45', 0, 'admin', '2019-11-22 12:18:45', NULL, 'dashboard2', '210154306362413056', 0, 1.00, 'xboot-charts/dashboard2/dashboard2', 'dashboard2', 'Dashboard2[付费]', 'ios-speedometer', 2, '', 0, NULL, b'1');
INSERT INTO `t_permission` VALUES ('210155258859491329', 'admin', '2019-11-22 12:14:19', 0, 'admin', '2019-11-22 12:20:50', '', 'dashboard1', '210154306362413056', 0, 0.00, 'xboot-charts/dashboard1/dashboard1', 'dashboard1', 'Dashboard1[付费]', 'md-speedometer', 2, '', 0, '', b'1');
INSERT INTO `t_permission` VALUES ('210154306362413056', 'admin', '2019-11-22 12:10:32', 0, 'admin', '2019-11-25 17:34:47', '', 'charts', '125909152017944576', 0, 4.10, 'Main', '/charts', '图表数据展示', 'md-analytics', 1, '', 0, '', b'1');
COMMIT;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
BEGIN;
INSERT INTO `t_role_permission` VALUES ('211264918240890881', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16439068543946752', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918232502273', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16438962738434048', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918224113665', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16438800255291392', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918219919360', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16392767785668608', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918169587712', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16392452747300864', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918115061760', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '113603617897844736', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918064730112', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '113603512293658624', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917997621248', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '113602342657462272', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917955678208', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '113602149589454848', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917930512385', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '67082402312228864', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917922123777', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '67042515441684480', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917913735168', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '67027909637836800', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917901152257', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '67027338952445952', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917888569344', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '66790433014943744', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917871792129', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '64290663792906240', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917867597825', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '63482475359244288', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917863403520', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '56911328312299520', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917855014913', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41377034236071936', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917829849088', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41376192166629376', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917821460481', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '63741744973352960', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917808877569', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41378916912336896', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917804683264', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41375330996326400', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917800488960', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '42082442672082944', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917792100353', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '129837953827475456', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917779517441', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41373430515240960', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917771128833', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '103658022701633536', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917766934529', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '102240052523831296', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917762740225', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '102237605176807424', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917758545921', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '102235632889237504', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917754351617', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '210156371755143168', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917750157312', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '210155258859491329', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917745963008', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '210154306362413056', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917741768704', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '39918482854252544', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917737574400', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '39916171171991552', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917733380096', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '160575004944109568', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917729185792', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41469219249852416', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917720797185', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41371711400054784', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211265012549816320', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '127997001756315648', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211264917343309825', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84084965817454592', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917326532609', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '81319435670917120', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917322338304', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84084724590448640', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917297172481', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '82269650301227008', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917292978176', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84084404707659776', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917280395265', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '109147152181104640', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211265012541427712', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '127996726786134016', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211264917712408576', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '129849893157081088', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917683048449', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '129849746075422720', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917678854144', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '129849583458062336', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917649494016', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '129841267742871552', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917636911105', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '129840863491657728', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917632716800', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41364927394353152', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917628522496', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41363537456533504', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917624328192', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41363147411427328', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917615939585', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45266070000373760', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917607550976', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45265886315024384', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917582385153', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45265762415284224', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917573996545', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45265487029866496', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917565607937', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45264987354042368', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917557219329', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '41370251991977984', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917553025024', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '39915540965232640', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917548830720', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84087593041399808', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917540442112', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84087480852156416', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917536247808', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84087344352727040', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917532053504', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '80539147005071360', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917515276289', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84087154040377344', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917506887681', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84087009940869120', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917498499073', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84086882907983872', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917494304769', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76607201262702592', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917490110464', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84086362248056832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917477527553', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84086163001839616', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917469138944', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84085980943880192', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917435584512', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '117534960889368576', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917376864256', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84085810797744128', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917368475649', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84085542324539392', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917364281344', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76914082455752704', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917355892737', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '118594264144809984', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917351698432', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '118593568372690944', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917276200960', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84083641302388736', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917263618048', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84083562503999488', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917154566144', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84082369492946944', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917167149056', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84082920431554560', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917175537665', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84125128593510400', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917179731969', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84125319526617088', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917230063616', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '81716172680073216', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211265012520456192', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '128364633437245440', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012512067585', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '129837352062291968', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012507873281', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '129837236362416128', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012503678977', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '160575718567186432', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012499484673', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '160575335685951488', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012495290369', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '127996320085446656', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012491096065', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '127995258721013760', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012486901761', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '175861999454916608', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012482707457', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '175861914318934016', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012478513152', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '16439068543946752', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012474318848', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '16438962738434048', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012449153025', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '16438800255291392', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012444958720', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '16392767785668608', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012419792896', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '16392452747300864', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012415598592', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '113603617897844736', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012411404288', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '113603512293658624', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012403015681', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '113602342657462272', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012390432769', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '113602149589454848', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012386238465', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '67082402312228864', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012382044161', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '67042515441684480', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012377849857', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '67027909637836800', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012373655553', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '67027338952445952', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012369461249', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '66790433014943744', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012365266944', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '64290663792906240', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012361072640', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '63482475359244288', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012352684033', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '56911328312299520', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012340101121', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '41377034236071936', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012335906816', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '41376192166629376', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012323323904', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '63741744973352960', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012306546688', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '41378916912336896', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012281380864', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '41375330996326400', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012272992257', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '42082442672082944', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012264603648', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '129837953827475456', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012260409344', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '41373430515240960', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012252020736', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '102240052523831296', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012218466304', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '102237605176807424', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012210077696', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '102235632889237504', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012205883392', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '210156371755143168', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012197494784', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '210155258859491329', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012189106177', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '210154306362413056', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012184911872', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '39918482854252544', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211264917141983233', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '81558529864896512', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917137788928', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76606430504816640', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917121011713', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '211251678651879424', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917116817408', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '211251162815401984', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917104234497', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '61417744146370560', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917100040192', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '61394706252173312', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917095845888', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '58480609315524608', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917087457281', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76216702639017984', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917066485761', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76216594207870976', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917058097152', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76216459709124608', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917049708545', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76216264070008832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917037125633', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76216071333351424', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917032931329', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '76215889006956544', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917028737024', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '75002207560273920', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917011959809', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16695243126607872', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264917007765504', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16695107491205120', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916995182593', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16694861252005888', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916982599680', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '5129710648430595', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916974211072', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16690313745666048', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916965822465', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '84101728340807680', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916957433857', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16689883993083904', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916953239552', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16689745006432256', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916944850944', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16689632049631232', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916932268033', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16687383932047360', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916928073728', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '5129710648430594', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916911296512', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45069342940860416', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916902907904', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45235228800716800', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916848381952', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '44986029924421632', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916810633216', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '61560480518377472', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916802244608', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '61560275261722624', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916789661696', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '61560041605435392', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916777078784', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '57212882168844288', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916764495872', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '56309618086776832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916751912960', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '57009981228060672', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211265012176523264', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '39916171171991552', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012163940352', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '160575004944109568', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012113608704', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '41371711400054784', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211264916739330048', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '57009744761589760', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916718358528', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '57009544286441472', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916634472448', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45235939278065664', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916642861056', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '43117268627886080', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916655443968', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45236734832676864', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916663832577', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45237010692050944', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916676415488', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45237170029465600', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916567363584', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '40238597734928384', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916496060416', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '56898976661639168', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916508643329', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '160573807516454912', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211265012088442881', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '129840863491657728', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012084248577', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '41363147411427328', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012080054272', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '41370251991977984', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012067471361', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '39915540965232640', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012063277056', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '80539147005071360', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211264916483477504', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '25014528525733888', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916407980032', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16678447719911424', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916382814208', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '15708892205944832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916298928128', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '15701915807518720', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916227624960', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '16678126574637056', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916156321792', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '15701400130424832', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916110184448', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '5129710648430593', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264915170660352', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '125909152017944576', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916017909760', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '5129710648430592', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211265012059082752', 'admin', '2019-11-25 13:44:05', 0, 'admin', '2019-11-25 13:44:05', '76607201262702592', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012050694145', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '76914082455752704', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012046499840', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '118593568372690944', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265012004556800', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '81319435670917120', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011975196672', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '82269650301227008', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011971002368', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '81716172680073216', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011966808064', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '81558529864896512', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011962613760', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '76606430504816640', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011950030848', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '211251678651879424', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011916476416', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '211251162815401984', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011853561857', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '58480609315524608', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011849367552', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '75002207560273920', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011828396033', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '5129710648430595', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211264916600918016', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45235787867885568', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264916579946496', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '45235621697949696', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('175862130233315329', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '128364633437245440', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130229121025', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '127995258721013760', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130224926721', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '175861999454916608', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130220732417', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '175861914318934016', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130216538112', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '16439068543946752', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130199760896', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '16392767785668608', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130191372289', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '16392452747300864', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130187177985', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '57009744761589760', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130182983681', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '40238597734928384', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130178789376', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '5129710648430593', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130174595072', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '5129710648430592', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('175862130149429258', 'admin', '2019-08-19 21:05:40', 0, 'admin', '2019-08-19 21:05:40', '125909152017944576', '16457350655250432');
INSERT INTO `t_role_permission` VALUES ('211265011824201728', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '5129710648430594', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011811618816', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '44986029924421632', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011799035905', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '56309618086776832', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011794841600', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '57009744761589760', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011773870080', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '43117268627886080', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011765481472', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '40238597734928384', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011748704256', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '5129710648430593', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011710955520', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '5129710648430592', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211265011660623872', 'admin', '2019-11-25 13:44:04', 0, 'admin', '2019-11-25 13:44:04', '125909152017944576', '496138616573953');
INSERT INTO `t_role_permission` VALUES ('211264918245085185', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '175861914318934016', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918253473792', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '175861999454916608', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918257668097', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '127995258721013760', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918266056705', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '127996320085446656', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918274445312', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '160575335685951488', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918278639616', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '160575718567186432', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918282833921', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '129837236362416128', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918291222528', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '129837352062291968', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918295416833', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '128364633437245440', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918303805440', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '127996726786134016', '496138616573952');
INSERT INTO `t_role_permission` VALUES ('211264918316388353', 'admin', '2019-11-25 13:43:42', 0, 'admin', '2019-11-25 13:43:42', '127997001756315648', '496138616573952');
COMMIT;

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
  `sex` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `department_id` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `pass_strength` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES ('16739222421508096', '', '2018-06-06 18:48:02', '', '2018-10-08 00:04:32', '', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012139570@qq.com', '18782059033', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '男', 0, 0, 'test2', 0, '40652338142121984', '', '弱');
INSERT INTO `t_user` VALUES ('4363087427670016', '', '2018-05-03 15:09:42', '', '2018-10-08 00:04:46', '[\"510000\",\"510100\",\"510114\"]', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012139570@qq.com', '18782059033', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '男', 0, 0, 'test', 0, '40652338142121984', '', '弱');
INSERT INTO `t_user` VALUES ('682265633886208', '', '2018-05-01 16:13:51', 'admin', '2019-01-19 14:11:43', '[\"510000\",\"510100\",\"510104\"]', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', 'test', '2549575805@qq.com', '18782059038', 'Exrick', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '男', 0, 1, 'admin', 0, '40322777781112832', '天府1街', '弱');
INSERT INTO `t_user` VALUES ('682265633886209', '', '2018-04-30 23:28:42', 'admin', '2019-04-28 22:31:02', '', 'https://s1.ax1x.com/2018/05/19/CcdVQP.png', '', '1012@qq.com', '18782059033', '', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '女', -1, 0, 'Exrick', 0, '40322777781112832', '', '弱');
COMMIT;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('134933785559961600', NULL, '2019-04-28 22:31:02', 0, NULL, '2019-04-28 22:31:02', '496138616573953', '682265633886209');
INSERT INTO `t_user_role` VALUES ('134933785576738816', NULL, '2019-04-28 22:31:02', 0, NULL, '2019-04-28 22:31:02', '496138616573952', '682265633886209');
INSERT INTO `t_user_role` VALUES ('61392579396112384', NULL, '2018-10-08 00:04:32', 0, NULL, '2018-10-08 00:04:32', '16457350655250432', '16739222421508096');
INSERT INTO `t_user_role` VALUES ('61392637076180992', NULL, '2018-10-08 00:04:46', 0, NULL, '2018-10-08 00:04:46', '496138616573953', '4363087427670016');
INSERT INTO `t_user_role` VALUES ('98931727094779904', NULL, '2019-01-19 14:11:43', 0, NULL, '2019-01-19 14:11:43', '496138616573952', '682265633886208');

DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;
DROP TABLE IF EXISTS QRTZ_LOCKS;
DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_SIMPROP_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_JOB_DETAILS;
DROP TABLE IF EXISTS QRTZ_CALENDARS;


CREATE TABLE QRTZ_JOB_DETAILS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    PRIORITY INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(200) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(10) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CRON_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(200) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
  (          
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP) 
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_BLOB_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CALENDARS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
);

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_GROUP  VARCHAR(200) NOT NULL, 
    PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_FIRED_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    SCHED_TIME BIGINT(13) NOT NULL,
    PRIORITY INTEGER NOT NULL,
    STATE VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(200) NULL,
    JOB_GROUP VARCHAR(200) NULL,
    IS_NONCONCURRENT VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,ENTRY_ID)
);

CREATE TABLE QRTZ_SCHEDULER_STATE
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
);

CREATE TABLE QRTZ_LOCKS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME  VARCHAR(40) NOT NULL, 
    PRIMARY KEY (SCHED_NAME,LOCK_NAME)
);