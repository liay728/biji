/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.5.5-10.5.6-MariaDB : Database - testspringboottwo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`testspringboottwo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `testspringboottwo`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `pass_word` varchar(50) DEFAULT NULL COMMENT '用户密码',
  `telePhone` varchar(50) DEFAULT NULL COMMENT '用户电话',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`id`,`admin_name`,`pass_word`,`telePhone`) values (1,'234','sd','456454684');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `oid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `aid` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `pid` bigint(20) DEFAULT NULL COMMENT '商品ID',
  `pname` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `pprice` double(20,2) DEFAULT NULL COMMENT '商品价格',
  `number` int(11) DEFAULT NULL COMMENT '购买数量',
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

/*Data for the table `orders` */

insert  into `orders`(`oid`,`aid`,`admin_name`,`pid`,`pname`,`pprice`,`number`) values (128,1,'李珏岑',1,'苹果',5.12,1),(129,1,'李珏岑',1,'苹果',5.12,1),(130,1,'李珏岑',1,'苹果',5.12,1);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `pid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pname` varchar(50) DEFAULT NULL COMMENT '商品名称',
  `pprice` double(20,2) DEFAULT NULL COMMENT '商品价格',
  `stock` int(11) DEFAULT NULL COMMENT '商品库存',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`pid`,`pname`,`pprice`,`stock`) values (1,'苹果',5.12,50),(2,'香蕉',6.12,50),(3,'桃子',4.12,50),(4,'猕猴桃',8.12,50);

/*Table structure for table `undo_log` */

DROP TABLE IF EXISTS `undo_log`;

CREATE TABLE `undo_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(11) NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `undo_log` */

/*Table structure for table `zipkin_annotations` */

DROP TABLE IF EXISTS `zipkin_annotations`;

CREATE TABLE `zipkin_annotations` (
  `trace_id_high` bigint(20) NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(20) NOT NULL COMMENT 'coincides with zipkin_spans.trace_id',
  `span_id` bigint(20) NOT NULL COMMENT 'coincides with zipkin_spans.id',
  `a_key` varchar(255) NOT NULL COMMENT 'BinaryAnnotation.key or Annotation.value if type == -1',
  `a_value` blob DEFAULT NULL COMMENT 'BinaryAnnotation.value(), which must be smaller than 64KB',
  `a_type` int(11) NOT NULL COMMENT 'BinaryAnnotation.type() or -1 if Annotation',
  `a_timestamp` bigint(20) DEFAULT NULL COMMENT 'Used to implement TTL; Annotation.timestamp or zipkin_spans.timestamp',
  `endpoint_ipv4` int(11) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_ipv6` binary(16) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null, or no IPv6 address',
  `endpoint_port` smallint(6) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_service_name` varchar(255) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  UNIQUE KEY `trace_id_high` (`trace_id_high`,`trace_id`,`span_id`,`a_key`,`a_timestamp`) COMMENT 'Ignore insert on duplicate',
  KEY `trace_id_high_2` (`trace_id_high`,`trace_id`,`span_id`) COMMENT 'for joining with zipkin_spans',
  KEY `trace_id_high_3` (`trace_id_high`,`trace_id`) COMMENT 'for getTraces/ByIds',
  KEY `endpoint_service_name` (`endpoint_service_name`) COMMENT 'for getTraces and getServiceNames',
  KEY `a_type` (`a_type`) COMMENT 'for getTraces and autocomplete values',
  KEY `a_key` (`a_key`) COMMENT 'for getTraces and autocomplete values',
  KEY `trace_id` (`trace_id`,`span_id`,`a_key`) COMMENT 'for dependencies job'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED;

/*Data for the table `zipkin_annotations` */

insert  into `zipkin_annotations`(`trace_id_high`,`trace_id`,`span_id`,`a_key`,`a_value`,`a_type`,`a_timestamp`,`endpoint_ipv4`,`endpoint_ipv6`,`endpoint_port`,`endpoint_service_name`) values (0,6340704940610023555,3422638396599665195,'cs',NULL,-1,1612406389626416,171531876,NULL,NULL,'order'),(0,6340704940610023555,3422638396599665195,'cr',NULL,-1,1612406390504982,171531876,NULL,NULL,'order'),(0,6340704940610023555,3422638396599665195,'http.method','GET',6,1612406389626416,171531876,NULL,NULL,'order'),(0,6340704940610023555,3422638396599665195,'sr',NULL,-1,1612406389833359,171531876,NULL,NULL,'product'),(0,6340704940610023555,3422638396599665195,'http.path','/product/getProductById/1',6,1612406389626416,171531876,NULL,NULL,'order'),(0,6340704940610023555,3422638396599665195,'ss',NULL,-1,1612406390472608,171531876,NULL,NULL,'product'),(0,6340704940610023555,3422638396599665195,'ca','',0,1612406389833359,171531876,NULL,-5165,''),(0,6340704940610023555,-2607300481889470149,'sr',NULL,-1,1612406388180592,171531876,NULL,NULL,'order'),(0,6340704940610023555,3422638396599665195,'http.method','GET',6,1612406389833359,171531876,NULL,NULL,'product'),(0,6340704940610023555,-2607300481889470149,'ss',NULL,-1,1612406391372904,171531876,NULL,NULL,'order'),(0,6340704940610023555,3422638396599665195,'http.path','/product/getProductById/1',6,1612406389833359,171531876,NULL,NULL,'product'),(0,6340704940610023555,-2607300481889470149,'ca','',0,1612406388180592,NULL,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,''),(0,6340704940610023555,3422638396599665195,'mvc.controller.class','ProductController',6,1612406389833359,171531876,NULL,NULL,'product'),(0,6340704940610023555,-2607300481889470149,'http.method','GET',6,1612406388180592,171531876,NULL,NULL,'order'),(0,6340704940610023555,3422638396599665195,'mvc.controller.method','getProductById',6,1612406389833359,171531876,NULL,NULL,'product'),(0,6340704940610023555,-2607300481889470149,'http.path','/order/createOrderByOpenFeignAndSentinel/1',6,1612406388180592,171531876,NULL,NULL,'order'),(0,6340704940610023555,-2607300481889470149,'mvc.controller.class','OrderController',6,1612406388180592,171531876,NULL,NULL,'order'),(0,6340704940610023555,-2607300481889470149,'mvc.controller.method','createOrderByOpenFeignAndSentinel',6,1612406388180592,171531876,NULL,NULL,'order'),(0,6340704940610023555,-2607300481889470149,'cs',NULL,-1,1612406387737230,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,-2607300481889470149,'cr',NULL,-1,1612406391382124,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,-2607300481889470149,'http.method','GET',6,1612406387737230,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,-2607300481889470149,'http.path','/order/createOrderByOpenFeignAndSentinel/1',6,1612406387737230,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,-2607300481889470149,'sa','',0,1612406387737230,171531876,NULL,8091,''),(0,6340704940610023555,5847315735943032044,'cs',NULL,-1,1612406387599904,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,5847315735943032044,'cr',NULL,-1,1612406391394867,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,5847315735943032044,'http.method','GET',6,1612406387599904,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,5847315735943032044,'http.path','/order/createOrderByOpenFeignAndSentinel/1',6,1612406387599904,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,6340704940610023555,'sr',NULL,-1,1612406386104010,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,6340704940610023555,'ss',NULL,-1,1612406391433652,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,6340704940610023555,'ca','',0,1612406386104010,NULL,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',-5169,''),(0,6340704940610023555,6340704940610023555,'http.method','GET',6,1612406386104010,171531876,NULL,NULL,'gateway'),(0,6340704940610023555,6340704940610023555,'http.path','/order-serv/order/createOrderByOpenFeignAndSentinel/1',6,1612406386104010,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,8482448236054361508,'cs',NULL,-1,1612406395131248,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,8482448236054361508,'cr',NULL,-1,1612406395183286,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,8482448236054361508,'http.method','GET',6,1612406395131248,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,8482448236054361508,'http.path','/order/createOrderByOpenFeignAndSentinel/1',6,1612406395131248,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,8482448236054361508,'sa','',0,1612406395131248,171531876,NULL,8091,''),(0,-8124200116544767719,3919318874327988906,'cs',NULL,-1,1612406395127121,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,3919318874327988906,'cr',NULL,-1,1612406395183835,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,3919318874327988906,'http.method','GET',6,1612406395127121,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,3919318874327988906,'http.path','/order/createOrderByOpenFeignAndSentinel/1',6,1612406395127121,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,-8124200116544767719,'sr',NULL,-1,1612406395123060,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,-8124200116544767719,'ss',NULL,-1,1612406395186601,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,-8124200116544767719,'ca','',0,1612406395123060,NULL,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',-5169,''),(0,-8124200116544767719,-8124200116544767719,'http.method','GET',6,1612406395123060,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,-8124200116544767719,'http.path','/order-serv/order/createOrderByOpenFeignAndSentinel/1',6,1612406395123060,171531876,NULL,NULL,'gateway'),(0,-8124200116544767719,7524308009092563519,'sr',NULL,-1,1612406395148173,171531876,NULL,NULL,'product'),(0,-8124200116544767719,7524308009092563519,'ss',NULL,-1,1612406395164670,171531876,NULL,NULL,'product'),(0,-8124200116544767719,7524308009092563519,'ca','',0,1612406395148173,171531876,NULL,-5165,''),(0,-8124200116544767719,7524308009092563519,'http.method','GET',6,1612406395148173,171531876,NULL,NULL,'product'),(0,-8124200116544767719,7524308009092563519,'http.path','/product/getProductById/1',6,1612406395148173,171531876,NULL,NULL,'product'),(0,-8124200116544767719,7524308009092563519,'mvc.controller.class','ProductController',6,1612406395148173,171531876,NULL,NULL,'product'),(0,-8124200116544767719,7524308009092563519,'mvc.controller.method','getProductById',6,1612406395148173,171531876,NULL,NULL,'product'),(0,-8124200116544767719,7524308009092563519,'cs',NULL,-1,1612406395138982,171531876,NULL,NULL,'order'),(0,-8124200116544767719,7524308009092563519,'cr',NULL,-1,1612406395164871,171531876,NULL,NULL,'order'),(0,-8124200116544767719,7524308009092563519,'http.method','GET',6,1612406395138982,171531876,NULL,NULL,'order'),(0,-8124200116544767719,7524308009092563519,'http.path','/product/getProductById/1',6,1612406395138982,171531876,NULL,NULL,'order'),(0,-8124200116544767719,8482448236054361508,'sr',NULL,-1,1612406395137096,171531876,NULL,NULL,'order'),(0,-8124200116544767719,8482448236054361508,'ss',NULL,-1,1612406395182681,171531876,NULL,NULL,'order'),(0,-8124200116544767719,8482448236054361508,'ca','',0,1612406395137096,NULL,'\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',NULL,''),(0,-8124200116544767719,8482448236054361508,'http.method','GET',6,1612406395137096,171531876,NULL,NULL,'order'),(0,-8124200116544767719,8482448236054361508,'http.path','/order/createOrderByOpenFeignAndSentinel/1',6,1612406395137096,171531876,NULL,NULL,'order'),(0,-8124200116544767719,8482448236054361508,'mvc.controller.class','OrderController',6,1612406395137096,171531876,NULL,NULL,'order'),(0,-8124200116544767719,8482448236054361508,'mvc.controller.method','createOrderByOpenFeignAndSentinel',6,1612406395137096,171531876,NULL,NULL,'order');

/*Table structure for table `zipkin_dependencies` */

DROP TABLE IF EXISTS `zipkin_dependencies`;

CREATE TABLE `zipkin_dependencies` (
  `day` date NOT NULL,
  `parent` varchar(255) NOT NULL,
  `child` varchar(255) NOT NULL,
  `call_count` bigint(20) DEFAULT NULL,
  `error_count` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`day`,`parent`,`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED;

/*Data for the table `zipkin_dependencies` */

/*Table structure for table `zipkin_spans` */

DROP TABLE IF EXISTS `zipkin_spans`;

CREATE TABLE `zipkin_spans` (
  `trace_id_high` bigint(20) NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `remote_service_name` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `debug` bit(1) DEFAULT NULL,
  `start_ts` bigint(20) DEFAULT NULL COMMENT 'Span.timestamp(): epoch micros used for endTs query and to implement TTL',
  `duration` bigint(20) DEFAULT NULL COMMENT 'Span.duration(): micros used for minDuration and maxDuration query',
  PRIMARY KEY (`trace_id_high`,`trace_id`,`id`),
  KEY `trace_id_high` (`trace_id_high`,`trace_id`) COMMENT 'for getTracesByIds',
  KEY `name` (`name`) COMMENT 'for getTraces and getSpanNames',
  KEY `remote_service_name` (`remote_service_name`) COMMENT 'for getTraces and getRemoteServiceNames',
  KEY `start_ts` (`start_ts`) COMMENT 'for getTraces ordering and range'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED;

/*Data for the table `zipkin_spans` */

insert  into `zipkin_spans`(`trace_id_high`,`trace_id`,`id`,`name`,`remote_service_name`,`parent_id`,`debug`,`start_ts`,`duration`) values (0,-8124200116544767719,-8124200116544767719,'get',NULL,NULL,NULL,1612406395123060,63541),(0,-8124200116544767719,3919318874327988906,'get',NULL,-8124200116544767719,NULL,1612406395127121,56714),(0,-8124200116544767719,7524308009092563519,'get',NULL,8482448236054361508,NULL,1612406395138982,25889),(0,-8124200116544767719,8482448236054361508,'get /createorderbyopenfeignandsentinel/{pid}',NULL,-8124200116544767719,NULL,1612406395131248,52038),(0,6340704940610023555,-2607300481889470149,'get',NULL,6340704940610023555,NULL,1612406387737230,3644894),(0,6340704940610023555,3422638396599665195,'get',NULL,-2607300481889470149,NULL,1612406389626416,878566),(0,6340704940610023555,5847315735943032044,'get',NULL,6340704940610023555,NULL,1612406387599904,3794963),(0,6340704940610023555,6340704940610023555,'get',NULL,NULL,NULL,1612406386104010,5329642);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
