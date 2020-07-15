// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db');

router.get('/product/:id', (req, res) => {
   let id = req.params.id
   // res.json({
   //    "id":id
   // })
   // 查询该商品
   let sql1 = 'SELECT * FROM goods WHERE id = ?;'
   // 查询商品图片
   let sql2 = 'SELECT path FROM goods_img WHERE goods_id = ?;'
   // 查询商品详情图片
   let sql3 = 'SELECT path FROM goods_desc_img WHERE goods_id = ?;'
   // 查询商品属性
   let sql4 = 'SELECT * FROM goods_property WHERE goods_id = ?;'
   // 查询商品属性值
   let sql5 = 'SELECT * FROM goods_attribute WHERE goods_id = ?;'

   sql = sql1 + sql2 + sql3 + sql4 + sql5
   // 执行 SQL
   // err：如果出错，错误信息、
   // data：执行 SQL 之后的返回值
   db.query(sql, [id, id, id, id, id], (err, results) => {
      if (err) {
         // 给前端返回 JSON 数据
         return res.json({
            'ok': 0,
            'error': err
         })
      }
      // 给前端返回 JSON 数据
      res.json({
         "data": results[0],
         "path": results[1],
         "details_path": results[2],
         "props": results[3],
         "attrs": results[4]
      })

   })
})


// 暴露路由
module.exports = router