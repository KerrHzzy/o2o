CREATE TABLE `tb_area` (
  `area_id` int(2) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(200) NOT NULL,
  `priotity` int(2) NOT NULL DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`area_id`),
  UNIQUE KEY `UK_AREA` (`area_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_person_info` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `profile_img` varchar(1024) DEFAULT NULL,
  `email` varchar(1024) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `enable_status` int(2) NOT NULL DEFAULT '0' COMMENT '0:禁止使用本商城，1:允许使用本商城',
  `user_type` int(2) NOT NULL DEFAULT '1' COMMENT '1:顾客，2:店家，3:超级管理员',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `tb_wechat_auth` (
  `wechat_auth_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `open_id` varchar(1024) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`wechat_auth_id`),
  UNIQUE KEY `open_id` (`open_id`),
  KEY `fk_wechatauth_profile` (`user_id`),
  CONSTRAINT `fk_wechatauth_profile` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

create table `tb_shop_category` ( `shop_category_id` int(11) not null auto_increment,
`shop_category_name` varchar(100) not null default '',
`shop_category_desc` varchar(1000) default '',
`shop_category_img` varchar(2000) default null,
`line_img` varchar(2000) not null,
`priority` int(2) not null default '0',
`create_time` datetime default null,
`last_edit_time` datetime default null,
`parent_id` int(11) default null,
primary key (`shop_category_id`),
constraint `fk_shop_category_self` foreign key (`parent_id`) references `tb_shop_category` (`shop_category_id`) ) ENGINE = InnoDB auto_increment = 1 default CHARSET = utf8;


CREATE TABLE `tb_localauth`(
`local_auth_id` int(10) NOT NULL AUTO_INCREMENT,
`user_id` int(10) NOT NULL,
`username` varchar(128) NOT NULL,
`password` varchar(128) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY(`local_auth_id`),
  UNIQUE KEY `uk_local_profile`(`username`),
  constraint `fk_localauth_profile` foreign key(`user_id`) references `tb_person_info`(`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

create table `tb_head_line`( `line_id` int(100) NOT NULL AUTO_INCREMENT,
`line_name` varchar(1000) DEFAULT NULL,
`line_link` varchar(2000) NOT NULL,
`line_img` varchar(2000) NOT NULL,
`priority` int(2) DEFAULT NULL,
`enable_status` int(2) NOT NULL DEFAULT '0',
`create_time` datetime DEFAULT NULL,
`last_edit_time` datetime DEFAULT NULL,
primary key (`line_id`) ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

create table `tb_shop` ( `shop_id` int(10) not null auto_increment,
`owner_id` int(10) not null comment '店铺创建人',
`area_id` int(5) default null,
`shop_category_id` int(11) default null,
`shop_name` varchar(256) not null,
`shop_desc` varchar(1024) default null,
`shop_addr` varchar(200) default null,
`phone` varchar(128) default null,
`shop_img` varchar(1024) default null,
`priority` int(3) default '0',
`create_time` datetime default null,
`last_edit_time` datetime default null,
`enable_status` int(2) not null default '0',
`advice` varchar(255) default null,
primary key (`shop_id`),
constraint `fk_shop_area` foreign key (`area_id`) references `tb_area` (`area_id`),
constraint `fk_shop_profile` foreign key (`owner_id`) references `tb_person_info` (`user_id`),
constraint `fk_shop_shopcate` foreign key (`shop_category_id`) references `tb_shop_category` (`shop_category_id`) ) ENGINE = InnoDB auto_increment = 1 default CHARSET = utf8;

create table `tb_product_category` ( `product_category_id` int(11) not null auto_increment,
`product_category_name` varchar(100) not null,
`priority` int(2) default '0',
`create_time` datetime default null,
`shop_id` int(20) not null default '0',
primary key (`product_category_id`),
constraint `fk_procate_shop` foreign key (`shop_id`) references `tb_shop` (`shop_id`) ) ENGINE = InnoDB auto_increment = 1 default CHARSET = utf8;

create table `tb_product` ( `product_id` int(100) not null auto_increment,
`product_name` varchar(100) not null,
`product_desc` varchar(2000) default null,
`img_addr` varchar(2000) default '',
`normal_price` varchar(100) default null,
`promotion_price` varchar(100) default null,
`priority` int(2) not null default '0',
`create_time` datetime default null,
`last_edit_time` datetime default null,
`enable_status` int(2) not null default '0',
`product_category_id` int(11) default null,
`shop_id` int(20) not null default '0',
primary key (`product_id`),
constraint `fk_product_procate` foreign key (`product_category_id`) references `tb_product_category` (`product_category_id`),
constraint `fk_product_shop` foreign key (`shop_id`) references `tb_shop` (`shop_id`) ) ENGINE = InnoDB auto_increment = 1 default CHARSET = utf8;

create table `tb_product_img` ( `product_img_id` int(20) not null auto_increment,
`img_addr` varchar(2000) not null,
`img_desc` varchar(2000) default null,
`priority` int(2) default '0',
`create_time` datetime default null,
`product_id` int(20) default null,
primary key (`product_img_id`),
constraint `fk_proimg_product` foreign key (`product_id`) references `tb_product` (`product_id`) ) ENGINE = InnoDB auto_increment = 1 default CHARSET = utf8;

