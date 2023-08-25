/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80022
Source Host           : localhost:3306
Source Database       : mantis_test

Target Server Type    : MYSQL
Target Server Version : 80022
File Encoding         : 65001

Date: 2023-05-04 19:59:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO `auth_permission` VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('24', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('25', 'Can add user', '7', 'add_user');
INSERT INTO `auth_permission` VALUES ('26', 'Can change user', '7', 'change_user');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete user', '7', 'delete_user');
INSERT INTO `auth_permission` VALUES ('28', 'Can view user', '7', 'view_user');
INSERT INTO `auth_permission` VALUES ('29', 'Can add operating record', '8', 'add_operatingrecord');
INSERT INTO `auth_permission` VALUES ('30', 'Can change operating record', '8', 'change_operatingrecord');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete operating record', '8', 'delete_operatingrecord');
INSERT INTO `auth_permission` VALUES ('32', 'Can view operating record', '8', 'view_operatingrecord');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('8', 'myapp', 'operatingrecord');
INSERT INTO `django_content_type` VALUES ('7', 'myapp', 'user');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2022-08-24 11:52:16.990824');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2022-08-24 11:52:18.109296');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2022-08-24 11:52:18.348612');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2022-08-24 11:52:18.366565');
INSERT INTO `django_migrations` VALUES ('5', 'admin', '0003_logentry_add_action_flag_choices', '2022-08-24 11:52:18.384516');
INSERT INTO `django_migrations` VALUES ('6', 'contenttypes', '0002_remove_content_type_name', '2022-08-24 11:52:18.615603');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0002_alter_permission_name_max_length', '2022-08-24 11:52:18.727993');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0003_alter_user_email_max_length', '2022-08-24 11:52:18.829308');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0004_alter_user_username_opts', '2022-08-24 11:52:18.843282');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0005_alter_user_last_login_null', '2022-08-24 11:52:18.928529');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0006_require_contenttypes_0002', '2022-08-24 11:52:18.933516');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0007_alter_validators_add_error_messages', '2022-08-24 11:52:18.948853');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0008_alter_user_username_max_length', '2022-08-24 11:52:19.061554');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0009_alter_user_last_name_max_length', '2022-08-24 11:52:19.183780');
INSERT INTO `django_migrations` VALUES ('15', 'auth', '0010_alter_group_name_max_length', '2022-08-24 11:52:19.324402');
INSERT INTO `django_migrations` VALUES ('16', 'auth', '0011_update_proxy_permissions', '2022-08-24 11:52:19.348338');
INSERT INTO `django_migrations` VALUES ('17', 'auth', '0012_alter_user_first_name_max_length', '2022-08-24 11:52:19.468017');
INSERT INTO `django_migrations` VALUES ('18', 'myapp', '0001_initial', '2022-08-24 11:52:19.505915');
INSERT INTO `django_migrations` VALUES ('19', 'sessions', '0001_initial', '2022-08-24 11:52:19.596969');
INSERT INTO `django_migrations` VALUES ('20', 'myapp', '0002_operatingrecord', '2022-08-25 06:56:18.872972');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for myapp_record
-- ----------------------------
DROP TABLE IF EXISTS `myapp_record`;
CREATE TABLE `myapp_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `env` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `crete_time_before` varchar(255) NOT NULL,
  `crete_time_after` varchar(255) NOT NULL,
  `submit_time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myapp_record
-- ----------------------------

INSERT INTO `myapp_record` VALUES ('311', '63fd97f05ec38131a9160243', '新QA', '成功', '2023-02-28 13:58:08', '2023-02-28 12:58:08', '2023-02-28 14:01:23');
INSERT INTO `myapp_record` VALUES ('312', '63fd9a81ade35a331bfc3606', '新QA', '成功', '2023-02-28 14:09:05', '2023-02-28 13:09:05', '2023-02-28 14:09:39');
INSERT INTO `myapp_record` VALUES ('313', '63fda628ffe94e3132b9405b', '新QA', '成功', '2023-02-28 14:58:48', '2023-02-28 13:58:48', '2023-02-28 15:05:41');
INSERT INTO `myapp_record` VALUES ('314', '63fdaa2affe94e3132b9406c', '新QA', '成功', '2023-02-28 15:15:54', '2023-02-28 14:15:54', '2023-02-28 15:19:40');
INSERT INTO `myapp_record` VALUES ('315', '63fdbc125ec38131a916039b', '新QA', '成功', '2023-02-28 16:32:18', '2023-02-28 15:32:18', '2023-02-28 16:33:10');
INSERT INTO `myapp_record` VALUES ('316', '63fdbdbfffe94e3132b94168', '新QA', '成功', '2023-02-28 16:39:27', '2023-02-28 15:39:27', '2023-02-28 16:39:52');
INSERT INTO `myapp_record` VALUES ('317', '640b1d85dcdd190ca18d958a', '新QA', '成功', '2023-03-10 20:07:33', '2023-03-10 19:07:33', '2023-03-10 20:11:42');
INSERT INTO `myapp_record` VALUES ('318', '640b1d85dcdd190ca18d958a', '新QA', '成功', '2023-03-10 19:07:33', '2023-03-10 18:07:33', '2023-03-10 20:11:46');
INSERT INTO `myapp_record` VALUES ('319', '640ed140bf417d0c56f6c453', '新QA', '成功', '2023-03-13 15:31:12', '2023-03-13 14:31:12', '2023-03-13 15:37:05');
INSERT INTO `myapp_record` VALUES ('320', '640ed224dcdd190ca18d965f', '新QA', '成功', '2023-03-13 15:35:00', '2023-03-13 14:35:00', '2023-03-13 15:37:23');
INSERT INTO `myapp_record` VALUES ('321', '640ed224dcdd190ca18d965f', '新QA', '成功', '2023-03-13 14:35:00', '2023-03-13 13:35:00', '2023-03-13 15:56:04');
INSERT INTO `myapp_record` VALUES ('322', '6412c23ffca0a1472f6f177e', '新QA', '成功', '2023-03-16 15:16:15', '2023-03-16 14:16:15', '2023-03-16 15:18:07');
INSERT INTO `myapp_record` VALUES ('323', '6412c3e68c851b46c6039145', '新QA', '成功', '2023-03-16 15:23:18', '2023-03-16 14:23:18', '2023-03-16 15:23:55');
INSERT INTO `myapp_record` VALUES ('324', '640ed224dcdd190ca18d965f', '新QA', '成功', '2023-03-13 13:35:00', '2023-03-13 12:35:00', '2023-03-18 19:45:08');
INSERT INTO `myapp_record` VALUES ('325', '640ed224dcdd190ca18d965f', '新QA', '成功', '2023-03-13 12:35:00', '2023-03-13 11:35:00', '2023-03-18 19:46:10');
INSERT INTO `myapp_record` VALUES ('326', '640ed224dcdd190ca18d965f', '新QA', '成功', '2023-03-13 11:35:00', '2023-03-13 10:35:00', '2023-03-18 19:50:33');
INSERT INTO `myapp_record` VALUES ('327', '641bfdf22dc8bc088c90a36c', '老QA', '成功', '2023-03-23 15:21:22', '2023-03-23 14:21:22', '2023-03-23 15:23:09');
INSERT INTO `myapp_record` VALUES ('328', '641bff15ba84d7089a463d66', '老QA', '成功', '2023-03-23 15:26:13', '2023-03-23 14:26:13', '2023-03-23 15:26:51');
INSERT INTO `myapp_record` VALUES ('329', '641c01382dc8bc088c90a394', '老QA', '成功', '2023-03-23 15:35:20', '2023-03-23 14:35:20', '2023-03-23 15:35:59');
INSERT INTO `myapp_record` VALUES ('330', '641c043eba84d7089a463d7a', '老QA', '成功', '2023-03-23 15:48:14', '2023-03-23 14:48:14', '2023-03-23 15:49:02');
INSERT INTO `myapp_record` VALUES ('331', '641c073c2dc8bc088c90a3a4', '老QA', '成功', '2023-03-23 16:01:00', '2023-03-23 15:01:00', '2023-03-23 16:01:40');
INSERT INTO `myapp_record` VALUES ('332', '641c0da42dc8bc088c90a3e7', '老QA', '成功', '2023-03-23 16:28:20', '2023-03-23 15:28:20', '2023-03-23 16:50:13');
INSERT INTO `myapp_record` VALUES ('333', '641c320cba84d7089a463dba', '老QA', '成功', '2023-03-23 19:03:40', '2023-03-23 18:03:40', '2023-03-23 19:04:31');
INSERT INTO `myapp_record` VALUES ('334', '641c3308ba84d7089a463dc8', '老QA', '成功', '2023-03-23 19:07:52', '2023-03-23 18:07:52', '2023-03-23 19:08:32');
INSERT INTO `myapp_record` VALUES ('335', '641d3f512dc8bc088c90a436', '老QA', '成功', '2023-03-24 14:12:33', '2023-03-24 13:12:33', '2023-03-24 14:13:34');
INSERT INTO `myapp_record` VALUES ('336', '641c043eba84d7089a463d7a', '老QA', '成功', '2023-03-23 14:48:14', '2023-03-23 13:48:14', '2023-03-25 17:41:14');
INSERT INTO `myapp_record` VALUES ('337', '64213a29f467121f2465bf53', '老QA', '成功', '2023-03-27 14:39:37', '2023-03-27 13:39:37', '2023-03-27 14:45:23');
INSERT INTO `myapp_record` VALUES ('338', '64213c22f467121f2465bf62', '老QA', '成功', '2023-03-27 14:48:02', '2023-03-27 13:48:02', '2023-03-27 14:52:44');
INSERT INTO `myapp_record` VALUES ('339', '64216264f515303d6b444391', '老QA', '成功', '2023-03-27 17:31:16', '2023-03-27 16:31:16', '2023-03-27 17:33:53');
INSERT INTO `myapp_record` VALUES ('340', '64218598f515303d6b4443e7', '老QA', '成功', '2023-03-27 20:01:28', '2023-03-27 19:01:28', '2023-03-27 20:02:39');
INSERT INTO `myapp_record` VALUES ('341', '64217de61809b23da005098a', '老QA', '成功', '2023-03-27 19:28:38', '2023-03-27 18:28:38', '2023-03-27 20:07:52');
INSERT INTO `myapp_record` VALUES ('342', '64224dfe1809b23da0050a4a', '老QA', '成功', '2023-03-28 10:16:30', '2023-03-28 09:16:30', '2023-03-28 10:17:04');
INSERT INTO `myapp_record` VALUES ('343', '64225359f515303d6b444477', '老QA', '成功', '2023-03-28 10:39:21', '2023-03-28 09:39:21', '2023-03-28 10:45:04');
INSERT INTO `myapp_record` VALUES ('344', '6422620df515303d6b4444b2', '老QA', '成功', '2023-03-28 11:42:05', '2023-03-28 10:42:05', '2023-03-28 11:42:39');
INSERT INTO `myapp_record` VALUES ('345', '6422c7cad747a23da11a27bb', '老QA', '成功', '2023-03-28 18:56:10', '2023-03-28 17:56:10', '2023-03-28 18:56:57');
INSERT INTO `myapp_record` VALUES ('346', '6423a027f515303d6b444768', '老QA', '成功', '2023-03-29 10:19:19', '2023-03-29 09:19:19', '2023-03-29 10:22:02');
INSERT INTO `myapp_record` VALUES ('347', '6423a569f515303d6b44477d', '老QA', '成功', '2023-03-29 10:41:45', '2023-03-29 09:41:45', '2023-03-29 10:43:48');
INSERT INTO `myapp_record` VALUES ('348', '642424c7d747a23da11a2974', '老QA', '成功', '2023-03-29 19:45:11', '2023-03-29 18:45:11', '2023-03-29 19:46:23');
INSERT INTO `myapp_record` VALUES ('349', '6425000621801d70ba6f6b92', '新QA', '成功', '2023-03-30 11:20:38', '2023-03-30 10:20:38', '2023-03-30 11:23:42');
INSERT INTO `myapp_record` VALUES ('350', '642538b1e22bea70780e8a2a', '新QA', '成功', '2023-03-30 15:22:25', '2023-03-30 14:22:25', '2023-03-30 15:23:14');
INSERT INTO `myapp_record` VALUES ('351', '6425391ce22bea70780e8a4d', '新QA', '成功', '2023-03-30 15:24:12', '2023-03-30 14:24:12', '2023-03-30 15:26:25');
INSERT INTO `myapp_record` VALUES ('352', '64253a5d21801d70ba6f6ca0', '新QA', '成功', '2023-03-30 15:29:33', '2023-03-30 14:29:33', '2023-03-30 15:30:18');
INSERT INTO `myapp_record` VALUES ('353', '642542fb78fe4b7025b02500', '新QA', '成功', '2023-03-30 16:06:19', '2023-03-30 15:06:19', '2023-03-30 16:06:59');
INSERT INTO `myapp_record` VALUES ('354', '64254d00e22bea70780e8af4', '新QA', '成功', '2023-03-30 16:49:04', '2023-03-30 15:49:04', '2023-03-30 16:49:35');
INSERT INTO `myapp_record` VALUES ('355', '64256942e22bea70780e8c9a', '新QA', '成功', '2023-03-30 18:49:38', '2023-03-30 17:49:38', '2023-03-30 18:51:27');
INSERT INTO `myapp_record` VALUES ('356', '642a817778fe4b7025b02e1f', '新QA', '成功', '2023-04-03 15:34:15', '2023-04-03 14:34:15', '2023-04-03 15:52:39');
INSERT INTO `myapp_record` VALUES ('357', '642a917d78fe4b7025b02e3f', '新QA', '成功', '2023-04-03 16:42:37', '2023-04-03 15:42:37', '2023-04-03 16:52:02');
INSERT INTO `myapp_record` VALUES ('358', '642a91e1e22bea70780e9326', '新QA', '成功', '2023-04-03 16:44:17', '2023-04-03 15:44:17', '2023-04-03 16:52:13');
INSERT INTO `myapp_record` VALUES ('359', '642a937078fe4b7025b02e4f', '新QA', '成功', '2023-04-03 16:50:56', '2023-04-03 15:50:56', '2023-04-03 16:52:23');
INSERT INTO `myapp_record` VALUES ('360', '642a940421801d70ba6f75b6', '新QA', '成功', '2023-04-03 16:53:24', '2023-04-03 15:53:24', '2023-04-03 16:55:58');
INSERT INTO `myapp_record` VALUES ('361', '642a9453e22bea70780e9332', '新QA', '成功', '2023-04-03 16:54:43', '2023-04-03 15:54:43', '2023-04-03 16:56:08');
INSERT INTO `myapp_record` VALUES ('362', '642d16fe21801d70ba6f7655', '新QA', '成功', '2023-04-05 14:36:46', '2023-04-05 13:36:46', '2023-04-05 14:37:38');
INSERT INTO `myapp_record` VALUES ('363', '643377f54d1a700e3a6ece8f', '老QA', '成功', '2023-04-10 10:44:05', '2023-04-10 09:44:05', '2023-04-10 11:47:05');
INSERT INTO `myapp_record` VALUES ('364', '6433871577d1b20e5ca88ebe', '老QA', '成功', '2023-04-10 11:48:37', '2023-04-10 10:48:37', '2023-04-10 15:47:04');
INSERT INTO `myapp_record` VALUES ('365', '6433bff677d1b20e5ca88f91', '老QA', '成功', '2023-04-10 15:51:18', '2023-04-10 14:51:18', '2023-04-10 15:56:11');
INSERT INTO `myapp_record` VALUES ('366', '6433c4174d1a700e3a6ecf29', '老QA', '成功', '2023-04-10 16:08:55', '2023-04-10 15:08:55', '2023-04-10 17:01:41');
INSERT INTO `myapp_record` VALUES ('367', '6433dbf077d1b20e5ca88ff2', '老QA', '成功', '2023-04-10 17:50:40', '2023-04-10 16:50:40', '2023-04-10 17:52:12');
INSERT INTO `myapp_record` VALUES ('368', '6433d9984d1a700e3a6ecf72', '老QA', '成功', '2023-04-10 17:40:40', '2023-04-10 16:40:40', '2023-04-10 18:01:22');
INSERT INTO `myapp_record` VALUES ('369', '6433ee38fb60e10c7943b088', '老QA', '成功', '2023-04-10 19:08:40', '2023-04-10 18:08:40', '2023-04-10 19:15:44');
INSERT INTO `myapp_record` VALUES ('370', '6434d8f53199970c443e6d02', '老QA', '成功', '2023-04-11 11:50:13', '2023-04-11 10:50:13', '2023-04-11 13:55:01');
INSERT INTO `myapp_record` VALUES ('371', '6434f7a5fb60e10c7943b109', '老QA', '成功', '2023-04-11 14:01:09', '2023-04-11 13:01:09', '2023-04-11 14:05:53');
INSERT INTO `myapp_record` VALUES ('372', '6434fb138a71650c5c69f31a', '老QA', '成功', '2023-04-11 14:15:47', '2023-04-11 13:15:47', '2023-04-11 14:28:59');
INSERT INTO `myapp_record` VALUES ('373', '6434fd83fb60e10c7943b120', '老QA', '成功', '2023-04-11 14:26:11', '2023-04-11 13:26:11', '2023-04-11 14:29:09');
INSERT INTO `myapp_record` VALUES ('374', '6434fb138a71650c5c69f31a', '老QA', '成功', '2023-04-11 13:15:47', '2023-04-11 12:15:47', '2023-04-11 14:41:23');
INSERT INTO `myapp_record` VALUES ('375', '64350349fb60e10c7943b12f', '老QA', '成功', '2023-04-11 14:50:49', '2023-04-11 13:50:49', '2023-04-11 15:36:05');
INSERT INTO `myapp_record` VALUES ('376', '64350349fb60e10c7943b12f', '老QA', '成功', '2023-04-11 13:50:49', '2023-04-11 12:50:49', '2023-04-11 15:42:36');
INSERT INTO `myapp_record` VALUES ('377', '643510ad8a71650c5c69f35c', '老QA', '成功', '2023-04-11 15:47:57', '2023-04-11 14:47:57', '2023-04-11 15:58:56');
INSERT INTO `myapp_record` VALUES ('378', '6435166f3199970c443e6d71', '老QA', '成功', '2023-04-11 16:12:31', '2023-04-11 15:12:31', '2023-04-11 16:19:02');
INSERT INTO `myapp_record` VALUES ('379', '643518fefb60e10c7943b176', '老QA', '成功', '2023-04-11 16:23:26', '2023-04-11 15:23:26', '2023-04-11 16:24:00');
INSERT INTO `myapp_record` VALUES ('380', '64351ac38a71650c5c69f386', '老QA', '成功', '2023-04-11 16:30:59', '2023-04-11 15:30:59', '2023-04-11 16:31:39');
INSERT INTO `myapp_record` VALUES ('381', '64352a93fb60e10c7943b1e2', '老QA', '成功', '2023-04-11 17:38:27', '2023-04-11 16:38:27', '2023-04-11 18:56:54');
INSERT INTO `myapp_record` VALUES ('382', '64353dc48a71650c5c69f459', '老QA', '成功', '2023-04-11 19:00:20', '2023-04-11 18:00:20', '2023-04-11 19:23:46');
INSERT INTO `myapp_record` VALUES ('383', '643545c33199970c443e6e1d', '老QA', '成功', '2023-04-11 19:34:27', '2023-04-11 18:34:27', '2023-04-11 19:39:24');
INSERT INTO `myapp_record` VALUES ('384', '64354bb88a71650c5c69f467', '老QA', '成功', '2023-04-11 19:59:52', '2023-04-11 18:59:52', '2023-04-11 20:00:48');
INSERT INTO `myapp_record` VALUES ('385', '64364b673199970c443e6edf', '老QA', '成功', '2023-04-12 14:10:47', '2023-04-12 13:10:47', '2023-04-12 14:21:52');
INSERT INTO `myapp_record` VALUES ('386', '64364f978a71650c5c69f56c', '老QA', '成功', '2023-04-12 14:28:39', '2023-04-12 13:28:39', '2023-04-12 14:42:25');
INSERT INTO `myapp_record` VALUES ('387', '6436573f8a71650c5c69f57f', '老QA', '成功', '2023-04-12 15:01:19', '2023-04-12 14:01:19', '2023-04-12 15:02:10');
INSERT INTO `myapp_record` VALUES ('388', '643666a4fb60e10c7943b34f', '老QA', '成功', '2023-04-12 16:07:00', '2023-04-12 15:07:00', '2023-04-12 16:07:52');
INSERT INTO `myapp_record` VALUES ('389', '64366930fb60e10c7943b35b', '老QA', '成功', '2023-04-12 16:17:52', '2023-04-12 15:17:52', '2023-04-12 16:18:44');
INSERT INTO `myapp_record` VALUES ('390', '64367e3e7585046e1b11c12e', '老QA', '成功', '2023-04-12 17:47:42', '2023-04-12 16:47:42', '2023-04-12 18:01:52');
INSERT INTO `myapp_record` VALUES ('391', '6437cc4121f4cd76167641e1', '新QA', '成功', '2023-04-13 17:32:49', '2023-04-13 16:32:49', '2023-04-13 17:45:05');
INSERT INTO `myapp_record` VALUES ('392', '643e3db630fab41fdb8abded', '新QA', '成功', '2023-04-18 14:50:30', '2023-04-18 13:50:30', '2023-04-18 14:52:20');
INSERT INTO `myapp_record` VALUES ('393', '643e3f3630fab41fdb8abdf6', '新QA', '成功', '2023-04-18 14:56:54', '2023-04-18 13:56:54', '2023-04-18 14:57:16');
INSERT INTO `myapp_record` VALUES ('394', '64489fd272ac9c1ffe5c1a18', '新QA', '成功', '2023-04-26 11:51:46', '2023-04-26 10:51:46', '2023-04-26 11:52:32');
INSERT INTO `myapp_record` VALUES ('395', '64489fbdf7e1821fb20e772b', '新QA', '成功', '2023-04-26 11:51:25', '2023-04-26 10:51:25', '2023-04-26 11:52:41');
INSERT INTO `myapp_record` VALUES ('396', '64489fa5f7e1821fb20e7722', '新QA', '成功', '2023-04-26 11:51:01', '2023-04-26 10:51:01', '2023-04-26 11:52:51');
INSERT INTO `myapp_record` VALUES ('397', '644b292ef7e1821fb20e7c8e', '新QA', '成功', '2023-04-28 10:02:22', '2023-04-28 09:02:22', '2023-04-28 13:38:01');
INSERT INTO `myapp_record` VALUES ('398', '644b292ef7e1821fb20e7c8e', '新QA', '成功', '2023-04-28 09:02:22', '2023-04-28 08:02:22', '2023-04-28 13:38:30');
