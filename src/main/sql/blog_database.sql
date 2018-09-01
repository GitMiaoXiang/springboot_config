/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : blog_database

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2018-02-22 17:05:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `blog_article`
-- ----------------------------
DROP TABLE IF EXISTS `blog_article`;
CREATE TABLE `blog_article` (
  `id` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `descz` text NOT NULL,
  `content` text NOT NULL,
  `isrecommend` char(1) NOT NULL,
  `ckickcount` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  `category` int(11) NOT NULL,
  `tags` varchar(255) NOT NULL,
  `updownframe` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ccategory` (`category`),
  CONSTRAINT `fk_ccategory` FOREIGN KEY (`category`) REFERENCES `blog_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_article
-- ----------------------------
INSERT INTO `blog_article` VALUES ('201711201537140', 'Spring Boot应用部署到Tomcat中无法启动问题', 'Spring Boot应用部署到Tomcat中无法启动问题', '<h1 class=\"aTitle\" style=\"font-size: 16px; position: relative; padding-top: 10px;\">Spring Boot应用部署到Tomcat中无法启动问题</h1><table width=\"97%\" align=\"center\"><tbody><tr class=\"firstRow\"><td width=\"140\" style=\"word-wrap: break-word;\">[日期：2017-10-21]</td><td align=\"center\" style=\"word-wrap: break-word;\">来源：Linux社区&nbsp; 作者：a8457013</td><td width=\"160\" align=\"right\" style=\"word-wrap: break-word;\">[字体：<a style=\"color: rgb(96, 96, 96);\">大</a>&nbsp;<a style=\"color: rgb(96, 96, 96);\">中</a>&nbsp;<a style=\"color: rgb(96, 96, 96);\">小</a>]</td></tr></tbody></table><div style=\"font-size: 12px; word-wrap: break-word; clear: both; padding: 25px; margin: 0px; overflow: hidden; width: 735px; color: rgb(51, 51, 51); font-family: tahoma, 宋体; white-space: normal; background-color: rgb(250, 250, 252);\"></div><h3>背景</h3><blockquote><p>最近公司在做一些内部的小型Web应用时， 为了提高开发效率决定使用Spring Boot， 这货自带Servlet容器，&nbsp;<br/>你在开发Web应用时可以直接在本地像运行控制台应用一样启动，省去了重复部署的时间；配置上相比于SpringMVC也是有了大大的简化。SpringBoot的应用可以直接打成一个可运行的jar包，&nbsp;<br/>你无需发愁为了不同应用要部署多个Tomcat。但是实际部署时你会发现打成Jar包的方式有一个致命的缺点，&nbsp;<br/>当你改动了一个资源文件、或者一个类时， 打要往服务器重新上传全量jar包。比如网速慢的公司(比如我们)来说， 那简直是不能忍受的！！！</p><p>还好Spring Boot也支持打包成普通的war包，&nbsp;<br/>这样你本地开发环境直接用控制台方式运行，部署到服务器时打成普通war包部署。这样既享受到了SpringBoot开发带来的快感，&nbsp;<br/>又避免了增量部署不方便的问题。可谓两全其美。 不过在打成War包时， 我也遇到了一些问题</p></blockquote><h3>问题描述</h3><p>我修改pom.xml将打包方式改成war</p><pre class=\"prettyprint\">&lt;packaging&gt;war&lt;/packaging&gt;</pre><p>完事儿打完包以后， 放到我本地Tomcat上跑了跑，发现没问题。但是部署到服务器上的Tomcat以后， 发现无法启动，错误如下：</p><pre class=\"prettyprint\">org.apache.catalina.LifecycleException:&nbsp;Failed&nbsp;to&nbsp;start&nbsp;component&nbsp;[StandardEngine[Catalina].StandardHost[localhost].StandardContext[\r\n/report]]\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:153)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.catalina.core.ContainerBase.addChildInternal(ContainerBase.java:899)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.catalina.core.ContainerBase.addChild(ContainerBase.java:875)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.catalina.core.StandardHost.addChild(StandardHost.java:652)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.catalina.startup.HostConfig.deployWAR(HostConfig.java:1092)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.catalina.startup.HostConfig$DeployWar.run(HostConfig.java:1984)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:471)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;java.util.concurrent.FutureTask.run(FutureTask.java:262)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:615)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;java.lang.Thread.run(Thread.java:745)\r\nCaused&nbsp;by:&nbsp;java.lang.NoSuchMethodError:&nbsp;javax.servlet.ServletContext.getVirtualServerName()Ljava/lang/String;\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.tomcat.websocket.server.WsServerContainer.&lt;init&gt;(WsServerContainer.java:150)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.tomcat.websocket.server.WsSci.init(WsSci.java:131)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.tomcat.websocket.server.WsSci.onStartup(WsSci.java:47)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.catalina.core.StandardContext.startInternal(StandardContext.java:5573)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at&nbsp;org.apache.catalina.util.LifecycleBase.start(LifecycleBase.java:147)\r\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;...&nbsp;10&nbsp;more</pre><p>明显不是应用代码错误，猜想应该是环境问题。经过分析， 我本地的Tomcat版本是8.0.28， 而服务器上的Tomcat是7.0.69。 我在本地下了个Tomcat7.0.70部署也报同样错误。更加确定问题跟Tomcat版本有关。经过多方查找资料，最后在Stackoverflow上看到一个老外说SpringBoot默认Servlet容器是基于Tomcat8的</p><p>在打好的war包中确实发现了Tomcat相关jar包，而且是Tomcat8的，拿Tomcat8的embed包在Tomcat7下面那肯定是不能用啊&nbsp;<br/><img title=\"\" src=\"http://www.linuxidc.com/upload/2017_10/171021135458441.png\" alt=\"这里写图片描述\"/></p><p>要支持低版本Tomcat需要在maven中指定Tomat版本，配置如下：</p><pre class=\"prettyprint\">&lt;properties&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;tomcat.version&gt;7.0.69&lt;/tomcat.version&gt;&lt;/properties&gt;</pre><p>然后依赖中加上（这个其实不加也行， 官方文档是加上的）</p><pre class=\"prettyprint\">&lt;dependency&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;groupId&gt;org.apache.tomcat&lt;/groupId&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;artifactId&gt;tomcat-juli&lt;/artifactId&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;version&gt;${tomcat.version}&lt;/version&gt;&lt;/dependency&gt;</pre><p>加上以后试了下，果然是没问题了。看了下war包中的lib目录，确实已经变成Tomcat7的包了&nbsp;<br/><img title=\"\" src=\"http://www.linuxidc.com/upload/2017_10/171021135458442.png\" alt=\"这里写图片描述\"/></p><p>但是我还是有点疑惑， 这样配置打成包岂不是换个Tomcat版本就要重新打次包？ 既然是由于SpringBoot内部的Servlet容器造成了这个限制， 那我不用行不行？ 又查了很多资料， 还真有办法！</p><pre class=\"prettyprint\">&lt;!--&nbsp;打war包时加入此项，&nbsp;告诉spring-boot&nbsp;tomcat相关jar包用外部的，不要打进去&nbsp;--&gt;&lt;dependency&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;artifactId&gt;spring-boot-starter-tomcat&lt;/artifactId&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;scope&gt;provided&lt;/scope&gt;&lt;/dependency&gt;</pre><p>试了下， 加上这个后， 上面说Tomcat的版本无需指定了， 耶! ^_^</p><hr/><h3>总结</h3><p>总结下SpringBoot应用部署到Tomcat下的配置方法用于备忘也方便遇到同样问题的朋友</p><ol class=\" list-paddingleft-2\"><li><p>将打包方式改成war&nbsp;<br/>这个没啥好说的， 肯定要改成war</p></li><li><p>配置嵌入Tomcat中的方式&nbsp;<br/>这里有两种方式可选择：</p><p>方式一：用spring-boot内置的tomcat库， 并指定你要部署到Tomcat的版本</p><pre class=\"prettyprint\">&lt;properties&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;tomcat.version&gt;7.0.69&lt;/tomcat.version&gt;&lt;/properties&gt;&lt;dependency&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;groupId&gt;org.apache.tomcat&lt;/groupId&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;artifactId&gt;tomcat-juli&lt;/artifactId&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;version&gt;${tomcat.version}&lt;/version&gt;&lt;/dependency&gt;</pre></li><li><p>方式二：不用spring-boot内置的tomcat库（强烈推荐这种方式！！）</p><pre class=\"prettyprint\">&lt;!--&nbsp;打war包时加入此项，&nbsp;告诉spring-boot&nbsp;tomcat相关jar包用外部的，不要打进去&nbsp;--&gt;&lt;dependency&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;artifactId&gt;spring-boot-starter-tomcat&lt;/artifactId&gt;&nbsp;&nbsp;&nbsp;&nbsp;&lt;scope&gt;provided&lt;/scope&gt;&lt;/dependency&gt;</pre></li></ol><p>&nbsp;</p><ol class=\" list-paddingleft-2\"><li><p>maven-war-plugin (可选)&nbsp;<br/>与maven-resources-plugin类似，当你有一些自定义的打包操作， 比如有非标准目录文件要打到war包中或者有配置文件引用了pom中的变量。 具体用法参见官方文档：<a href=\"http://maven.apache.org/components/plugins/maven-war-plugin/\" target=\"_blank\" style=\"color: rgb(179, 43, 213);\">http://maven.apache.org/components/plugins/maven-war-plugin/</a></p></li></ol><p>完！</p><p>Spring Boot入门学习笔记&nbsp;<a href=\"http://www.linuxidc.com/Linux/2016-10/135889.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2016-10/135889.htm</a></p><p>Spring Boot+Nginx+Tomcat+SSL配置笔记&nbsp;&nbsp;<a href=\"http://www.linuxidc.com/Linux/2016-01/127134.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2016-01/127134.htm</a></p><p>Spring Boot 实践心得笔记&nbsp;&nbsp;<a href=\"http://www.linuxidc.com/Linux/2017-01/139576.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2017-01/139576.htm</a></p><p>Spring Boot的启动器Starter详解&nbsp;<a href=\"http://www.linuxidc.com/Linux/2016-10/136430.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2016-10/136430.htm</a></p><p>Spring Boot在整合项目依赖jdk反复变成1.5版本的问题&nbsp;&nbsp;<a href=\"http://www.linuxidc.com/Linux/2017-03/141485.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2017-03/141485.htm</a></p><p>Spring Boot项目搭建入门教程&nbsp;&nbsp;<a href=\"http://www.linuxidc.com/Linux/2017-01/139901.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2017-01/139901.htm</a></p><p>Spring Boot 常用注解&nbsp;&nbsp;<a href=\"http://www.linuxidc.com/Linux/2017-03/142209.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2017-03/142209.htm</a></p><p>Spring Boot整合jedisCluster&nbsp;&nbsp;<a href=\"http://www.linuxidc.com/Linux/2017-03/142208.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2017-03/142208.htm</a></p><p>Spring Boot 装载自定义yml文件&nbsp;&nbsp;<a href=\"http://www.linuxidc.com/Linux/2017-04/142749.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2017-04/142749.htm</a></p><p><span style=\"color: rgb(255, 0, 0);\"><strong>Spring Boot 的详细介绍</strong></span>：<a title=\"Spring Boot\" href=\"http://www.linuxidc.com/Linux/2014-04/100712.htm\" style=\"color: rgb(179, 43, 213);\">请点这里</a><br/><span style=\"color: rgb(255, 0, 0);\"><strong>Spring Boot 的下载地址</strong></span>：<a href=\"http://www.linuxidc.com/down.aspx?id=1352\" target=\"_blank\" style=\"color: rgb(179, 43, 213);\">请点这里</a></p><p><span style=\"font-size: small;\"><strong>本文永久更新链接地址</strong></span>：<a href=\"http://www.linuxidc.com/Linux/2017-10/147870.htm\" style=\"color: rgb(179, 43, 213);\">http://www.linuxidc.com/Linux/2017-10/147870.htm</a></p><p><a href=\"http://www.linuxidc.com/\" target=\"_blank\" style=\"color: rgb(179, 43, 213);\"><img src=\"http://www.linuxidc.com/linuxfile/logo.gif\" alt=\"linux\" width=\"15\" height=\"17\"/></a></p><p><br/></p>', '1', '0', '2017-11-20 15:37:14', '2018-02-10 13:39:13', '6', 'springboot,tomcat', '0');
INSERT INTO `blog_article` VALUES ('201711211326140', '啥地方', '啥地方', '<p>啥地方</p>', '1', '0', '2017-11-21 13:26:25', '2017-11-21 13:26:25', '2', '啥地方', '0');
INSERT INTO `blog_article` VALUES ('201802101412420', '今天看看源码，有点找回感觉了', 'java', '<p>今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了今天看看源码，有点找回感觉了</p>', '1', '0', '2018-02-10 14:12:42', '2018-02-10 14:13:04', '2', '', '1');
INSERT INTO `blog_article` VALUES ('201802191535430', '啥地方', '啥地方', '<p>啥地方</p>', '1', '0', '2018-02-19 15:35:44', '2018-02-19 15:36:06', '2', '是的发送到', '1');

-- ----------------------------
-- Table structure for `blog_category`
-- ----------------------------
DROP TABLE IF EXISTS `blog_category`;
CREATE TABLE `blog_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `descz` text NOT NULL,
  `indexz` int(11) DEFAULT NULL,
  `sortz` char(2) DEFAULT NULL,
  `hrefz` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_category
-- ----------------------------
INSERT INTO `blog_category` VALUES ('1', '首页', '首页', null, '1', 'http://localhost:8081/managerblog/web/index.html');
INSERT INTO `blog_category` VALUES ('2', '摄影', '展示博主图片。', '3', '2', 'http://localhost:8081/managerblog/web/gallery.html');
INSERT INTO `blog_category` VALUES ('3', '分类', '博文类目', null, '3', '');
INSERT INTO `blog_category` VALUES ('4', '博客排版', '点击这个可以更换博客排版', null, '5', '');
INSERT INTO `blog_category` VALUES ('5', '留言', '用户可以在这里留言', null, '6', 'http://localhost:8081/managerblog/web/message.html');
INSERT INTO `blog_category` VALUES ('6', 'java', '分类里面的类目', '3', '1', 'http://localhost:8081/managerblog/web/index.html?caid=6');
INSERT INTO `blog_category` VALUES ('7', 'php', '分类里面的类目', '3', '2', 'http://localhost:8081/managerblog/web/index.html?caid=7');
INSERT INTO `blog_category` VALUES ('8', '无导航', '博客排版的内容', '4', '1', 'http://localhost:8081/managerblog/web/index.html');
INSERT INTO `blog_category` VALUES ('9', '右侧导航', '右侧导航', '4', '2', 'http://localhost:8081/managerblog/web/index.html');
INSERT INTO `blog_category` VALUES ('10', '左侧导航', '左侧导航', '4', '3', 'http://localhost:8081/managerblog/web/index.html');
INSERT INTO `blog_category` VALUES ('11', '作品', '博主作品', null, '4', 'http://localhost:8081/managerblog/web/index.html');
INSERT INTO `blog_category` VALUES ('12', '联系我们', '联系方式', null, '7', 'http://localhost:8081/managerblog/web/index.html');
INSERT INTO `blog_category` VALUES ('13', '撮一顿点餐app', '作品', '11', '1', 'http://localhost:8081/managerblog/web/index.html');

-- ----------------------------
-- Table structure for `blog_cmtreply`
-- ----------------------------
DROP TABLE IF EXISTS `blog_cmtreply`;
CREATE TABLE `blog_cmtreply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commentid` int(11) NOT NULL,
  `repalyid` int(11) DEFAULT NULL,
  `content` text NOT NULL,
  `fromuserid` int(11) NOT NULL,
  `touserid` int(11) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_replay` (`repalyid`),
  KEY `fk_commentid` (`commentid`),
  KEY `fk_fromuserid` (`fromuserid`),
  KEY `fk_touser` (`touserid`),
  CONSTRAINT `fk_commentid` FOREIGN KEY (`commentid`) REFERENCES `blog_comment` (`id`),
  CONSTRAINT `fk_fromuserid` FOREIGN KEY (`fromuserid`) REFERENCES `blog_user` (`id`),
  CONSTRAINT `fk_touser` FOREIGN KEY (`touserid`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_cmtreply
-- ----------------------------
INSERT INTO `blog_cmtreply` VALUES ('1', '18', null, '水电费收费', '2', '16', '2018-02-19 15:38:37');

-- ----------------------------
-- Table structure for `blog_comment`
-- ----------------------------
DROP TABLE IF EXISTS `blog_comment`;
CREATE TABLE `blog_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `articleid` varchar(16) NOT NULL,
  `userid` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `status` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_articleid` (`articleid`),
  KEY `fk_ommtentid` (`userid`),
  CONSTRAINT `fk_articleid` FOREIGN KEY (`articleid`) REFERENCES `blog_article` (`id`),
  CONSTRAINT `fk_ommtentid` FOREIGN KEY (`userid`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_comment
-- ----------------------------
INSERT INTO `blog_comment` VALUES ('11', '写的很好', '201711201537140', '4', '2017-11-21 19:09:30', '1');
INSERT INTO `blog_comment` VALUES ('12', '234', '201711201537140', '5', '2017-11-21 19:30:46', '1');
INSERT INTO `blog_comment` VALUES ('13', '写的很好呀！', '201711201537140', '6', '2017-11-21 19:37:37', '1');
INSERT INTO `blog_comment` VALUES ('14', '', '201711201537140', '7', '2017-11-21 20:07:09', '1');
INSERT INTO `blog_comment` VALUES ('15', '', '201711201537140', '10', '2017-11-21 20:15:21', '1');
INSERT INTO `blog_comment` VALUES ('16', '', '201711201537140', '11', '2017-11-21 20:15:29', '1');
INSERT INTO `blog_comment` VALUES ('17', '23\r\n4', '201711201537140', '12', '2017-11-21 20:15:37', '1');
INSERT INTO `blog_comment` VALUES ('18', '写的很好', '201802191535430', '16', '2018-02-19 15:38:15', '0');

-- ----------------------------
-- Table structure for `blog_images`
-- ----------------------------
DROP TABLE IF EXISTS `blog_images`;
CREATE TABLE `blog_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  `title` varchar(55) NOT NULL,
  `descz` text NOT NULL,
  `src` text NOT NULL,
  `uploadtime` datetime NOT NULL,
  `arid` varchar(16) DEFAULT NULL,
  `indexpic` varchar(55) DEFAULT NULL,
  `gallery` varchar(55) DEFAULT NULL,
  `updown` char(1) DEFAULT NULL,
  `isrecommend` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_arimages` (`arid`),
  CONSTRAINT `fk_arimages` FOREIGN KEY (`arid`) REFERENCES `blog_article` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_images
-- ----------------------------
INSERT INTO `blog_images` VALUES ('69', '33626892-1d6c-4f23-ae00-047268bb9130.jpg', '海景', '海景', 'http://localhost:8080/blog/gallery/33626892-1d6c-4f23-ae00-047268bb9130.jpg', '2017-11-11 19:15:59', null, null, '1', '1', '1');
INSERT INTO `blog_images` VALUES ('70', '62dcf875-9a1e-4c60-87b8-e66aff1ba32b.jpg', '海景', '海景', 'http://localhost:8080/blog/gallery/62dcf875-9a1e-4c60-87b8-e66aff1ba32b.jpg', '2017-11-11 19:15:59', null, null, '1', '1', '0');
INSERT INTO `blog_images` VALUES ('71', '7a46a083-d534-410c-bddc-9abf12d647fa.jpg', '海景', '海景', 'http://localhost:8080/blog/gallery/7a46a083-d534-410c-bddc-9abf12d647fa.jpg', '2017-11-13 14:38:28', null, null, '1', '0', '0');
INSERT INTO `blog_images` VALUES ('72', 'f4a90c93-7c98-44aa-8e52-a63cb5224d26.jpg', '海景', '海景', 'http://localhost:8080/blog/gallery/f4a90c93-7c98-44aa-8e52-a63cb5224d26.jpg', '2017-11-11 19:15:59', null, null, '1', '1', '0');
INSERT INTO `blog_images` VALUES ('73', 'dcf4eab8-2c64-47e9-b3ed-c55e7572ed8d.jpg', '海景', '海景', 'http://localhost:8080/blog/gallery/dcf4eab8-2c64-47e9-b3ed-c55e7572ed8d.jpg', '2017-11-13 14:36:57', null, null, '1', '1', '1');
INSERT INTO `blog_images` VALUES ('84', '747d058f-8f57-4db8-87d9-83bb0f0bfd86.jpg', 'Spring Boot应用部署到Tomcat中无法启动问题', 'Spring Boot应用部署到Tomcat中无法启动问题', 'http://localhost:8080/blog/arimages/747d058f-8f57-4db8-87d9-83bb0f0bfd86.jpg', '2017-11-20 15:37:14', '201711201537140', null, null, null, null);

-- ----------------------------
-- Table structure for `blog_manager`
-- ----------------------------
DROP TABLE IF EXISTS `blog_manager`;
CREATE TABLE `blog_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `pwd` varchar(10) NOT NULL,
  `status` char(1) NOT NULL,
  `lastlogin` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_manager
-- ----------------------------
INSERT INTO `blog_manager` VALUES ('1', '1', '1', '1', '2017-10-25 00:21:23');
INSERT INTO `blog_manager` VALUES ('2', '上官名鹏', '123456', '1', '2017-11-11 19:40:50');
INSERT INTO `blog_manager` VALUES ('3', 'root', '123456', '1', '2017-11-11 19:41:29');
INSERT INTO `blog_manager` VALUES ('4', '2', '2', '1', '2017-11-12 18:06:45');

-- ----------------------------
-- Table structure for `blog_message`
-- ----------------------------
DROP TABLE IF EXISTS `blog_message`;
CREATE TABLE `blog_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `userid` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `status` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userid_meg` (`userid`),
  CONSTRAINT `fk_userid_meg` FOREIGN KEY (`userid`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_message
-- ----------------------------
INSERT INTO `blog_message` VALUES ('20', '567', '2', '2017-11-20 21:09:44', '1');
INSERT INTO `blog_message` VALUES ('21', '567多少', '2', '2017-11-20 21:38:13', '0');
INSERT INTO `blog_message` VALUES ('22', '567多少啥地方', '2', '2017-11-20 21:38:15', '1');
INSERT INTO `blog_message` VALUES ('23', '567多少啥地方', '2', '2017-11-20 21:38:15', '1');
INSERT INTO `blog_message` VALUES ('24', 'sdsdf', '2', '2017-11-20 23:35:03', '0');
INSERT INTO `blog_message` VALUES ('25', 'iuui', '13', '2017-11-22 11:29:49', '1');
INSERT INTO `blog_message` VALUES ('26', 'iuui', '14', '2017-11-22 11:30:39', '1');
INSERT INTO `blog_message` VALUES ('27', '艾斯德斯', '15', '2017-11-22 11:40:24', '0');

-- ----------------------------
-- Table structure for `blog_msgreply`
-- ----------------------------
DROP TABLE IF EXISTS `blog_msgreply`;
CREATE TABLE `blog_msgreply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `messageid` int(11) NOT NULL,
  `replyid` int(11) DEFAULT NULL,
  `content` text NOT NULL,
  `fromuserid` int(11) NOT NULL,
  `touserid` int(11) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_msg_msgid` (`messageid`),
  KEY `fk_msg_fromuserid` (`fromuserid`),
  KEY `fk_msg_touserid` (`touserid`),
  CONSTRAINT `fk_msg_fromuserid` FOREIGN KEY (`fromuserid`) REFERENCES `blog_user` (`id`),
  CONSTRAINT `fk_msg_msgid` FOREIGN KEY (`messageid`) REFERENCES `blog_message` (`id`),
  CONSTRAINT `fk_msg_touserid` FOREIGN KEY (`touserid`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_msgreply
-- ----------------------------
INSERT INTO `blog_msgreply` VALUES ('2', '20', null, '放到', '2', '2', '2017-11-20 21:12:09');
INSERT INTO `blog_msgreply` VALUES ('3', '20', null, '放到', '2', '2', '2017-11-20 21:22:58');
INSERT INTO `blog_msgreply` VALUES ('4', '23', null, '1221', '2', '2', '2017-11-20 22:32:14');
INSERT INTO `blog_msgreply` VALUES ('5', '22', null, 'sdf', '2', '2', '2017-11-20 22:45:56');
INSERT INTO `blog_msgreply` VALUES ('6', '22', null, 'sdf sd', '2', '2', '2017-11-20 22:46:02');
INSERT INTO `blog_msgreply` VALUES ('7', '21', null, 'dfg', '2', '2', '2017-11-20 22:46:09');
INSERT INTO `blog_msgreply` VALUES ('8', '23', null, 'df', '2', '2', '2017-11-20 23:33:08');
INSERT INTO `blog_msgreply` VALUES ('9', '20', null, 'sdf', '2', '2', '2017-11-20 23:33:16');
INSERT INTO `blog_msgreply` VALUES ('10', '23', null, 'fd', '2', '2', '2017-11-20 23:33:33');
INSERT INTO `blog_msgreply` VALUES ('11', '21', null, 'df', '2', '2', '2017-11-20 23:34:24');
INSERT INTO `blog_msgreply` VALUES ('12', '24', null, 'df', '2', '2', '2017-11-20 23:35:11');
INSERT INTO `blog_msgreply` VALUES ('13', '27', null, 'sads', '2', '2', '2018-02-10 17:05:39');

-- ----------------------------
-- Table structure for `blog_tag`
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `time` datetime NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
INSERT INTO `blog_tag` VALUES ('34', 'springboot', '2017-11-20 15:37:14', '1');
INSERT INTO `blog_tag` VALUES ('35', 'tomcat', '2017-11-20 15:37:14', '1');
INSERT INTO `blog_tag` VALUES ('36', '啥地方', '2017-11-21 13:26:25', '1');
INSERT INTO `blog_tag` VALUES ('37', '', '2018-02-10 14:12:42', '1');
INSERT INTO `blog_tag` VALUES ('38', '是的发送到', '2018-02-19 15:35:43', '1');

-- ----------------------------
-- Table structure for `blog_tagmap`
-- ----------------------------
DROP TABLE IF EXISTS `blog_tagmap`;
CREATE TABLE `blog_tagmap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `arid` varchar(16) NOT NULL,
  `taid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_tagmap
-- ----------------------------
INSERT INTO `blog_tagmap` VALUES ('25', '201711201537140', '34');
INSERT INTO `blog_tagmap` VALUES ('26', '201711201537140', '35');
INSERT INTO `blog_tagmap` VALUES ('27', '201711211326140', '36');
INSERT INTO `blog_tagmap` VALUES ('28', '201802101412420', '37');
INSERT INTO `blog_tagmap` VALUES ('29', '201802191535430', '38');

-- ----------------------------
-- Table structure for `blog_user`
-- ----------------------------
DROP TABLE IF EXISTS `blog_user`;
CREATE TABLE `blog_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `pwd` varchar(15) DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `status` char(1) NOT NULL,
  `tel` varchar(11) DEFAULT NULL,
  `mailbox` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_user
-- ----------------------------
INSERT INTO `blog_user` VALUES ('2', '14796635306', '123', '2017-10-23 20:07:29', 'http://119.23.227.187/234lkjlk.jpg', '1', '14796635306', '1368309276@qq.com');
INSERT INTO `blog_user` VALUES ('4', '哈啊', null, '2017-11-21 19:09:28', null, '1', null, '1368309276@qq.om');
INSERT INTO `blog_user` VALUES ('5', '3422342423', null, '2017-11-21 19:30:46', null, '1', null, '23424');
INSERT INTO `blog_user` VALUES ('6', '小王', null, '2017-11-21 19:37:34', null, '1', null, '1368309276@qq.om');
INSERT INTO `blog_user` VALUES ('7', '小王', null, '2017-11-21 20:07:09', null, '1', null, '1368309276@qq.om');
INSERT INTO `blog_user` VALUES ('8', '小王', null, '2017-11-21 20:12:58', null, '1', null, '1368309276@qq.om');
INSERT INTO `blog_user` VALUES ('9', '小王', null, '2017-11-21 20:14:40', null, '1', null, '1368309276@qq.om');
INSERT INTO `blog_user` VALUES ('10', '小王', null, '2017-11-21 20:15:21', null, '1', null, '1368309276@qq.om');
INSERT INTO `blog_user` VALUES ('11', '小王', null, '2017-11-21 20:15:29', null, '1', null, '1368309276@qq.om');
INSERT INTO `blog_user` VALUES ('12', '小王', null, '2017-11-21 20:15:37', null, '1', null, '1368309276@qq.om');
INSERT INTO `blog_user` VALUES ('13', '877887', null, '2017-11-22 11:29:49', null, '1', null, '');
INSERT INTO `blog_user` VALUES ('14', '877887', null, '2017-11-22 11:30:39', null, '1', null, '');
INSERT INTO `blog_user` VALUES ('15', 'sdfdsf', null, '2017-11-22 11:40:24', null, '1', null, '456456@qq.com');
INSERT INTO `blog_user` VALUES ('16', '上官名鹏', null, '2018-02-19 15:38:15', null, '1', null, '1368309276@qq.om');

-- ----------------------------
-- Table structure for `blog_zan`
-- ----------------------------
DROP TABLE IF EXISTS `blog_zan`;
CREATE TABLE `blog_zan` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `articleid` varchar(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `status` char(1) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_article_zan` (`articleid`),
  KEY `fk__userid_zan` (`userid`),
  CONSTRAINT `fk_article_zan` FOREIGN KEY (`articleid`) REFERENCES `blog_article` (`id`),
  CONSTRAINT `fk__userid_zan` FOREIGN KEY (`userid`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_zan
-- ----------------------------
