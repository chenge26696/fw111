-- 若依商城 H5 客户端 测试数据（分类/品牌/商品/SKU）
SET NAMES utf8mb4;

-- 分类（一级）
INSERT INTO pms_product_category (id, parent_id, name, level, show_status, sort, icon, create_time) VALUES
(100, 0, '服饰内衣', 0, 1, 1, NULL, NOW()),
(101, 0, '手机数码', 0, 1, 2, NULL, NOW()),
(102, 0, '家居生活', 0, 1, 3, NULL, NOW()),
(103, 0, '食品生鲜', 0, 1, 4, NULL, NOW()),
(104, 0, '运动户外', 0, 1, 5, NULL, NOW());

-- 品牌
INSERT INTO pms_brand (id, name, sort, show_status, logo, create_time) VALUES
(100, '若依优选', 1, 1, NULL, NOW()),
(101, '云端物联', 2, 1, NULL, NOW()),
(102, '匠心家居', 3, 1, NULL, NOW()),
(103, '田园日记', 4, 1, NULL, NOW());

-- 商品（publish_status=1 上架）
INSERT INTO pms_product (id, brand_id, category_id, name, pic, album_pics, publish_status, sort, price, unit, detail_mobile_html, brand_name, product_category_name, create_time) VALUES
(100, 100, 100, '纯棉短袖T恤 男款 修身百搭', 'https://picsum.photos/seed/tshirt1/400/400', 'https://picsum.photos/seed/tshirt1/400/400,https://picsum.photos/seed/tshirt2/400/400', 1, 1, 59.00, '件', '<p>100% 纯棉，柔软透气，修身版型，多色可选。</p><p><img src=\"https://picsum.photos/seed/tshirt1/600/400\"/></p>', '若依优选', '服饰内衣', NOW()),
(101, 100, 100, '女士圆领针织衫 秋冬打底衫', 'https://picsum.photos/seed/knit1/400/400', 'https://picsum.photos/seed/knit1/400/400', 1, 2, 89.00, '件', '<p>柔软针织面料，圆领设计，保暖舒适。</p>', '若依优选', '服饰内衣', NOW()),
(102, 101, 101, '无线蓝牙耳机 降噪超长续航', 'https://picsum.photos/seed/ear1/400/400', 'https://picsum.photos/seed/ear1/400/400,https://picsum.photos/seed/ear2/400/400', 1, 1, 159.00, '副', '<p>主动降噪，30 小时续航，佩戴舒适。</p><p><img src=\"https://picsum.photos/seed/ear1/600/400\"/></p>', '云端物联', '手机数码', NOW()),
(103, 101, 101, '智能充电宝 20000mAh 快充', 'https://picsum.photos/seed/power1/400/400', 'https://picsum.photos/seed/power1/400/400', 1, 2, 99.00, '个', '<p>20000mAh 大容量，双向快充，便携出行。</p>', '云端物联', '手机数码', NOW()),
(104, 101, 101, '机械键盘 客制化 青轴', 'https://picsum.photos/seed/keyboard1/400/400', 'https://picsum.photos/seed/keyboard1/400/400', 1, 3, 239.00, '把', '<p>客制化机械键盘，青轴手感，RGB 背光。</p>', '云端物联', '手机数码', NOW()),
(105, 102, 102, '保温杯 316不锈钢 大容量', 'https://picsum.photos/seed/cup1/400/400', 'https://picsum.photos/seed/cup1/400/400', 1, 1, 49.00, '个', '<p>316 不锈钢内胆，12 小时保温，大容量便携。</p>', '匠心家居', '家居生活', NOW()),
(106, 102, 102, '北欧风台灯 触控调光护眼', 'https://picsum.photos/seed/lamp1/400/400', 'https://picsum.photos/seed/lamp1/400/400', 1, 2, 129.00, '盏', '<p>北欧简约风，触控无极调光，护眼舒适。</p>', '匠心家居', '家居生活', NOW()),
(107, 102, 102, '纯棉毛巾浴巾套装 吸水速干', 'https://picsum.photos/seed/towel1/400/400', 'https://picsum.photos/seed/towel1/400/400', 1, 3, 39.00, '套', '<p>纯棉材质，吸水速干，亲肤不掉毛。</p>', '匠心家居', '家居生活', NOW()),
(108, 103, 103, '每日坚果礼盒 混合装 750g', 'https://picsum.photos/seed/nut1/400/400', 'https://picsum.photos/seed/nut1/400/400', 1, 1, 79.00, '盒', '<p>7 种坚果科学配比，每日一包，营养均衡。</p>', '田园日记', '食品生鲜', NOW()),
(109, 100, 104, '男士运动休闲鞋 轻量透气', 'https://picsum.photos/seed/shoe1/400/400', 'https://picsum.photos/seed/shoe1/400/400,https://picsum.photos/seed/shoe2/400/400', 1, 1, 199.00, '双', '<p>轻量化鞋底，透气网面，运动休闲两相宜。</p><p><img src=\"https://picsum.photos/seed/shoe1/600/400\"/></p>', '若依优选', '运动户外', NOW()),
(110, 100, 104, '商务双肩背包 防泼水大容量', 'https://picsum.photos/seed/bag1/400/400', 'https://picsum.photos/seed/bag1/400/400', 1, 2, 159.00, '个', '<p>防泼水面料，多隔层设计，出差通勤首选。</p>', '若依优选', '运动户外', NOW()),
(111, 103, 103, '蓝山风味挂耳咖啡 10片装', 'https://picsum.photos/seed/coffee1/400/400', 'https://picsum.photos/seed/coffee1/400/400', 1, 2, 35.00, '盒', '<p>蓝山风味，新鲜烘焙，撕开即冲。</p>', '田园日记', '食品生鲜', NOW());

-- SKU（每个商品 1 个 SKU，sp_data 为颜色规格）
INSERT INTO pms_sku (id, product_id, out_sku_id, price, pic, stock, sp_data, create_time) VALUES
(100, 100, 'SKU-100', 59.00, 'https://picsum.photos/seed/tshirt1/400/400', 200, '[{"key":"颜色","value":"白色"},{"key":"尺码","value":"L"}]', NOW()),
(101, 101, 'SKU-101', 89.00, 'https://picsum.photos/seed/knit1/400/400', 150, '[{"key":"颜色","value":"米色"},{"key":"尺码","value":"M"}]', NOW()),
(102, 102, 'SKU-102', 159.00, 'https://picsum.photos/seed/ear1/400/400', 300, '[{"key":"颜色","value":"黑色"}]', NOW()),
(103, 103, 'SKU-103', 99.00, 'https://picsum.photos/seed/power1/400/400', 180, '[{"key":"颜色","value":"白色"}]', NOW()),
(104, 104, 'SKU-104', 239.00, 'https://picsum.photos/seed/keyboard1/400/400', 80, '[{"key":"轴体","value":"青轴"}]', NOW()),
(105, 105, 'SKU-105', 49.00, 'https://picsum.photos/seed/cup1/400/400', 500, '[{"key":"颜色","value":"磨砂黑"}]', NOW()),
(106, 106, 'SKU-106', 129.00, 'https://picsum.photos/seed/lamp1/400/400', 120, '[{"key":"颜色","value":"白金色"}]', NOW()),
(107, 107, 'SKU-107', 39.00, 'https://picsum.photos/seed/towel1/400/400', 400, '[{"key":"规格","value":"3件套"}]', NOW()),
(108, 108, 'SKU-108', 79.00, 'https://picsum.photos/seed/nut1/400/400', 260, '[{"key":"规格","value":"750g"}]', NOW()),
(109, 109, 'SKU-109', 199.00, 'https://picsum.photos/seed/shoe1/400/400', 100, '[{"key":"颜色","value":"黑红"},{"key":"尺码","value":"42"}]', NOW()),
(110, 110, 'SKU-110', 159.00, 'https://picsum.photos/seed/bag1/400/400', 140, '[{"key":"颜色","value":"商务黑"}]', NOW()),
(111, 111, 'SKU-111', 35.00, 'https://picsum.photos/seed/coffee1/400/400', 350, '[{"key":"规格","value":"10片装"}]', NOW());
