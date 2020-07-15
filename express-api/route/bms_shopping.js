// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询商城
router.get('/shopping', (req, res) => {
   let sql = `SELECT COUNT(*)order_num , SUM(total_price) order_price   FROM goods_orders WHERE status = 4`
   db.query(sql, (error, data) => {
      if (error) {
         res.json({
            "ok": 0,
            "error": error,

         })
      } else {
         let sql2 = `SELECT COUNT(*)  user_num FROM user`
         db.query(sql2, (error, data2) => {
            if (error) {
               res.json({
                  "ok": 0,
                  "error": error
               })
            } else {
               res.json({
                  "ok": 1,
                  user_num: data2,
                  data: data
               })
            }



         })
      }
   })

})

// 暴露路由
module.exports = router