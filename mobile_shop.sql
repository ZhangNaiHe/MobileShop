/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : mobile_shop

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 02/03/2020 14:20:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '地址id',
  `user_id` int(11) NOT NULL COMMENT '对应的用户id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收件人',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '省份',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `county` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区县',
  `tel` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号码',
  `postalCode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮编',
  `addressDetail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '详细地址',
  `isDefault` tinyint(3) NOT NULL COMMENT '是否默认 0 不默认 1 默认',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (13, 1, '刘某', '北京市', '北京市', '东城区', '13938968879', '411585', '399号', 0);
INSERT INTO `address` VALUES (14, 1, '三炮', '天津市', '天津市', '和平区', '18896962558', '411373', '3585号', 0);
INSERT INTO `address` VALUES (15, 1, '泽三炮', '天津市', '天津市', '和平区', '18896962558', '411596', '38号区', 0);
INSERT INTO `address` VALUES (16, 1, 'dsad', '天津市', '天津市', '河东区', '16696932586', '596838', '166hao', 0);
INSERT INTO `address` VALUES (17, 1, '笑笑', '江苏省', '南京市', '玄武区', '18728321232', '112233', '江苏', 0);
INSERT INTO `address` VALUES (18, 15, 'liuliu', '北京市', '北京市', '东城区', '13372366779', '666946', '333hao', 1);
INSERT INTO `address` VALUES (19, 6, '刘诗诗', '北京市', '北京市', '东城区', '13352527796', '333666', '188hao', 1);
INSERT INTO `address` VALUES (20, 1, '张三', '江苏省', '宿迁市', '沭阳县', '13271366779', '223800', '常州西路，经贸学院...', 0);
INSERT INTO `address` VALUES (21, 7, '十三幺', '北京市', '北京市', '东城区', '15893580580', '411303', '北京大街188号', 1);
INSERT INTO `address` VALUES (22, 1, '中暑', '上海市', '上海市', '虹口区', '18707055159', '112233', '领导反馈给', 0);
INSERT INTO `address` VALUES (23, 1, '王小明', '黑龙江省', '哈尔滨市', '南岗区', '13598761029', '331100', '48栋203室', 0);
INSERT INTO `address` VALUES (24, 11, '马大哈', '北京市', '北京市', '东城区', '13344445555', '552299', '北京路32栋302室', 1);
INSERT INTO `address` VALUES (25, 11, '西西', '天津市', '天津市', '和平区', '13344445555', '223311', '和歌路23号', 1);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理员名称',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理员密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '123456');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `goods_id` int(10) UNSIGNED NOT NULL COMMENT '商品id',
  `ischk` tinyint(11) NOT NULL COMMENT '是否选中 false未选中 true选中',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '购物车的用户id',
  `standards` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购买的商品规格',
  `count` int(11) NOT NULL COMMENT '购买的商品数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (22, 12, 0, 4, '常规', 3);
INSERT INTO `cart` VALUES (23, 3, 0, 2, '常规', 3);
INSERT INTO `cart` VALUES (71, 6, 1, 7, '常规', 1);
INSERT INTO `cart` VALUES (72, 3, 1, 7, '常规', 1);
INSERT INTO `cart` VALUES (82, 1, 0, 1, '常规', 2);
INSERT INTO `cart` VALUES (83, 9, 0, 1, '常规', 4);
INSERT INTO `cart` VALUES (84, 5, 0, 1, '常规', 3);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `goods_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名',
  `property` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品拥有的属性',
  `price` decimal(10, 2) NOT NULL COMMENT '商品价格',
  `time` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品上架时间',
  `classify_id` int(10) NOT NULL COMMENT '商品分类id',
  `total_sale` int(10) NOT NULL COMMENT '商品销量',
  `inventory` tinyint(4) NOT NULL COMMENT '商品库存',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 'BLD贝览得一次性洗脸巾 棉柔巾 抽取式100片三盒装', '', 69.00, '2019-11-18', 1, 22, 18);
INSERT INTO `goods` VALUES (2, '兰芝夜间保湿修护唇膜（莓果味） (补水保湿 去角质护肤品)', NULL, 112.00, '2019-10-10', 1, 95, 94);
INSERT INTO `goods` VALUES (3, 'moloke真无线Air 蓝牙耳机双耳3 pro运动入耳式', NULL, 169.00, '2019-08-20', 2, 13, 30);
INSERT INTO `goods` VALUES (4, 'iPhone 11 (A2223) 128GB 双卡双待', NULL, 5999.00, '2019-03-11', 2, 35, 99);
INSERT INTO `goods` VALUES (5, '含冰2kg70-90只新鲜活冻南美对虾非基围虾', NULL, 93.00, '2019-01-01', 3, 5, 9);
INSERT INTO `goods` VALUES (6, '烧范儿 原肉整切静腌西冷牛排5片装', NULL, 100.00, '2019-03-01', 3, 32, 111);
INSERT INTO `goods` VALUES (7, '女士时尚潮流红黑格子条纹大衬衫学生宽松休闲上衣', NULL, 233.00, '2019-11-11', 4, 5, 96);
INSERT INTO `goods` VALUES (8, '可爱毛绒 睡衣连体衣 休闲服', NULL, 111.00, '2019-05-05', 4, 22, 39);
INSERT INTO `goods` VALUES (9, '灌篮高手球衣', NULL, 59.00, '2019-01-01', 4, 3, 11);
INSERT INTO `goods` VALUES (10, '三只松鼠坚果大礼包9袋 网红零食每日坚果', NULL, 129.00, '2019-09-09', 5, 12, 23);
INSERT INTO `goods` VALUES (11, '法国原瓶进口红酒 曼妥思黑宝塔干红葡萄酒', NULL, 268.00, '2019-10-10', 6, 24, 120);
INSERT INTO `goods` VALUES (12, '笔记本 布面精装 空白记事日记速写本手账 读库', NULL, 23.00, '2019-10-10', 7, 35, 21);
INSERT INTO `goods` VALUES (13, '宫西达也 恐龙套装简装7册  蒲蒲兰绘本', NULL, 69.00, '2019-01-01', 7, 11, 99);
INSERT INTO `goods` VALUES (14, 'Dickies女鞋低帮帆布鞋 情侣款 春季新款休闲板鞋布鞋', NULL, 255.00, '2019-01-01', 8, 20, 50);
INSERT INTO `goods` VALUES (15, '新款休闲鞋女士时尚休闲高帮帆布鞋女潮流学生百搭女鞋', NULL, 199.00, '2019-01-01', 8, 9, 120);
INSERT INTO `goods` VALUES (16, '官方正品耐克Nike篮球鞋舒适减震Kyrie 5 欧文5', NULL, 1099.00, '1574527826', 8, 0, 20);

-- ----------------------------
-- Table structure for goods_attribute
-- ----------------------------
DROP TABLE IF EXISTS `goods_attribute`;
CREATE TABLE `goods_attribute`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '属性值id',
  `goods_id` int(11) NOT NULL COMMENT '对应商品id',
  `property_id` int(11) NOT NULL COMMENT '对应属性id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '属性值名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for goods_classify
-- ----------------------------
DROP TABLE IF EXISTS `goods_classify`;
CREATE TABLE `goods_classify`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_classify
-- ----------------------------
INSERT INTO `goods_classify` VALUES (1, '美妆');
INSERT INTO `goods_classify` VALUES (2, '数码电器');
INSERT INTO `goods_classify` VALUES (3, '生鲜直购');
INSERT INTO `goods_classify` VALUES (4, '男女服饰');
INSERT INTO `goods_classify` VALUES (5, '零食小吃');
INSERT INTO `goods_classify` VALUES (6, '中外名酒');
INSERT INTO `goods_classify` VALUES (7, '图书音相');
INSERT INTO `goods_classify` VALUES (8, '潮鞋馆');

-- ----------------------------
-- Table structure for goods_desc_img
-- ----------------------------
DROP TABLE IF EXISTS `goods_desc_img`;
CREATE TABLE `goods_desc_img`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品描述图片id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品描述图片路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 170 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_desc_img
-- ----------------------------
INSERT INTO `goods_desc_img` VALUES (1, 1, 'https://img30.360buyimg.com/sku/jfs/t1/96610/5/8428/643354/5e04637bE0d21514f/8a35f046bc5c8777.jpg');
INSERT INTO `goods_desc_img` VALUES (2, 1, 'https://img30.360buyimg.com/sku/jfs/t1/98302/5/8280/466568/5e04637bE165755a8/6613d682678db232.jpg');
INSERT INTO `goods_desc_img` VALUES (3, 1, 'https://img30.360buyimg.com/sku/jfs/t1/103478/25/8418/603240/5e04637bE97d6deb7/7e61b1c315fbfa65.jpg');
INSERT INTO `goods_desc_img` VALUES (4, 1, 'https://img30.360buyimg.com/sku/jfs/t1/85020/32/8405/566571/5e04637bEeed0951c/8024f6772efe8c14.jpg');
INSERT INTO `goods_desc_img` VALUES (5, 1, 'https://img30.360buyimg.com/sku/jfs/t1/90071/21/8402/651836/5e04637bE5f02a973/1b95b0cab4f19a3f.jpg');
INSERT INTO `goods_desc_img` VALUES (6, 1, 'https://img30.360buyimg.com/sku/jfs/t1/90706/29/8381/605096/5e04637bE10c07c46/a3e24a00b28fadbb.jpg');
INSERT INTO `goods_desc_img` VALUES (7, 1, 'https://img30.360buyimg.com/sku/jfs/t1/88727/24/8436/454287/5e04637bE1ab30429/009b04a7e850ef02.jpg');
INSERT INTO `goods_desc_img` VALUES (8, 1, 'https://img30.360buyimg.com/sku/jfs/t1/89360/12/8425/560236/5e04637bEa840387a/eab6b0240a8de5bd.jpg');
INSERT INTO `goods_desc_img` VALUES (9, 1, 'https://img30.360buyimg.com/sku/jfs/t1/98105/20/8396/393333/5e04637bE2fc49a20/fa05e5dcda94269f.jpg');
INSERT INTO `goods_desc_img` VALUES (10, 1, 'https://img30.360buyimg.com/sku/jfs/t1/101446/20/8421/497744/5e04637bE16187297/f6ad9841bc8f7e73.jpg');
INSERT INTO `goods_desc_img` VALUES (11, 1, 'https://img30.360buyimg.com/sku/jfs/t1/89502/17/8499/454370/5e04637bE5dd53a75/f6d65a4bd4723a26.jpg');
INSERT INTO `goods_desc_img` VALUES (13, 2, 'https://img30.360buyimg.com/sku/jfs/t1/76393/39/8023/307050/5d5dfdb1Ebec145fa/65a4b23966e90175.jpg');
INSERT INTO `goods_desc_img` VALUES (14, 2, 'https://img30.360buyimg.com/sku/jfs/t1/82488/20/8024/132692/5d5dfdb1E826e2340/4d47a84d8bfee703.jpg');
INSERT INTO `goods_desc_img` VALUES (15, 2, 'https://img30.360buyimg.com/sku/jfs/t1/83409/24/7958/267676/5d5dfdb1Eaa4b98a5/f5bf576aa166447d.jpg');
INSERT INTO `goods_desc_img` VALUES (16, 2, 'https://img30.360buyimg.com/sku/jfs/t1/63535/35/8069/208215/5d5dfdb1E10b82545/76836fad38428a82.jpg');
INSERT INTO `goods_desc_img` VALUES (17, 2, 'https://img30.360buyimg.com/sku/jfs/t1/63535/35/8069/208215/5d5dfdb1E10b82545/76836fad38428a82.jpg');
INSERT INTO `goods_desc_img` VALUES (18, 2, 'https://img30.360buyimg.com/sku/jfs/t1/65117/10/7778/171218/5d5dfdb1E667595c1/7e4074be5b15072a.jpg');
INSERT INTO `goods_desc_img` VALUES (19, 2, 'https://img30.360buyimg.com/sku/jfs/t1/81570/32/7383/242331/5d5621e1E1585ec3c/2979a514216a5012.jpg');
INSERT INTO `goods_desc_img` VALUES (20, 2, 'https://img30.360buyimg.com/sku/jfs/t1/43477/14/11436/287028/5d4d0a23Edd9183ea/9c682ad24cedfc55.jpg');
INSERT INTO `goods_desc_img` VALUES (21, 3, 'https://img13.360buyimg.com/cms/jfs/t1/90813/21/10608/255074/5e1d2b91Ecf20b19c/7b4ed77705ad76a6.jpg');
INSERT INTO `goods_desc_img` VALUES (22, 3, 'https://img11.360buyimg.com/cms/jfs/t1/101917/9/10483/253660/5e1b052aE0ab66ef5/bb3bf2eba5cf7a57.jpg');
INSERT INTO `goods_desc_img` VALUES (23, 3, 'https://img13.360buyimg.com/cms/jfs/t1/107545/3/4275/372931/5e1b052bE08fa53be/010f41c79b9e048a.jpg');
INSERT INTO `goods_desc_img` VALUES (24, 3, 'https://img12.360buyimg.com/cms/jfs/t1/100526/29/10480/91805/5e1b052bEfae1e1b5/379c549c0bcc8de3.jpg');
INSERT INTO `goods_desc_img` VALUES (25, 3, 'https://img12.360buyimg.com/cms/jfs/t1/91491/2/10378/471992/5e1b052bEa02297ce/7ad26206f71aab27.jpg');
INSERT INTO `goods_desc_img` VALUES (26, 3, 'https://img11.360buyimg.com/cms/jfs/t1/89217/22/10396/146312/5e1b052bE6c78bb2c/3b509a5a6f06b012.jpg');
INSERT INTO `goods_desc_img` VALUES (27, 3, 'https://img13.360buyimg.com/cms/jfs/t1/105636/9/10545/72206/5e1b052cE5044a74b/c78725a1e213f441.jpg');
INSERT INTO `goods_desc_img` VALUES (28, 3, 'https://img12.360buyimg.com/cms/jfs/t1/110132/35/4315/217940/5e1b052bEe0821eff/2f84379dc71252b8.jpg');
INSERT INTO `goods_desc_img` VALUES (29, 3, 'https://img11.360buyimg.com/cms/jfs/t1/93082/3/10532/149869/5e1b052cEc90b38d2/601b55c5883f62cc.jpg');
INSERT INTO `goods_desc_img` VALUES (30, 3, 'https://img14.360buyimg.com/cms/jfs/t1/93341/9/5811/35091/5defc36dEc427355d/e72e1201132b145b.jpg');
INSERT INTO `goods_desc_img` VALUES (31, 4, 'https://img13.360buyimg.com/cms/jfs/t1/52388/18/10385/1411768/5d77f9b4E2d7878f2/e7c050794c278d17.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (32, 4, 'https://img12.360buyimg.com/cms/jfs/t1/40404/18/10660/539422/5d7b1c64Ed482a344/c7a223e22eaf0571.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (42, 5, 'https://img14.360buyimg.com/imgzone/jfs/t1/64747/10/14214/242566/5dbaa648Ecb8036b8/e6713997921aec59.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (43, 5, 'https://img30.360buyimg.com/imgzone/jfs/t1/63147/19/14262/371533/5dbaa648Effd73868/f657479d855b6f2a.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (44, 5, 'https://img10.360buyimg.com/imgzone/jfs/t1/106793/13/1170/136091/5dbaa647E79f97f49/ecf902b726b0e19a.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (45, 5, 'https://img13.360buyimg.com/imgzone/jfs/t1/53911/16/14842/49307/5dbaa648E0eb6d3c2/1615ad1015409de0.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (46, 5, 'https://img30.360buyimg.com/popWaterMark/jfs/t1/99733/17/6873/123567/5df70c14Eda859a58/f872702a4e2b8bb7.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (47, 5, 'https://img14.360buyimg.com/imgzone/jfs/t1/87155/28/1179/307636/5dbaa648E795160e1/66aa791bb83eee45.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (48, 6, 'https://img30.360buyimg.com/sku/jfs/t1/54429/11/9528/680660/5d6dd8eeE74291b58/42a39e9f6e016168.jpg');
INSERT INTO `goods_desc_img` VALUES (49, 6, 'https://img30.360buyimg.com/sku/jfs/t1/59588/26/4876/376228/5d315d44E7aac8174/3d8db7d3a4e30139.jpg');
INSERT INTO `goods_desc_img` VALUES (50, 6, 'https://img30.360buyimg.com/sku/jfs/t1/53031/29/4839/510729/5d2833e8E88ef2b5b/b005d7ad88c6d9e3.jpg');
INSERT INTO `goods_desc_img` VALUES (51, 6, 'https://img30.360buyimg.com/sku/jfs/t1/49949/31/9581/86998/5d6ddecbE205ac0b8/bfc7098a97ad7a6b.jpg');
INSERT INTO `goods_desc_img` VALUES (52, 6, 'https://img30.360buyimg.com/sku/jfs/t1/51164/7/4817/754511/5d2833e9Ef351ce74/573fe5bcce4ef5ff.jpg');
INSERT INTO `goods_desc_img` VALUES (53, 6, 'https://img30.360buyimg.com/sku/jfs/t1/52965/23/4840/741218/5d2833e9E2dc1ec0c/c575121edf764a02.jpg');
INSERT INTO `goods_desc_img` VALUES (54, 6, 'https://img30.360buyimg.com/sku/jfs/t1/62358/36/4480/1002970/5d2833e9Ef48088ab/490188aaef814ebe.jpg');
INSERT INTO `goods_desc_img` VALUES (55, 6, 'https://img30.360buyimg.com/sku/jfs/t1/69668/22/4386/792612/5d284312Ee1af64f4/5cd3ec894ee11421.jpg');
INSERT INTO `goods_desc_img` VALUES (56, 6, 'https://img30.360buyimg.com/sku/jfs/t1/51624/19/4832/469277/5d2833e8E3e73718d/ec82b282fae8c2b6.jpg');
INSERT INTO `goods_desc_img` VALUES (57, 6, 'https://img30.360buyimg.com/sku/jfs/t1/78474/4/4270/236876/5d2833e6E35d66e77/117fc6ecd204dd6d.jpg');
INSERT INTO `goods_desc_img` VALUES (58, 6, 'https://img30.360buyimg.com/sku/jfs/t1/73171/36/4456/723502/5d2833e9E093aeba7/6365b4d8ea22acad.jpg');
INSERT INTO `goods_desc_img` VALUES (59, 7, 'https://img14.360buyimg.com/imgzone/jfs/t1/97716/30/8406/534948/5e0488f0Eed30242e/3db75e90de09e243.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (60, 7, 'https://img12.360buyimg.com/imgzone/jfs/t1/87629/27/8394/453540/5e0488f1E3bdbbf12/3b72d8f1a8ff9dbe.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (61, 7, 'https://img30.360buyimg.com/imgzone/jfs/t1/109678/17/2257/44860/5e0488f1E071c87f1/55b231d2d4e64b4f.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (62, 7, 'https://img14.360buyimg.com/imgzone/jfs/t1/89692/36/8408/122532/5e0488f1E8cbabcce/93221ec7ffe03db9.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (63, 7, 'https://img10.360buyimg.com/imgzone/jfs/t1/109502/21/2189/594215/5e0488f1E7cc2e033/13c55a55f88f199c.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (64, 7, 'https://img12.360buyimg.com/imgzone/jfs/t1/98751/33/8272/481275/5e0488f2Ed2605567/0c918c571b8eda53.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (65, 7, 'https://img13.360buyimg.com/imgzone/jfs/t1/85932/24/8406/611764/5e0488f4E0ea7d075/82540ef509d2bdeb.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (66, 7, 'https://img30.360buyimg.com/imgzone/jfs/t1/95579/10/8513/536997/5e0488f5Ecab7f1c4/46cedc5a1f226489.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (67, 7, 'https://img30.360buyimg.com/imgzone/jfs/t1/102314/2/8437/609411/5e0488f7Eaa9fdbc3/4bdbbdd23d55332e.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (68, 7, 'https://img20.360buyimg.com/imgzone/jfs/t1/103899/26/8460/532145/5e0488f7E48eb9ef4/af035d99e7a018b4.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (69, 7, 'https://img13.360buyimg.com/imgzone/jfs/t1/99187/35/8485/610671/5e0488f9E19960e44/1b168e8e2fe0690c.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (70, 7, 'https://img13.360buyimg.com/imgzone/jfs/t1/95638/1/8469/550391/5e0488fbEf4b9e7a6/0e0af5e9280ded9c.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (71, 7, 'https://img12.360buyimg.com/imgzone/jfs/t1/103150/18/8373/129039/5e0488fcE8df25e81/b82f7e585c3b943b.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (72, 7, 'https://img12.360buyimg.com/imgzone/jfs/t1/103738/15/8460/99566/5e0488fcE2a709f41/5b9ff5e2d698f747.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (73, 7, 'https://img12.360buyimg.com/imgzone/jfs/t1/86933/20/8404/86948/5e0488fcEece5aeab/772308e5a18fe415.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (74, 7, 'https://img30.360buyimg.com/imgzone/jfs/t1/86256/28/8370/357174/5e0488fdE930ed3b2/4fdb8d6a9be79719.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (75, 7, 'https://img13.360buyimg.com/imgzone/jfs/t1/100723/20/8339/392577/5e0488fdEb0152c5c/37082dc8f39e7297.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (76, 8, 'http://shp.qpic.cn/mall/0/goods_lol_201808142146_38532/0.jpg');
INSERT INTO `goods_desc_img` VALUES (77, 8, 'http://shp.qpic.cn/mall/0/goods_lol_201808142146_48757/0.jpg');
INSERT INTO `goods_desc_img` VALUES (78, 8, 'http://shp.qpic.cn/mall/0/goods_lol_201808142146_13555/0.jpg');
INSERT INTO `goods_desc_img` VALUES (79, 8, 'http://shp.qpic.cn/mall/0/goods_lol_201808142148_40192/0.jpg');
INSERT INTO `goods_desc_img` VALUES (80, 8, 'http://shp.qpic.cn/mall/0/goods_lol_201808142148_48711/0.jpg');
INSERT INTO `goods_desc_img` VALUES (81, 8, 'http://shp.qpic.cn/mall/0/goods_lol_201808142149_13441/0.jpg');
INSERT INTO `goods_desc_img` VALUES (82, 8, 'http://shp.qpic.cn/mall/0/goods_lol_201808142149_33390/0.jpg');
INSERT INTO `goods_desc_img` VALUES (83, 8, 'http://shp.qpic.cn/mall/0/goods_lol_201808142150_13227/0.jpg');
INSERT INTO `goods_desc_img` VALUES (84, 8, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201905183730_50400/0.jpg');
INSERT INTO `goods_desc_img` VALUES (85, 9, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184932_51894.jpg');
INSERT INTO `goods_desc_img` VALUES (86, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184705_12697/0.jpg');
INSERT INTO `goods_desc_img` VALUES (87, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184705_69963/0.jpg');
INSERT INTO `goods_desc_img` VALUES (88, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184706_12743/0.jpg');
INSERT INTO `goods_desc_img` VALUES (89, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184707_13567/0.jpg');
INSERT INTO `goods_desc_img` VALUES (90, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184707_87527/0.jpg');
INSERT INTO `goods_desc_img` VALUES (91, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184708_11788/0.jpg');
INSERT INTO `goods_desc_img` VALUES (92, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184709_75798/0.jpg');
INSERT INTO `goods_desc_img` VALUES (93, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184709_40073/0.jpg');
INSERT INTO `goods_desc_img` VALUES (94, 9, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201906184710_12863/0.jpg');
INSERT INTO `goods_desc_img` VALUES (95, 10, 'https://img30.360buyimg.com/sku/jfs/t1/97519/22/7911/243697/5e002d1bE46cdea21/9dcc42c9f82463ba.jpg');
INSERT INTO `goods_desc_img` VALUES (96, 10, 'https://img30.360buyimg.com/sku/jfs/t1/101062/38/8255/272347/5e031c8bE2a948cc5/9e28df742a480812.jpg');
INSERT INTO `goods_desc_img` VALUES (97, 10, 'https://img30.360buyimg.com/sku/jfs/t1/101204/29/7997/292280/5e002d1bE165f8a2c/95f16ec2e6d553e2.jpg');
INSERT INTO `goods_desc_img` VALUES (98, 10, 'https://img30.360buyimg.com/sku/jfs/t1/93310/2/7840/292123/5e002d1bE638aace6/a2923f93510682fb.jpg');
INSERT INTO `goods_desc_img` VALUES (99, 10, 'https://img30.360buyimg.com/sku/jfs/t1/98374/17/7872/288474/5e002d1bE49951352/29c7c78b273a78bb.jpg');
INSERT INTO `goods_desc_img` VALUES (100, 10, 'https://img30.360buyimg.com/sku/jfs/t1/107676/32/1735/293721/5e002d1bE3a2a5047/97e5932fa05c3156.jpg');
INSERT INTO `goods_desc_img` VALUES (101, 10, 'https://img30.360buyimg.com/sku/jfs/t1/91194/5/7832/293945/5e002d1bE1f8aaa51/a386edbeec88d2ed.jpg');
INSERT INTO `goods_desc_img` VALUES (102, 10, 'https://img30.360buyimg.com/sku/jfs/t1/100228/7/7920/297113/5e002d1bE4b1fb40e/71855a30ab8b197c.jpg');
INSERT INTO `goods_desc_img` VALUES (103, 10, 'https://img30.360buyimg.com/sku/jfs/t1/89941/3/7954/295434/5e002d1bEe89ac3f1/a1aa41a957adeddd.jpg');
INSERT INTO `goods_desc_img` VALUES (104, 10, 'https://img30.360buyimg.com/sku/jfs/t1/109162/19/1744/294323/5e002d1bE41c56ec5/2df6a7ee2d146661.jpg');
INSERT INTO `goods_desc_img` VALUES (105, 10, 'https://img30.360buyimg.com/sku/jfs/t1/100828/38/7882/290448/5e002d1bE8153f82d/3f1dd4425c3a1abd.jpg');
INSERT INTO `goods_desc_img` VALUES (106, 10, 'https://img30.360buyimg.com/sku/jfs/t1/107387/14/1656/296475/5e002d1bEacaac7cf/aee9e9ad9997514c.jpg');
INSERT INTO `goods_desc_img` VALUES (107, 10, 'https://img30.360buyimg.com/sku/jfs/t1/90273/14/7929/283528/5e002d1bE91cc28fa/19a10c40c65df2b8.jpg');
INSERT INTO `goods_desc_img` VALUES (108, 10, 'https://img30.360buyimg.com/sku/jfs/t1/88295/33/8018/295490/5e002d1bE909039d8/cedf0c270085743b.jpg');
INSERT INTO `goods_desc_img` VALUES (115, 11, 'https://img30.360buyimg.com/sku/jfs/t1/91012/18/1572/482767/5dc0f4f0E131cc42e/7f4b811c04bf7115.jpg');
INSERT INTO `goods_desc_img` VALUES (116, 11, 'https://img30.360buyimg.com/sku/jfs/t1/70175/31/14655/447320/5dc0f4efE714f8f8e/86159ecb8b7c5aa3.jpg');
INSERT INTO `goods_desc_img` VALUES (117, 11, 'https://img30.360buyimg.com/sku/jfs/t1/60688/25/14644/500233/5dc0f4f0Eb4098ddc/30bb1f90a3994fd5.jpg');
INSERT INTO `goods_desc_img` VALUES (118, 11, 'https://img30.360buyimg.com/sku/jfs/t1/101844/31/1516/493839/5dc0f4f0Ebfdd11e0/372d846fe5c83f5f.jpg');
INSERT INTO `goods_desc_img` VALUES (119, 11, 'https://img30.360buyimg.com/sku/jfs/t1/55869/3/15252/488172/5dc0f4f0E4db01069/31fd9878c8960508.jpg');
INSERT INTO `goods_desc_img` VALUES (120, 11, 'https://img30.360buyimg.com/sku/jfs/t1/60373/11/13408/108150/5daaed49E423e668e/1d93a1d3c60c11a7.jpg');
INSERT INTO `goods_desc_img` VALUES (121, 11, 'https://img30.360buyimg.com/sku/jfs/t1/70150/36/13372/152704/5daaed49E8a5ac946/55a0f53d9111c271.jpg');
INSERT INTO `goods_desc_img` VALUES (122, 11, 'https://img30.360buyimg.com/sku/jfs/t1/70797/32/13421/153627/5daaed49E8b6b7b0c/10cb3bdf0a4887eb.jpg');
INSERT INTO `goods_desc_img` VALUES (123, 11, 'https://img30.360buyimg.com/sku/jfs/t1/83065/28/13559/151646/5daaed49E3bafd3b2/7ddaea59cb359278.jpg');
INSERT INTO `goods_desc_img` VALUES (124, 11, 'https://img30.360buyimg.com/sku/jfs/t1/77827/31/13443/172449/5daaed49E91faf81f/04dbf8788643d902.jpg');
INSERT INTO `goods_desc_img` VALUES (125, 11, 'https://img30.360buyimg.com/sku/jfs/t1/87605/32/323/380620/5daaed49Ed9f24486/667ac838f360764a.jpg');
INSERT INTO `goods_desc_img` VALUES (126, 11, 'https://img30.360buyimg.com/sku/jfs/t1/101230/1/5534/347591/5dee1648E17e30c40/19bc96391f01cc1e.jpg');
INSERT INTO `goods_desc_img` VALUES (127, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151209_28487/0.jpg');
INSERT INTO `goods_desc_img` VALUES (128, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151209_95890/0.jpg');
INSERT INTO `goods_desc_img` VALUES (129, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151209_99872/0.jpg');
INSERT INTO `goods_desc_img` VALUES (130, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151210_12551/0.jpg');
INSERT INTO `goods_desc_img` VALUES (131, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151210_13486/0.jpg');
INSERT INTO `goods_desc_img` VALUES (132, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151210_67831/0.jpg');
INSERT INTO `goods_desc_img` VALUES (133, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151214_11820/0.jpg');
INSERT INTO `goods_desc_img` VALUES (134, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151214_83048/0.jpg');
INSERT INTO `goods_desc_img` VALUES (135, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151214_13403/0.jpg');
INSERT INTO `goods_desc_img` VALUES (136, 12, 'https://shp.qpic.cn/mall/0/goods_lol_201809151215_71590/0.jpg');
INSERT INTO `goods_desc_img` VALUES (137, 12, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201904174247_11312/0.jpg');
INSERT INTO `goods_desc_img` VALUES (138, 13, 'https://img30.360buyimg.com/vc/jfs/t1/18056/9/15527/926709/5cb0537cE1e1147ad/3e526262d986e2df.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (151, 14, 'https://img30.360buyimg.com/popWaterMark/jfs/t1/89662/8/13438/311504/5e5637c8E962d90d3/d62b689dc979dfc3.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (152, 14, 'https://img30.360buyimg.com/popWaterMark/jfs/t1/68455/13/13481/91953/5dad46f8Ea64ee934/798676edd2b85dfa.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (153, 14, 'https://img14.360buyimg.com/imgzone/jfs/t1/96749/32/13281/312280/5e5637dcE25e1d6ba/f47a61c3e5670209.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (154, 14, 'https://img14.360buyimg.com/imgzone/jfs/t1/102237/6/13311/233151/5e5637dcE7135b30c/95e6293d1a123353.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (155, 14, 'https://img13.360buyimg.com/imgzone/jfs/t1/90033/40/13130/220812/5e5637ddEc2aa08cb/a77ca6d69c1465de.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (156, 14, 'https://img13.360buyimg.com/imgzone/jfs/t1/47378/8/14073/178840/5dad471cE0f2e1142/05390e5ebfa0bb97.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (157, 14, 'https://img12.360buyimg.com/imgzone/jfs/t1/45880/11/3994/162739/5d1c4acbEa6a1e32e/0c51319893f1cb4c.png.webp');
INSERT INTO `goods_desc_img` VALUES (158, 14, 'https://img13.360buyimg.com/imgzone/jfs/t1/53579/27/4047/304601/5d1c4acbE1f31b6ca/6cf0821ae54ec7d5.png.webp');
INSERT INTO `goods_desc_img` VALUES (159, 15, 'https://img12.360buyimg.com/imgzone/jfs/t1/99507/4/2101/455346/5dca582fE419402c1/7435958464a8f261.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (160, 15, 'https://img12.360buyimg.com/imgzone/jfs/t1/105672/35/2041/450826/5dca5830Ed0409e83/3db4a94c95bf7809.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (161, 15, 'https://img30.360buyimg.com/imgzone/jfs/t1/55158/24/15774/184346/5dca5831Ee8da162a/94f037bc34b5173f.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (162, 15, 'https://img14.360buyimg.com/imgzone/jfs/t1/57312/10/15647/294444/5dca5831E23cd94fd/0c1ecfa059c93b4d.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (163, 15, 'https://img12.360buyimg.com/imgzone/jfs/t1/78007/4/15248/219791/5dca5832E306f5c72/4c9616facf07b1aa.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (164, 15, 'https://img14.360buyimg.com/imgzone/jfs/t1/57312/10/15647/294444/5dca5831E23cd94fd/0c1ecfa059c93b4d.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (165, 15, 'https://img12.360buyimg.com/imgzone/jfs/t1/78007/4/15248/219791/5dca5832E306f5c72/4c9616facf07b1aa.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (166, 15, 'https://img10.360buyimg.com/imgzone/jfs/t1/73108/37/15248/287719/5dca5833Eb6b7f8bf/adc0bfe7d9cd55f7.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (167, 16, 'https://img10.360buyimg.com/imgzone/jfs/t1/85119/7/254/213398/5da98694Ee1090b09/ff11644fa04f9b25.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (168, 16, 'https://img10.360buyimg.com/imgzone/jfs/t1/99607/2/233/243122/5da986a4E3584974a/293e78be90897ab6.jpg!q70.dpg.webp');
INSERT INTO `goods_desc_img` VALUES (169, 16, 'https://img14.360buyimg.com/imgzone/jfs/t1/106589/31/203/238117/5da986b5E5d1b260a/7c04dd383497a50f.jpg!q70.dpg.webp');

-- ----------------------------
-- Table structure for goods_img
-- ----------------------------
DROP TABLE IF EXISTS `goods_img`;
CREATE TABLE `goods_img`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品图片id',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片路径',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_img
-- ----------------------------
INSERT INTO `goods_img` VALUES (1, 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/104900/12/8501/130918/5e045ebcEf3f393d5/275fd3ba1c19067e.jpg!q80.dpg.webp', 1);
INSERT INTO `goods_img` VALUES (2, 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/107523/18/5227/175053/5e34cb3dEa8cb997c/60728b7aa55a12c9.jpg!q80.dpg.webp', 2);
INSERT INTO `goods_img` VALUES (3, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/110064/37/3223/60975/5e0eef39E8bfeb9d4/6284bab359da36f2.jpg!q70.dpg.webp', 3);
INSERT INTO `goods_img` VALUES (4, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/59022/28/10293/141808/5d78088fEf6e7862d/68836f52ffaaad96.jpg!q70.dpg.webp', 4);
INSERT INTO `goods_img` VALUES (5, 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/95046/21/12584/493686/5e4a8053Ec9120849/e52893861288dd0b.jpg!q80.dpg.webp', 5);
INSERT INTO `goods_img` VALUES (6, 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/88422/25/8642/280003/5e06f787E5e50d527/410243de19c9d651.jpg!q80.dpg.webp', 6);
INSERT INTO `goods_img` VALUES (7, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/103799/1/8459/415337/5e048903Eba57fba6/45e0568d42c9803d.jpg!q70.dpg.webp', 7);
INSERT INTO `goods_img` VALUES (8, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201808/20180821105814_49552.jpg', 8);
INSERT INTO `goods_img` VALUES (9, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184912_19449.jpg', 9);
INSERT INTO `goods_img` VALUES (10, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/109854/1/1898/237547/5e01b334Edaee02bf/838aa4b9b2327dbe.jpg!q70.dpg.webp', 10);
INSERT INTO `goods_img` VALUES (11, 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/56188/8/12952/197715/5d9c046aE59db092e/70c58a542277e8de.jpg!q80.dpg.webp', 11);
INSERT INTO `goods_img` VALUES (12, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201809/20180930151620_86720.jpg', 12);
INSERT INTO `goods_img` VALUES (13, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/101724/10/3357/95483/5ddfab7eE81769fcc/5114221c846b2ebe.jpg!q70.dpg.webp', 1);
INSERT INTO `goods_img` VALUES (14, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/105139/9/3373/96771/5ddfab7fE8ff15ff4/c6459c27d2391fae.jpg!q70.dpg.webp', 1);
INSERT INTO `goods_img` VALUES (15, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/103860/24/3413/123320/5ddfaba2Ececaafed/55f3d6f6fafee768.jpg!q70.dpg.webp', 1);
INSERT INTO `goods_img` VALUES (16, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/77083/2/694/187843/5cee7557Eeefb14f1/7fedee6354f0aa34.jpg!q70.dpg.webp', 2);
INSERT INTO `goods_img` VALUES (17, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/52987/35/1160/302615/5cee7557Eca6888ef/dd5f1882bef7677a.jpg!q70.dpg.webp', 2);
INSERT INTO `goods_img` VALUES (18, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/105835/19/12826/105979/5e5153c0E58ee2821/a67478705ab37ce1.jpg!q70.dpg.webp', 3);
INSERT INTO `goods_img` VALUES (19, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/85689/11/11698/160044/5e3d188bE155dbe54/138ddf37124ba08b.jpg!q70.dpg.webp', 3);
INSERT INTO `goods_img` VALUES (20, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/98984/15/10341/197962/5e1b033aEe48449d0/7e12705112a0160d.jpg!q70.dpg.webp', 3);
INSERT INTO `goods_img` VALUES (21, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/88142/14/10543/151519/5e1b0339E1c2c1422/8fe0b0e9941d3e4b.jpg!q70.dpg.webp', 3);
INSERT INTO `goods_img` VALUES (22, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/45954/33/10562/97168/5d780893Eaec0fe47/ee567a1dea515d38.jpg!q70.dpg.webp', 4);
INSERT INTO `goods_img` VALUES (23, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/60950/5/9837/104923/5d780897E82963984/08fed8837c92433a.jpg!q70.dpg.webp', 4);
INSERT INTO `goods_img` VALUES (25, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/80220/18/9892/163090/5d78089cEda2f9674/da3b18358e68cfca.jpg!q70.dpg.webp', 4);
INSERT INTO `goods_img` VALUES (26, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/63513/19/14303/499707/5dba8dd0E9f56dce0/38b78f313bdf61cb.jpg!q70.dpg.webp', 5);
INSERT INTO `goods_img` VALUES (27, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/64287/8/14293/483031/5dba8dd0E95eebbae/d16b566891ae08a2.jpg!q70.dpg.webp', 5);
INSERT INTO `goods_img` VALUES (28, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/106535/11/1127/395029/5dba8dd0Ea6ac778d/c2d7d1636d4562d5.jpg!q70.dpg.webp', 5);
INSERT INTO `goods_img` VALUES (29, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/45905/18/7142/356520/5d4bcbdaE3801d771/e3a8e686614a6a07.jpg!q70.dpg.webp', 6);
INSERT INTO `goods_img` VALUES (30, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/59330/21/5375/430407/5d3162c7Ee70a4a0d/31b40858e11beecc.jpg!q70.dpg.webp', 6);
INSERT INTO `goods_img` VALUES (31, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/62321/20/4931/962705/5d3162c5Ef86dac53/7729e701935c897b.jpg!q70.dpg.webp', 6);
INSERT INTO `goods_img` VALUES (32, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/69851/35/4928/623380/5d3162c3E9a7a496d/ce52d98d65727eb3.jpg!q70.dpg.webp', 6);
INSERT INTO `goods_img` VALUES (33, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/102441/25/8559/166590/5e057df9E3ac7e9f4/4c056035fc0d885e.jpg!q70.dpg.webp', 7);
INSERT INTO `goods_img` VALUES (34, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/104810/12/8388/375445/5e048900E254e4012/0cccae014a533892.jpg!q70.dpg.webp', 7);
INSERT INTO `goods_img` VALUES (35, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/108451/16/2161/440274/5e048900E4077cbb5/15351aafd78d3033.jpg!q70.dpg.webp', 7);
INSERT INTO `goods_img` VALUES (37, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201808/20180821105850_48074.jpg', 8);
INSERT INTO `goods_img` VALUES (38, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201808/20180821105853_95714.jpg', 8);
INSERT INTO `goods_img` VALUES (39, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201808/20180821105857_20435.jpg', 8);
INSERT INTO `goods_img` VALUES (40, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201808/20180821105900_38085.jpg', 8);
INSERT INTO `goods_img` VALUES (41, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184923_14422.jpg', 9);
INSERT INTO `goods_img` VALUES (42, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184925_10842.jpg', 9);
INSERT INTO `goods_img` VALUES (43, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184929_10577.jpg', 9);
INSERT INTO `goods_img` VALUES (44, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184932_51894.jpg', 9);
INSERT INTO `goods_img` VALUES (45, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/93462/2/7971/160516/5e01b334Eef620de7/cfd9571aedbdc208.jpg!q70.dpg.webp', 10);
INSERT INTO `goods_img` VALUES (46, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/108995/35/1854/174158/5e01b2ecEaba3c96c/eb81fd8b8b2598b8.jpg!q70.dpg.webp', 10);
INSERT INTO `goods_img` VALUES (47, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/19797/9/13120/37615/5c9d846cEfcbcd86b/5b8b80e5b80d5acb.jpg!q70.dpg.webp', 10);
INSERT INTO `goods_img` VALUES (48, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/98839/35/12763/253360/5e4f7d8bEd51cc8c4/1a6eb81a0b9eaab9.jpg!q70.dpg.webp', 11);
INSERT INTO `goods_img` VALUES (49, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/91468/19/10721/491538/5e1e89deE114a52ba/36e9bef74bcce862.jpg!q70.dpg.webp', 11);
INSERT INTO `goods_img` VALUES (50, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/110101/26/6497/506762/5e4f7225E11fdab89/552acc39cd83bc69.jpg!q70.dpg.webp', 11);
INSERT INTO `goods_img` VALUES (51, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/99863/11/10740/494338/5e1e89e0E24941416/aec8be80c279bc8e.jpg!q70.dpg.webp', 11);
INSERT INTO `goods_img` VALUES (52, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201809/20180930151623_89278.jpg', 12);
INSERT INTO `goods_img` VALUES (53, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201809/20180930151625_32873.jpg', 12);
INSERT INTO `goods_img` VALUES (54, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201809/20180930151627_67685.jpg', 12);
INSERT INTO `goods_img` VALUES (55, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201809/20180930151630_86505.jpg', 12);
INSERT INTO `goods_img` VALUES (56, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t3427/72/964652663/778106/7f26cb1c/58199853Nfa23116e.jpg!q70.dpg.webp', 13);
INSERT INTO `goods_img` VALUES (57, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t3112/347/9399797288/429182/fbb24729/58d47fa7N091d0913.jpg!q70.dpg.webp', 13);
INSERT INTO `goods_img` VALUES (58, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t4369/352/2620672632/300742/30e648b0/58d47fadNd08d5bd2.jpg!q70.dpg.webp', 13);
INSERT INTO `goods_img` VALUES (59, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t4657/228/780066209/376563/4357019/58d47fb2Nbf494d8c.jpg!q70.dpg.webp', 13);
INSERT INTO `goods_img` VALUES (60, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t3157/245/9546220219/421877/cc026fc3/58d47fb9N71077230.jpg!q70.dpg.webp', 13);
INSERT INTO `goods_img` VALUES (62, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/88392/25/13377/234981/5e563747Ebebd1a6c/fe18279dea1799ac.jpg!q70.dpg.webp', 14);
INSERT INTO `goods_img` VALUES (63, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/89122/33/13301/193557/5e563747E88a91c7c/96cfa50e1fdc0dc3.jpg!q70.dpg.webp', 14);
INSERT INTO `goods_img` VALUES (64, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/97562/12/408/64766/5dad4678E10145938/9737ee4c419b6ab2.jpg!q70.dpg.webp', 14);
INSERT INTO `goods_img` VALUES (65, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/64106/33/15180/81814/5dca1504E7c2b02a3/4583b5d07ce99403.jpg!q70.dpg.webp', 15);
INSERT INTO `goods_img` VALUES (66, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/68014/21/5708/189411/5d3e630dE935a938d/ab5cb1a6f69a86ec.jpg!q70.dpg.webp', 15);
INSERT INTO `goods_img` VALUES (67, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/68014/21/5708/189411/5d3e630dE935a938d/ab5cb1a6f69a86ec.jpg!q70.dpg.webp', 15);
INSERT INTO `goods_img` VALUES (68, 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/93419/38/207/156934/5da969e7Ebd3e58d8/1524874486c2942e.jpg!q80.dpg.webp', 16);
INSERT INTO `goods_img` VALUES (69, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/70165/11/13046/156525/5da969e6E7cf6e310/358fd54dce3a323f.jpg!q70.dpg.webp', 16);
INSERT INTO `goods_img` VALUES (70, 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/83933/40/13220/73021/5da969e6Ec3f6df5c/8315fa36b32bc8be.jpg!q70.dpg.webp', 16);

-- ----------------------------
-- Table structure for goods_orders
-- ----------------------------
DROP TABLE IF EXISTS `goods_orders`;
CREATE TABLE `goods_orders`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `user_id` int(11) NOT NULL COMMENT '用户id，关联user表中的id',
  `status` tinyint(255) NOT NULL COMMENT '订单的状态 0：未支付 1：已支付，代发货  2：已发货，待收货 3：已收货，待评价 4：订单完成 5：异常关闭',
  `addtime` int(11) NOT NULL COMMENT '下订单的时间戳',
  `order_sn` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `shr_phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货人电话',
  `shr_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货人姓名',
  `shr_province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '省',
  `shr_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '市',
  `shr_area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '区',
  `shr_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '详细地址',
  `shr_zipcode` int(10) NULL DEFAULT NULL COMMENT '邮政编码',
  `total_price` decimal(10, 2) NOT NULL COMMENT '总价',
  `post_order_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货的快递单号',
  `property` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '\r\n商品属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 189 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_orders
-- ----------------------------
INSERT INTO `goods_orders` VALUES (183, 11, 4, 1582785254, '15827852548673810209', '13344445555', '马大哈', '北京市', '北京市', '东城区', '北京路32栋302室', 552299, 199.00, NULL, '常规');
INSERT INTO `goods_orders` VALUES (184, 11, 4, 1582892830, '1582892830534448488', '13344445555', '西西', '天津市', '天津市', '和平区', '和歌路23号', 223311, 169.00, NULL, '常规');
INSERT INTO `goods_orders` VALUES (185, 11, 0, 1582957247, '15829572469694063489', '13344445555', '西西', '天津市', '天津市', '和平区', '和歌路23号', 223311, 69.00, NULL, '常规');
INSERT INTO `goods_orders` VALUES (186, 11, 0, 1582957264, '15829572647293676091', '13344445555', '西西', '天津市', '天津市', '和平区', '和歌路23号', 223311, 69.00, NULL, '常规');
INSERT INTO `goods_orders` VALUES (187, 11, 0, 1582957289, '1582957289295790572', '13344445555', '西西', '天津市', '天津市', '和平区', '和歌路23号', 223311, 69.00, NULL, '常规');
INSERT INTO `goods_orders` VALUES (188, 11, 3, 1582957297, '1582957297024388862', '13344445555', '西西', '天津市', '天津市', '和平区', '和歌路23号', 223311, 69.00, NULL, '常规');

-- ----------------------------
-- Table structure for goods_property
-- ----------------------------
DROP TABLE IF EXISTS `goods_property`;
CREATE TABLE `goods_property`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '属性id',
  `property_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '属性名称',
  `goods_id` int(10) NOT NULL COMMENT '对应商品id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for goods_specific
-- ----------------------------
DROP TABLE IF EXISTS `goods_specific`;
CREATE TABLE `goods_specific`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品具体属性值的id',
  `goods_id` int(11) NOT NULL COMMENT '商品的id',
  `attribute_ids` int(255) NOT NULL COMMENT '单个商品多个属性值的id',
  `inventory` tinyint(255) NOT NULL COMMENT '库存',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_comment
-- ----------------------------
DROP TABLE IF EXISTS `order_comment`;
CREATE TABLE `order_comment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评价id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评价内容',
  `grade` int(1) NOT NULL COMMENT '评分',
  `time` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论时间',
  `user_id` int(255) NULL DEFAULT NULL COMMENT '与user表关联',
  `goods_id` int(255) NULL DEFAULT NULL COMMENT '与商品表关联',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_comment
-- ----------------------------
INSERT INTO `order_comment` VALUES (1, '还行', 4, '2019-10-11', 3, 1);
INSERT INTO `order_comment` VALUES (2, '不错', 5, '2019-11-11', 3, 2);
INSERT INTO `order_comment` VALUES (3, '还可以吧', 5, '2019-11-20', 1, 3);
INSERT INTO `order_comment` VALUES (4, '好看！', 5, '1574593046', 6, 7);
INSERT INTO `order_comment` VALUES (5, '还不赖', 5, '1574593139', 6, 5);
INSERT INTO `order_comment` VALUES (6, '商品还可以啊！', 5, '1574600485', 7, 6);
INSERT INTO `order_comment` VALUES (7, '小鸡哔哔！', 5, '1574600624', 7, 2);
INSERT INTO `order_comment` VALUES (8, '解释！', 5, '1574600827', 7, 5);
INSERT INTO `order_comment` VALUES (9, '软绵！', 5, '1574600930', 7, 3);
INSERT INTO `order_comment` VALUES (10, '舒服满意', 3, '1582532700', 1, 3);
INSERT INTO `order_comment` VALUES (11, '不错不错', 4, '1582879394', 11, 15);
INSERT INTO `order_comment` VALUES (12, '音质不错', 4, '1582892982', 11, 3);

-- ----------------------------
-- Table structure for shop_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_goods`;
CREATE TABLE `shop_order_goods`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL COMMENT '商品id，关联goods里面的id',
  `buy_count` int(11) NOT NULL COMMENT '购买数量 最多200',
  `order_id` int(11) NOT NULL COMMENT '订单id 关联goods_orders表中的id',
  `price` decimal(10, 2) NOT NULL COMMENT '购买的成交价格',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名称',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 177 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_order_goods
-- ----------------------------
INSERT INTO `shop_order_goods` VALUES (1, 2, 4, 13, 510.00, 'K/DA 阿卡丽 中型雕塑', 'xxx');
INSERT INTO `shop_order_goods` VALUES (2, 2, 4, 14, 510.00, 'K/DA 阿卡丽 中型雕塑', 'xxx');
INSERT INTO `shop_order_goods` VALUES (3, 2, 4, 15, 510.00, 'K/DA 阿卡丽 中型雕塑', 'xxx');
INSERT INTO `shop_order_goods` VALUES (4, 2, 4, 18, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (5, 2, 4, 19, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (6, 2, 4, 20, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (7, 2, 4, 21, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (8, 2, 4, 22, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (9, 2, 4, 23, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (10, 2, 4, 24, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (11, 2, 4, 25, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (12, 2, 4, 26, 510.00, 'K/DA 阿卡丽 中型雕塑', '000');
INSERT INTO `shop_order_goods` VALUES (13, 2, 4, 27, 510.00, 'K/DA 阿卡丽 中型雕塑', '[object Object]');
INSERT INTO `shop_order_goods` VALUES (14, 2, 4, 48, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (15, 1, 200, 49, 0.01, '2019全球总决赛冠军皮肤周边短信预约', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133236_886570.jpg');
INSERT INTO `shop_order_goods` VALUES (16, 2, 4, 49, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (17, 1, 1, 50, 0.01, '2019全球总决赛冠军皮肤周边短信预约', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133236_886570.jpg');
INSERT INTO `shop_order_goods` VALUES (18, 2, 4, 50, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (19, 2, 1, 51, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (20, 3, 4, 51, 880.00, '2019 全球总决赛冠军纪念套装', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133333_664525.jpg');
INSERT INTO `shop_order_goods` VALUES (21, 2, 1, 52, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (22, 3, 4, 52, 880.00, '2019 全球总决赛冠军纪念套装', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133333_664525.jpg');
INSERT INTO `shop_order_goods` VALUES (23, 2, 1, 53, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (24, 3, 4, 53, 880.00, '2019 全球总决赛冠军纪念套装', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133333_664525.jpg');
INSERT INTO `shop_order_goods` VALUES (25, 2, 1, 54, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (26, 3, 4, 54, 880.00, '2019 全球总决赛冠军纪念套装', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133333_664525.jpg');
INSERT INTO `shop_order_goods` VALUES (27, 2, 1, 55, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (28, 3, 4, 55, 880.00, '2019 全球总决赛冠军纪念套装', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133333_664525.jpg');
INSERT INTO `shop_order_goods` VALUES (29, 2, 1, 56, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (30, 3, 4, 56, 880.00, '2019 全球总决赛冠军纪念套装', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133333_664525.jpg');
INSERT INTO `shop_order_goods` VALUES (31, 2, 1, 57, 510.00, 'K/DA 阿卡丽 中型雕塑', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133301_327985.jpg');
INSERT INTO `shop_order_goods` VALUES (32, 1, 3, 58, 0.01, '2019全球总决赛冠军皮肤周边短信预约', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133236_886570.jpg');
INSERT INTO `shop_order_goods` VALUES (33, 1, 3, 59, 0.01, '2019全球总决赛冠军皮肤周边短信预约', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133236_886570.jpg');
INSERT INTO `shop_order_goods` VALUES (34, 1, 3, 60, 0.01, '2019全球总决赛冠军皮肤周边短信预约', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133236_886570.jpg');
INSERT INTO `shop_order_goods` VALUES (35, 1, 3, 61, 0.01, '2019全球总决赛冠军皮肤周边短信预约', 'https://game.gtimg.cn/images/daojushop/zb/ad/201911/20191115133236_886570.jpg');
INSERT INTO `shop_order_goods` VALUES (36, 3, 3, 64, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (37, 3, 3, 65, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (38, 3, 3, 66, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (39, 11, 3, 67, 15.00, '手机壳周边', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190611154639_76818.jpg');
INSERT INTO `shop_order_goods` VALUES (40, 11, 3, 68, 15.00, '手机壳周边', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190611154639_76818.jpg');
INSERT INTO `shop_order_goods` VALUES (41, 1, 3, 69, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (42, 1, 2, 77, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (43, 3, 1, 77, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (44, 1, 2, 78, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (45, 3, 1, 78, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (46, 1, 2, 79, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (47, 3, 1, 79, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (48, 1, 2, 80, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (49, 3, 1, 80, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (50, 1, 2, 81, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (51, 3, 1, 81, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (52, 1, 2, 82, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (53, 3, 1, 82, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (54, 9, 1, 83, 23.00, '灌篮高手球衣', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184912_19449.jpg');
INSERT INTO `shop_order_goods` VALUES (55, 11, 1, 84, 15.00, '手机壳周边', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190611154639_76818.jpg');
INSERT INTO `shop_order_goods` VALUES (56, 9, 1, 84, 23.00, '灌篮高手球衣', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184912_19449.jpg');
INSERT INTO `shop_order_goods` VALUES (57, 2, 1, 85, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (58, 4, 1, 86, 89.00, '限量T恤', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110115036_73099.jpg');
INSERT INTO `shop_order_goods` VALUES (59, 11, 1, 86, 15.00, '手机壳周边', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190611154639_76818.jpg');
INSERT INTO `shop_order_goods` VALUES (60, 4, 1, 87, 89.00, '限量T恤', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110115036_73099.jpg');
INSERT INTO `shop_order_goods` VALUES (61, 10, 1, 87, 22.00, '海报', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201803/20180323171330_76311.jpg');
INSERT INTO `shop_order_goods` VALUES (62, 4, 1, 88, 89.00, '限量T恤', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110115036_73099.jpg');
INSERT INTO `shop_order_goods` VALUES (63, 1, 1, 89, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (64, 11, 1, 89, 15.00, '手机壳周边', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190611154639_76818.jpg');
INSERT INTO `shop_order_goods` VALUES (65, 1, 1, 90, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (66, 11, 1, 90, 15.00, '手机壳周边', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190611154639_76818.jpg');
INSERT INTO `shop_order_goods` VALUES (67, 2, 1, 91, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (68, 1, 1, 91, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (69, 3, 2, 92, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (70, 11, 1, 92, 15.00, '手机壳周边', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190611154639_76818.jpg');
INSERT INTO `shop_order_goods` VALUES (71, 2, 1, 93, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (72, 3, 1, 93, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (73, 2, 1, 94, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (74, 3, 1, 94, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (75, 2, 1, 95, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (76, 3, 1, 95, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (77, 2, 1, 96, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (78, 3, 1, 96, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (79, 2, 1, 97, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (80, 3, 1, 97, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (81, 2, 1, 98, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (82, 3, 1, 98, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (83, 2, 1, 99, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (84, 3, 1, 99, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (85, 2, 1, 100, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (86, 3, 1, 100, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (87, 2, 1, 101, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (88, 3, 1, 101, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (89, 10, 1, 102, 22.00, '海报', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201803/20180323171330_76311.jpg');
INSERT INTO `shop_order_goods` VALUES (90, 10, 1, 103, 22.00, '海报', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201803/20180323171330_76311.jpg');
INSERT INTO `shop_order_goods` VALUES (91, 13, 1, 104, 155.00, 'LPL冰箱贴(环保版)', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201909/20190928005357_33805.jpg');
INSERT INTO `shop_order_goods` VALUES (92, 13, 1, 105, 155.00, 'LPL冰箱贴(环保版)', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201909/20190928005357_33805.jpg');
INSERT INTO `shop_order_goods` VALUES (93, 7, 2, 106, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (94, 5, 1, 107, 42.00, '水壶', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191115104744_99712.jpg');
INSERT INTO `shop_order_goods` VALUES (95, 1, 1, 108, 299.00, '2019手办纪念套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110114539_25606.jpg');
INSERT INTO `shop_order_goods` VALUES (96, 2, 1, 108, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (97, 14, 1, 109, 200.00, '万圣节迷你手办套装', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201910/20191021171548_43053.jpg');
INSERT INTO `shop_order_goods` VALUES (98, 6, 1, 110, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (99, 6, 1, 111, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (100, 7, 1, 112, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (101, 7, 1, 113, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (102, 7, 1, 114, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (103, 7, 1, 115, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (104, 7, 1, 116, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (105, 7, 1, 117, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (106, 7, 1, 118, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (107, 7, 1, 119, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (108, 7, 1, 120, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (109, 7, 1, 121, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (110, 7, 1, 122, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (111, 7, 1, 123, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (112, 7, 1, 124, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (113, 7, 1, 125, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (114, 7, 1, 126, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (115, 7, 1, 127, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (116, 7, 1, 128, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (117, 7, 1, 129, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (118, 7, 1, 130, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (119, 7, 1, 131, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (120, 7, 1, 132, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (121, 7, 1, 133, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (122, 7, 1, 134, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (123, 7, 1, 135, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (124, 7, 1, 136, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (125, 7, 1, 137, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (126, 7, 1, 138, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (127, 7, 1, 139, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (128, 7, 1, 140, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (129, 7, 1, 141, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (130, 7, 1, 142, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (131, 7, 1, 143, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (132, 7, 1, 144, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (133, 7, 1, 145, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (134, 7, 1, 146, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (135, 7, 1, 147, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (136, 7, 1, 148, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (137, 7, 1, 149, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (138, 6, 1, 150, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (139, 6, 1, 151, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (140, 6, 1, 152, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (141, 6, 1, 153, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (142, 6, 1, 154, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (143, 6, 1, 155, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (144, 6, 1, 156, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (145, 6, 1, 157, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (146, 6, 1, 158, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (147, 6, 1, 159, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (148, 6, 1, 160, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (149, 7, 1, 161, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (150, 7, 1, 162, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (151, 7, 1, 163, 233.00, 'True Damage项链', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201905/20190507153943_70509.jpg');
INSERT INTO `shop_order_goods` VALUES (152, 6, 1, 164, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (153, 6, 1, 165, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (154, 6, 1, 166, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (155, 6, 1, 167, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (156, 6, 1, 168, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (157, 6, 1, 169, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (158, 6, 1, 170, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (159, 6, 1, 171, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (160, 6, 1, 172, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (161, 6, 1, 173, 12.00, '幸运珠', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201908/20190809105005_67420.jpg');
INSERT INTO `shop_order_goods` VALUES (162, 2, 1, 174, 59.00, '海报全套', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191110123608_26936.jpg');
INSERT INTO `shop_order_goods` VALUES (163, 5, 1, 175, 42.00, '水壶', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191115104744_99712.jpg');
INSERT INTO `shop_order_goods` VALUES (164, 5, 1, 176, 42.00, '水壶', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201911/20191115104744_99712.jpg');
INSERT INTO `shop_order_goods` VALUES (165, 3, 1, 177, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (166, 3, 1, 178, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (167, 20, 1, 179, 88.00, '限量LPL纪念品', 'http://127.0.0.1:9999/api/v2/uploads/1574642365612img-bdbaf3462e43c91daa9c8a80806ec7c1.jpg');
INSERT INTO `shop_order_goods` VALUES (168, 3, 1, 180, 34.00, '毛绒抱枕', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201812/20181218141334_17925.jpg');
INSERT INTO `shop_order_goods` VALUES (169, 18, 1, 181, 22.00, '额Q', 'http://127.0.0.1:9999/api/v2/uploads/157459379207720190611144036_78167.jpg');
INSERT INTO `shop_order_goods` VALUES (170, 9, 1, 182, 59.00, '灌篮高手球衣', 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201906/20190604184912_19449.jpg');
INSERT INTO `shop_order_goods` VALUES (171, 15, 1, 183, 199.00, '新款休闲鞋女士时尚休闲高帮帆布鞋女潮流学生百搭女鞋', 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/64106/33/15180/81814/5dca1504E7c2b02a3/4583b5d07ce99403.jpg!q70.dpg.webp');
INSERT INTO `shop_order_goods` VALUES (172, 3, 1, 184, 169.00, 'moloke真无线Air 蓝牙耳机双耳3 pro运动入耳式', 'https://m.360buyimg.com/mobilecms/s720x720_jfs/t1/110064/37/3223/60975/5e0eef39E8bfeb9d4/6284bab359da36f2.jpg!q70.dpg.webp');
INSERT INTO `shop_order_goods` VALUES (173, 1, 1, 185, 69.00, 'BLD贝览得一次性洗脸巾 棉柔巾 抽取式100片三盒装', 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/104900/12/8501/130918/5e045ebcEf3f393d5/275fd3ba1c19067e.jpg!q80.dpg.webp');
INSERT INTO `shop_order_goods` VALUES (174, 1, 1, 186, 69.00, 'BLD贝览得一次性洗脸巾 棉柔巾 抽取式100片三盒装', 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/104900/12/8501/130918/5e045ebcEf3f393d5/275fd3ba1c19067e.jpg!q80.dpg.webp');
INSERT INTO `shop_order_goods` VALUES (175, 1, 1, 187, 69.00, 'BLD贝览得一次性洗脸巾 棉柔巾 抽取式100片三盒装', 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/104900/12/8501/130918/5e045ebcEf3f393d5/275fd3ba1c19067e.jpg!q80.dpg.webp');
INSERT INTO `shop_order_goods` VALUES (176, 1, 1, 188, 69.00, 'BLD贝览得一次性洗脸巾 棉柔巾 抽取式100片三盒装', 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t1/104900/12/8501/130918/5e045ebcEf3f393d5/275fd3ba1c19067e.jpg!q80.dpg.webp');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户密码',
  `sex` int(1) NULL DEFAULT NULL COMMENT '用户性别(0：男，1：女)',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `money` decimal(10, 0) NULL DEFAULT 5000 COMMENT '用户余额',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `paypsd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'blue', '51ae39e6785d68ca4a16cf75676989e6', 0, '18707055159', '2323@qq.com', 15, 'https://shp.qpic.cn/mall/0/goods_lolriotmall_201901174926_12762/0.jpg', '123456');
INSERT INTO `user` VALUES (2, 'admin1', '51ae39e6785d68ca4a16cf75676989e6', NULL, '13336696363', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES (3, 'fat1', '51ae39e6785d68ca4a16cf75676989e6', NULL, '19823222222', '12345@qq.com', NULL, 'https://game.gtimg.cn/images/zb/x5/uploadImg/goods/201805/20180529202451_50972.jpg', NULL);
INSERT INTO `user` VALUES (4, 'admin', '51ae39e6785d68ca4a16cf75676989e6', NULL, '13336696361', '13336696316@qq.com', NULL, 'https://game.gtimg.cn/images/zb/comm/jcp.png', NULL);
INSERT INTO `user` VALUES (5, 'liumou', '51ae39e6785d68ca4a16cf75676989e6', NULL, '13323327166', NULL, NULL, 'https://game.gtimg.cn/images/zb/comm/jcp.png', NULL);
INSERT INTO `user` VALUES (6, '刘诗诗', '51ae39e6785d68ca4a16cf75676989e6', NULL, '13838777522', '791010421@qq.com', 3383, 'https://game.gtimg.cn/images/zb/comm/jcp.png', '526666');
INSERT INTO `user` VALUES (7, '小鸡哔哔', '51ae39e6785d68ca4a16cf75676989e6', 0, '15893580580', '15893580580@qq.com', 4777, 'https://game.gtimg.cn/images/zb/comm/jcp.png', '123456');
INSERT INTO `user` VALUES (9, 'admin', '4088d0fb899349b232b32df593acb92e', NULL, '18707055150', NULL, 5000, 'http://localhost:9999/api/v1/public/images/1520093328181.jpeg', NULL);
INSERT INTO `user` VALUES (10, 'cat', '51ae39e6785d68ca4a16cf75676989e6', NULL, '18707055111', NULL, 5000, 'https://game.gtimg.cn/images/zb/comm/jcp.png', NULL);
INSERT INTO `user` VALUES (11, 'blue', '51ae39e6785d68ca4a16cf75676989e6', 0, '13344445555', '211@qq.com', 4563, 'http://localhost:9999/api/v1/public/images/v2-1fd0f06945916a79ece0252d9395ee31_hd.jpg', '112233');

SET FOREIGN_KEY_CHECKS = 1;
