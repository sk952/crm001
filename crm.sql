/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2020-05-10 09:12:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_activity`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('32ef09a7c21c4e2ab001c60366f16f46', '40f6cdea0bd34aceb77492a1656d9fb3', 'mlz', '2019-11-22', '2019-11-23', '999', '666', '2019-11-22 21:42:11', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('3c1a2708966c4ec486af5e8b6dfe747c', '40f6cdea0bd34aceb77492a1656d9fb3', 'ccvs', '2019-11-22', '2019-11-23', '666', '333', '2019-11-22 16:57:26', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('3f961715860e42ed9e2ba7e96ce92a12', '06f5fc056eac41558a964f96daa7f27c', 'msvsnw', '2019-11-04', '2019-11-05', '6000', '666666', '2019-11-24 17:02:08', '张三', '2019-11-24 17:34:47', '张三');
INSERT INTO `tbl_activity` VALUES ('467edd0b968a4ef4aa5229a6d398ed3f', '40f6cdea0bd34aceb77492a1656d9fb3', 'daidai', '2019-11-15', '2019-11-16', '654', '7777', '2019-11-24 18:00:11', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('61ab4eaad6da4e2cac0c5ed1c4c7ec08', '40f6cdea0bd34aceb77492a1656d9fb3', 'dds', '2019-11-29', '2019-11-30', '3333', '999', '2019-11-22 21:51:44', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('8a70c1cc839f41c992e981a1934d424c', null, '宣传推广会', null, null, null, null, null, null, null, null);
INSERT INTO `tbl_activity` VALUES ('8fc6b9e1fc6743ffa7e631e4f1890ff7', '40f6cdea0bd34aceb77492a1656d9fb3', 'rynw', '2019-11-23', '2019-11-24', '300', '555', '2019-11-22 21:44:06', '张三', '2019-11-26 08:21:51', '张三');
INSERT INTO `tbl_activity` VALUES ('961a764911604bc7b2b073e8bb84ab27', '40f6cdea0bd34aceb77492a1656d9fb3', 'menges', '2019-11-26', '2019-11-27', '22', '34', '2019-11-26 08:20:36', '张三', '2019-11-26 15:22:26', '张三');
INSERT INTO `tbl_activity` VALUES ('aad5589c7aa64653800167a9d79b19e5', '40f6cdea0bd34aceb77492a1656d9fb3', 'menw', '2019-11-06', '2019-11-15', '8675', '4444', '2019-11-24 17:50:26', '张三', '2019-11-26 08:19:02', '张三');
INSERT INTO `tbl_activity` VALUES ('bcfd7f9e018b423b873e465d12506024', null, '宣传推广会', null, null, null, null, null, null, null, null);
INSERT INTO `tbl_activity` VALUES ('d8946a46461b436dbbf6560d6d552211', null, '宣传推广会', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `tbl_activity_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
INSERT INTO `tbl_activity_remark` VALUES ('58763dff60d341eda9b01e1ad60e4a4b', '真的！', '2019-11-26 19:57:36', '张三', '2019-11-30 08:52:05', '张三', '1', '8fc6b9e1fc6743ffa7e631e4f1890ff7');
INSERT INTO `tbl_activity_remark` VALUES ('bb658916a9ba407a935e524069db3a93', 'al', '2019-11-26 21:42:39', '张三', null, null, '0', '467edd0b968a4ef4aa5229a6d398ed3f');
INSERT INTO `tbl_activity_remark` VALUES ('c0f437adf3604af3ab1923f9fc25145e', '备注1dds', '2010', '1', '2018', '5', '0', '61ab4eaad6da4e2cac0c5ed1c4c7ec08');
INSERT INTO `tbl_activity_remark` VALUES ('c0f437adf3604af3ab1923f9fc25145r', '备注3', '2010', '3', '2018', '5', '0', '61ab4eaad6da4e2cac0c5ed1c4c7ec08');
INSERT INTO `tbl_activity_remark` VALUES ('c0f437adf3604af3ab1923f9fc25145z', '超喜欢呀', '2010', '1', '2019-11-26 21:04:54', '张三', '1', '8fc6b9e1fc6743ffa7e631e4f1890ff7');
INSERT INTO `tbl_activity_remark` VALUES ('c9ba2d079da742f29cc4f5d5b78007da', '想当呀', '2019-11-26 21:24:01', '张三', '2019-11-26 21:24:11', '张三', '1', '8fc6b9e1fc6743ffa7e631e4f1890ff7');

-- ----------------------------
-- Table structure for `tbl_clue`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------
INSERT INTO `tbl_clue` VALUES ('00b186e202a84580897727151361eaaa', '马云', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', 'CEO', 'my@alibaba.com', '387555', 'www.alibaba.com', '133333333', '将来联系', '推销电话', '张三', '2019-11-29 16:31:44', null, null, '描述123', '纪要123', '2019-11-30', '地址123');
INSERT INTO `tbl_clue` VALUES ('a3d4c4623d7b49ec809c04dd47e51bbb', '王健林', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '万达集团', 'CEO', 'wjl@wd.com', '53888888888', 'www.wd.com', '13333333324', '虚假线索', '销售邮件', '张三', '2019-11-29 16:43:13', null, null, '123', '123', '2019-11-30', '123');

-- ----------------------------
-- Table structure for `tbl_clue_activity_relation`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------
INSERT INTO `tbl_clue_activity_relation` VALUES ('00b186e202a84580897727151361eaa2', '00b186e202a84580897727151361eaaa', '467edd0b968a4ef4aa5229a6d398ed3f');
INSERT INTO `tbl_clue_activity_relation` VALUES ('00b186e202a84580897727151361eaa3', '00b186e202a84580897727151361eaaa', '3f961715860e42ed9e2ba7e96ce92a12');
INSERT INTO `tbl_clue_activity_relation` VALUES ('00b186e202a84580897727151361eaa4', 'a3d4c4623d7b49ec809c04dd47e51bbb', '3c1a2708966c4ec486af5e8b6dfe747c');
INSERT INTO `tbl_clue_activity_relation` VALUES ('813bca49852a4f8aa9c592b3cac2868b', '00b186e202a84580897727151361eaaa', '8fc6b9e1fc6743ffa7e631e4f1890ff7');
INSERT INTO `tbl_clue_activity_relation` VALUES ('c77531d4f4804e53ad4811108cc31784', '00b186e202a84580897727151361eaaa', 'aad5589c7aa64653800167a9d79b19e5');
INSERT INTO `tbl_clue_activity_relation` VALUES ('d7805395b67a4753b4448ca33933ad6d', '00b186e202a84580897727151361eaaa', '61ab4eaad6da4e2cac0c5ed1c4c7ec08');

-- ----------------------------
-- Table structure for `tbl_clue_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------
INSERT INTO `tbl_clue_remark` VALUES ('00b186e202a84580897727151361eaa1', '备注1', '5', '5', '', '', '0', '00b186e202a84580897727151361eaa2');
INSERT INTO `tbl_clue_remark` VALUES ('00b186e202a84580897727151361eaa2', '备注2', null, null, null, null, '0', '00b186e202a84580897727151361eaaa');
INSERT INTO `tbl_clue_remark` VALUES ('00b186e202a84580897727151361eaa3', '备注3', null, null, null, null, '0', '00b186e202a84580897727151361eaaa');
INSERT INTO `tbl_clue_remark` VALUES ('00b186e202a84580897727151361eaa4', '备注4王', null, null, null, null, '1', 'a3d4c4623d7b49ec809c04dd47e51bbb');

-- ----------------------------
-- Table structure for `tbl_contacts`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
INSERT INTO `tbl_contacts` VALUES ('421d6a191d404e7caeefb09cf72e2ad0', '40f6cdea0bd34aceb77492a1656d9fb3', '推销电话', '51a175fc8cd94e0795182e606776a799', '马云', '先生', 'my@alibaba.com', '133333333', 'CEO', null, '张三', '2019-12-03 21:38:04', null, null, '描述123', '纪要123', '2019-11-30', '地址123');

-- ----------------------------
-- Table structure for `tbl_contacts_activity_relation`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
INSERT INTO `tbl_contacts_activity_relation` VALUES ('4332f3bf674a4f47946680cd0458e224', '421d6a191d404e7caeefb09cf72e2ad0', '3f961715860e42ed9e2ba7e96ce92a12');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('7cd0cb0aeb4a4835944a4cd332093efa', '421d6a191d404e7caeefb09cf72e2ad0', '467edd0b968a4ef4aa5229a6d398ed3f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('83f30adf608f423c9c9c315a74a0b1eb', '421d6a191d404e7caeefb09cf72e2ad0', '61ab4eaad6da4e2cac0c5ed1c4c7ec08');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('8e227bcb923b437a92b71bb7192a8be8', '421d6a191d404e7caeefb09cf72e2ad0', '8fc6b9e1fc6743ffa7e631e4f1890ff7');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('e51a8a45b29d42e7871221559a0ea958', '421d6a191d404e7caeefb09cf72e2ad0', 'aad5589c7aa64653800167a9d79b19e5');

-- ----------------------------
-- Table structure for `tbl_contacts_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
INSERT INTO `tbl_contacts_remark` VALUES ('3a31ac7c301643ddb2344298bb7008ee', '备注2', '张三', '2019-12-03 21:38:04', null, null, '0', '421d6a191d404e7caeefb09cf72e2ad0');
INSERT INTO `tbl_contacts_remark` VALUES ('567b04fd0bdd4c69989c8b3a512a18b4', '备注3', '张三', '2019-12-03 21:38:04', null, null, '0', '421d6a191d404e7caeefb09cf72e2ad0');

-- ----------------------------
-- Table structure for `tbl_customer`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('51a175fc8cd94e0795182e606776a799', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', 'www.alibaba.com', '387555', '张三', '2019-12-03 21:38:04', null, null, '纪要123', '2019-11-30', '描述123', '地址123');
INSERT INTO `tbl_customer` VALUES ('53cd6d952dc14af8a75f8d0720b07b58', '40f6cdea0bd34aceb77492a1656d9fb3', 'rr', null, null, '张三', '2019-12-06 11:42:46', null, null, null, '2019-12-06', null, null);

-- ----------------------------
-- Table structure for `tbl_customer_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
INSERT INTO `tbl_customer_remark` VALUES ('71f3b7d8207246ffadad987a639f5420', '备注3', '张三', '2019-12-03 21:38:04', null, null, '0', '51a175fc8cd94e0795182e606776a799');
INSERT INTO `tbl_customer_remark` VALUES ('891045d653c34228983ab733b9df9d71', '备注2', '张三', '2019-12-03 21:38:04', null, null, '0', '51a175fc8cd94e0795182e606776a799');

-- ----------------------------
-- Table structure for `tbl_dic_type`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for `tbl_dic_value`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for `tbl_tran`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
INSERT INTO `tbl_tran` VALUES ('a1e2956eed7e480584860ed6b0726010', '40f6cdea0bd34aceb77492a1656d9fb3', '666', 'QQ', '2019-12-12', '51a175fc8cd94e0795182e606776a799', '04确定决策者', null, '推销电话', '3c1a2708966c4ec486af5e8b6dfe747c', '421d6a191d404e7caeefb09cf72e2ad0', '张三', '2019-12-03 21:38:04', null, null, '描述123', '纪要123', '2019-11-30');
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a61', null, null, null, null, null, '07成交', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a62', null, null, null, null, null, '04确定决策者', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a63', null, null, null, null, null, '07成交', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a64', null, null, null, null, null, '06谈判/复审', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a65', null, null, null, null, null, '01资质审查', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a66', null, null, null, null, null, '02需求分析', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a67', null, null, null, null, null, '05提案/报价', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a68', null, null, null, null, null, '05提案/报价', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_tran` VALUES ('c1e37bafeb0b4a62afe5144e64995a6a', '40f6cdea0bd34aceb77492a1656d9fb3', '11', 'rrr', '2019-12-05', '53cd6d952dc14af8a75f8d0720b07b58', '03价值建议', '已有业务', '广告', '0b94db302c3f44ceadef3a01e7974df2', '', '张三', '2019-12-06 11:42:46', null, null, '111', '11', '2019-12-06');

-- ----------------------------
-- Table structure for `tbl_tran_history`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
INSERT INTO `tbl_tran_history` VALUES ('048456bcd1b74274a5409c63c9d5f9b1', '03价值建议', '11', '2019-12-05', '2019-12-06 11:42:46', '张三', 'c1e37bafeb0b4a62afe5144e64995a6a');
INSERT INTO `tbl_tran_history` VALUES ('247ff634cf5442a3a29fcd124d40e614', '02需求分析', '666', '2019-12-12', '2019-12-07 09:20:06', null, 'a1e2956eed7e480584860ed6b0726010');
INSERT INTO `tbl_tran_history` VALUES ('33360ef5658f421ca72923ea3d9d44e9', '04确定决策者', '666', '2019-12-12', '2019-12-08 17:47:01', null, 'a1e2956eed7e480584860ed6b0726010');
INSERT INTO `tbl_tran_history` VALUES ('8ebd3ef74f384e42bb8cb1c52dc07369', '08丢失的线索', '666', '2019-12-12', '2019-12-07 09:19:59', null, 'a1e2956eed7e480584860ed6b0726010');
INSERT INTO `tbl_tran_history` VALUES ('ae65588e353d4619b6671d92a1a52c00', '03价值建议', '666', '2019-12-12', '2019-12-07 09:20:07', null, 'a1e2956eed7e480584860ed6b0726010');
INSERT INTO `tbl_tran_history` VALUES ('b6480ded3be045a48d2e8e12ef46369b', '05提案/报价', '666', '2019-12-12', '2019-12-08 17:46:58', null, 'a1e2956eed7e480584860ed6b0726010');
INSERT INTO `tbl_tran_history` VALUES ('b8e34fe9a7af48d287b98818830ffb36', '08丢失的线索', '666', '2019-12-12', '2019-12-08 17:47:00', null, 'a1e2956eed7e480584860ed6b0726010');
INSERT INTO `tbl_tran_history` VALUES ('f2564ad13abe40bea7f2a1b2802c841d', '07成交', '666', '2019-12-12', '2019-12-07 09:19:53', null, 'a1e2956eed7e480584860ed6b0726010');
INSERT INTO `tbl_tran_history` VALUES ('f8ccc92560234c70b4d82aa232dac004', '09因竞争丢失关闭', '666', '2019-12-12', '2019-12-07 09:20:03', null, 'a1e2956eed7e480584860ed6b0726010');
INSERT INTO `tbl_tran_history` VALUES ('fa6dcd53c55c4f018ce3413855371752', '04确定决策者', '666', '2019-12-12', '2019-12-03 21:38:04', '张三', 'a1e2956eed7e480584860ed6b0726010');

-- ----------------------------
-- Table structure for `tbl_tran_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_user`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\r\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2018-11-27 21:50:05', '1', 'A001', '192.168.1.1', '2018-11-22 12:11:40', '李四', null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2019-12-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:11:40', '张三', null, null);
