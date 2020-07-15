// 引入express 文件
const express = require('express')
// 引入配置文件
const config = require('./config')
// 创建框架对象
// 配置body-parser
const bodyParser = require('body-parser')
const app = express()



app.use(bodyParser.urlencoded({
   extended: false
}))
// 转化body请求数据的格式
app.use(bodyParser.json())

// app.use(md5)

// app.get('/',(req,res) =>{
//    res.json({
//       'do':00
//    })
// })

// 跨域
var cors = require('cors');
app.use(cors());

// 后台接口
// 配置后台管理系统登录路由
// 登录/注册
app.use('/api/v2', require('./route/bms_login'))
// 商品分类
app.use('/api/v2', require('./route/bms_category'))
// 商品添加
app.use('/api/v2', require('./route/bms_goodsadd'))
// 商品列表
app.use('/api/v2', require('./route/bms_goods'))
// 商品属性
app.use('/api/v2', require('./route/bms_goodsattrs'))
// 订单管理
app.use('/api/v2', require('./route/bms_order'))
// 用户列表
app.use('/api/v2', require('./route/bms_users'))
// 首页样式
app.use('/api/v2', require('./route/bms_shopping'))
// 后台首页main页面数据渲染
app.use('/api/v2', require('./route/bms_main'))


// 前端配置
// 注册
app.use('/api/v1', require('./route/m_register'))
// 登录接口
app.use('/api/v1', require('./route/m_login'))
// 首页
app.use('/api/v1', require('./route/m_index'))
// 分类页面接口
app.use('/api/v1', require('./route/m_sort'))
// 商品详情
app.use('/api/v1', require('./route/m_product'))
// 我的订单页面接口
app.use('/api/v1', require('./route/m_order'))
// 商品评论
app.use('/api/v1', require('./route/m_comment'))
// 购物车推荐商品
app.use('/api/v1', require('./route/m_goodsCart'))
// 个人设置接口
app.use('/api/v1', require('./route/m_setting'))
// 订单接口
app.use('/api/v1', require('./route/m_address'))
// 我的评价 接口
app.use('/api/v1', require('./route/m_selfcom'))
// 购物车
app.use('/api/v1', require('./route/m_cart'))
// 库存
app.use('/api/v1', require('./route/m_stock'))
// 支付接口
app.use('/api/v1', require('./route/m_pay'))
// 上传头像
app.use('/api/v1', require('./route/m_upload'))
// 付款 收货
app.use('/api/v1', require('./route/m_status'))

app.listen(config.server.port, config.server.ip, function () {
   console.log(`启动端口:${config.server.ip}:${config.server.port}!`);

})