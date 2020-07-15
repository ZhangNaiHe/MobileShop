// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

router.get('/comment/:id', (req, res) => {
   // 商品id
   let id = req.params.id
   let sql = `SELECT * FROM order_comment WHERE goods_id = ${id}`;
   db.query(sql, (error, data) => {
      if (error) {
         res.json({
            "ok": 0,
            "error": error
         })
      } else {
         // user_id 数组
         let userId = []
         data.forEach(v => {
            userId.push(v.user_id)
         })




         if (userId !== []) {
            userId = userId.join(',')
            let sql2 = `SELECT path,username FROM user WHERE id IN (${userId})`;
            db.query(sql2, (error, data2) => {
               // 合并对象
               let start = 0
               for (var i = 0; i < data.length; i++) {
                  start += data[i].grade

                  Object.assign(data[i], data2[i]);


               }
               if (error) {
                  res.json({
                     "ok": 0,
                     "error": error
                  })
               } else {
                  res.json({
                     "ok": 1,
                     "data": data,
                     "total": data.length,
                     "start": start / data.length
                  })
               }
            })
         } else {
            res.json({
               "ok": 1,
               data: data
            })
         }
      }
   })

})
router.post('/comment', (req, res) => {
   // 订单id
   let order_id = req.body.order_id
   let user_id = req.body.user_id
   let goods_id = req.body.goods_id
   let content = req.body.content
   let grade = req.body.grade
   // 提交商品评论
   let comList = {
      content,
      grade,
      time: Math.round(new Date().getTime() / 1000).toString(),
      user_id,
      goods_id
   }
   let sql = `INSERT INTO order_comment SET ?`
   // res.json({
   //    "data":req.body
   // })
   db.query(sql, comList, (error, data) => {
      if (error) {
         res.json({
            "ok": 0,
            "error": error
         })
      } else {
         let sql2 = `UPDATE goods_orders SET status=4 WHERE id = ${order_id}`
     
         db.query(sql2, (error, data2) => {
            if (error) {
               res.json({
                  "ok": 0,
                  "error": error
               })

            } else {
               res.json({
                  "ok": 1,
                  "data": data
               })
            }
         })
      }
   })
})



// 暴露路由
module.exports = router