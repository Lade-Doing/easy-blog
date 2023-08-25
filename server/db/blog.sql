/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 25/08/2023 09:39:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` bigint(0) NOT NULL,
  `account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '123456', 'abbcfc42-b1d9-45f7-9a55-24b80cee4a12');

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` bigint(0) NOT NULL,
  `category_id` bigint(0) NULL DEFAULT NULL,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `create_time` bigint(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES (421635196653637, 421578058379333, '标题一(前端)', '内容一', 1680775080433);
INSERT INTO `blog` VALUES (421635300503621, 421578058379333, '标题一(前端)', '内容一', 1680775105787);
INSERT INTO `blog` VALUES (421635334733893, 421578058379333, '标题三(前端)', '内容三', 1680775114144);
INSERT INTO `blog` VALUES (421635374620741, 421578058379333, '标题四(前端)', '内容四', 1680775123882);
INSERT INTO `blog` VALUES (421635891593285, 421578023092293, '标题一(后端)', '内容一', 1680775250096);
INSERT INTO `blog` VALUES (421635924021317, 421578023092293, '标题二(后端)', '内容二', 1680775258013);
INSERT INTO `blog` VALUES (421635987701829, 421578023092293, '标题三(后端)', '内容三', 1680775273560);
INSERT INTO `blog` VALUES (421636052373573, 421578023092293, '标题四(后端)', '内容四', 1680775289349);
INSERT INTO `blog` VALUES (421636140519493, 421578091503685, '标题一(全栈)', '内容一', 1680775310869);
INSERT INTO `blog` VALUES (421636172824645, 421578091503685, '标题二(全栈)', '内容二', 1680775318756);
INSERT INTO `blog` VALUES (421636201984069, 421578091503685, '标题三(全栈)', '内容三', 1680775325875);
INSERT INTO `blog` VALUES (421636422348869, 421578091503685, '标题四(全栈)', '内容四', 1680775379675);
INSERT INTO `blog` VALUES (421636465967173, 421578091503685, '标题五(全栈)', '内容五', 1680775390324);
INSERT INTO `blog` VALUES (421636496314437, 421578091503685, '标题六(全栈)', '内容六', 1680775397733);
INSERT INTO `blog` VALUES (421636518477893, 421578091503685, '标题七(全栈)', '内容七', 1680775403144);
INSERT INTO `blog` VALUES (421636710871109, 421578058379333, '标题五(前端)', '内容五', 1680775450115);
INSERT INTO `blog` VALUES (421636850647109, 421578058379333, '标题六(前端)', '<p>内容六</p>', 1680775484240);
INSERT INTO `blog` VALUES (422944216309829, 421578091503685, '测试', '<p>这是测试</p><p><br></p>', 1681094665310);
INSERT INTO `blog` VALUES (423107436150853, 421578091503685, '测试2', '<p>这是测试二</p><p><img src=\"http://localhost:3000\\uploads\\002c16bce852698fec9d49900.jpg\" alt=\"无\" data-href=\"\" style=\"\"/></p><p><br></p>', 1681134513904);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint(0) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (421578023092293, '后端');
INSERT INTO `category` VALUES (421578058379333, '前端');
INSERT INTO `category` VALUES (421578091503685, '全栈');
INSERT INTO `category` VALUES (422665005477957, '全干');
INSERT INTO `category` VALUES (422668386504773, '摸鱼');
INSERT INTO `category` VALUES (422939218567237, '吃饭');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色的名称',
  `status` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------

-- ----------------------------
-- Table structure for role_rule
-- ----------------------------
DROP TABLE IF EXISTS `role_rule`;
CREATE TABLE `role_rule`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `role_id` int(0) NOT NULL,
  `rule_id` int(0) NOT NULL,
  PRIMARY KEY (`id`, `role_id`, `rule_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_rule
-- ----------------------------

-- ----------------------------
-- Table structure for rule
-- ----------------------------
DROP TABLE IF EXISTS `rule`;
CREATE TABLE `rule`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `rule_id` int(0) NULL DEFAULT NULL COMMENT '父级id',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态0关闭状态1打开',
  `create_time` int(0) NULL DEFAULT NULL,
  `update_time` int(0) NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `desc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端路由name值',
  `frontpath` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前台路由注册路径',
  `condition` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `menu` tinyint(1) NULL DEFAULT NULL COMMENT '是否显示为菜单：0不显示1关闭',
  `order` int(0) NULL DEFAULT NULL COMMENT '排序',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rule
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户登录状态',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `telephone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL,
  `role_id` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `user_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
