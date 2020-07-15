// 引入express并创建路由
const router = require('express').Router()
// 引入fs包
const fs = require('fs')
// 引入path包
const path = require('path')
// 引入上传文件中间件
const multer = require('multer')
// 引入数据库
const db = require('../db')
// 配置文件上传
const upload = multer({
  dest: path.resolve(__dirname, '../') + '/uploads'
})

// 配置详情文件上传
const uploadAll = multer({
  dest: path.resolve(__dirname, '../') + '/uploads'
})
// 上传图片接口
router.post('/uploads', upload.single('file'), (req, res) => {
  let dateName = new Date().getTime()
  // 获取写入的图片路径
  // let des_file = path.resolve(__dirname, '../') + '/uploads/' + req.file.originalname
  let des_file = path.resolve(__dirname, '../') + '/uploads/' + dateName + req.file.originalname
  console.log(req.file.originalname)
  // 读取上传的图片buff信息
  fs.readFile(req.file.path, (err, data) => {
    // 将读取到的信息写入到图片路径中
    fs.writeFile(des_file, data, (err) => {
      if (err) throw err
      // 返回图片的服务器路径和成功报告
      res.json({
        'code': 200,
        'msg': '上传图片成功!',
        'path': 'http://127.0.0.1:9999/uploads/' + dateName + req.file.originalname
      })
    })
    // 删除上传的图片的buff消息
    fs.unlink(req.file.path, (err) => {
      if (err) throw err
    })
  })
})

// 上传详情图片接口
router.post('/uploadsall', uploadAll.single('file'), (req, res) => {
  // 获取写入的图片路径
  let dateName = new Date().getTime()
  let des_file = path.resolve(__dirname, '../') + '/uploads/' + dateName + req.file.originalname
  // 读取上传的图片buff信息
  fs.readFile(req.file.path, (err, data) => {
    // 将读取到的信息写入到图片路径中
    fs.writeFile(des_file, data, (err) => {
      if (err) throw err
      // 返回图片的服务器路径和成功报告
      res.json({
        'code': 200,
        'msg': '上传图片成功!',
        'path': 'http://127.0.0.1:9999/uploads/' + dateName + req.file.originalname
      })
    })
    // 删除上传的图片的buff消息
    fs.unlink(req.file.path, (err) => {
      if (err) throw err
    })
  })
})

// 添加商品
router.post('/goods', (req, res) => {
  // 获取body数据
  console.log(req.body);
  
  let goods_name = req.body.goods_name
  let property = req.body.property
  let price = req.body.price
  //  添加商品的当前时间戳
  let time = Math.round(new Date().getTime() / 1000).toString();
  let classify_id = req.body.classify_id
  let total_sale = 0
  let inventory = req.body.inventory
  let data = {
    goods_name,
  
    price,
    time,
    classify_id,
    total_sale,
    inventory
  }
  //  sql语句
  let sql = 'INSERT INTO goods SET ?'
  //  操作数据库添加纪录
  db.query(sql, data, (error, results) => {
    //  判断是否报错 如果报错 返回error
    if (error) return console.log(error);

    //  获取当前商品id
    db.query('SELECT id FROM goods WHERE time=?', time, (error, result) => {
      if (error) return console.log(error);
      let id = result[0].id
      //  商品图片
      let pics = req.body.pics
      console.log(pics)
      // 商品详情图片
      let picsall = req.body.picsall
      let sql2 = ''
      let sql3 = ''
      pics.forEach(item => {
        let path = item.pic.slice(0, 22) + 'api/v2/' + item.pic.slice(22)
      console.log(path)
      let goods_id = id
        sql2 += `INSERT INTO goods_img (goods_id, path) VALUES (${goods_id},'${path}');`
      });
      // sql2 = `INSERT INTO goods_img (goods_id, path) VALUES (12,'http://127.0.0.1:9999/uploads/v2-03b2ab767ed97cae340b60533bc6cb34_hd.jpg')`
      db.query(sql2, (error, result) => {
        if (error) return console.log(error)
      })
      // -----
      // 商品详情图片
      picsall.forEach(item2 => {
        let path = item2.pic.slice(0, 22) + 'api/v2/' + item2.pic.slice(22)
        let goods_id = id
        sql3 += `INSERT INTO goods_desc_img (goods_id, path) VALUES (${goods_id},'${path}');`
      })
      db.query(sql3, (error, result) => {
        if (error) return console.log(error);
        res.json({
          'status': 200
        })
      })
    })
  })
})
// 返回图片
router.get('/uploads/:pic_name', (req, res) => {
  res.sendFile(path.join(__dirname, "/../uploads/", req.params.pic_name))
})

// 暴露路由
module.exports = router;
