// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db');

router.get('/main_ad_images', (req, res) => {
   let sql = 'SELECT image,link FROM shop_swipe_images'
   // 执行 SQL
   // err：如果出错，错误信息、
   // data：执行 SQL 之后的返回值
   db.query(sql, (err, data) => {
      if (err) {
         // 给前端返回 JSON 数据
         res.json({
            'ok': 0,
            'error': err
         })
      } else {
         // 给前端返回 JSON 数据
         res.json({
            'ok': 1,
            'data': data
         })
      }
   })
})


// 获取分类商品
router.get('/classify/:id', (req, res) => {
   // 分类id为1的商品
   let id = req.params.id
   let sql = `SELECT * FROM  goods WHERE classify_id = ${id} limit 4`
   db.query(sql, (error, data) => {
      if (error) {
         res.json({
            "ok": 0,
            "error": error
         })
      } else {
         let ids = []
         data.forEach(v => {
            ids.push(v.id)
         })
         let id = ids.join(',')
         if (!id) {
            return res.json({
               data:data
            })
         }

         // let sql_img = `SELECT path FROM goods_img WHERE goods_id in (${id}) `
         let sql_img = `SELECT path FROM goods_img WHERE goods_id in (${id}) group by goods_id `
         db.query(sql_img, (error, path) => {
            if (error) return console.log(error)
            for (var i = 0; i < data.length; i++) {
            
               data[i].path = path[i]
               console.log(path);
            }
           
            res.json({
               data: data,
            })
         })
      }
   })
})



// 暴露路由
module.exports = router