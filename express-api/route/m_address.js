// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 添加地址
router.post('/address', (req, res) => {
   let sql = 'INSERT INTO address SET ?'
   let addressList = req.body

   db.query(sql, addressList, (error, data) => {
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
})

// 查询用户地址
router.get('/address/:id', (req, res) => {
   // 用户id
   let id = req.params.id

   let sql = `SELECT * FROM address WHERE user_id = ?`
   db.query(sql, id, (error, data) => {
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

})
// 修改用户默认地址
router.get('/address/:user_id/:id', (req, res) => {
   // 用户id
   let user_id = req.params.user_id
   let id = req.params.id
   console.log(user_id);
   let sql = `SELECT * FROM address WHERE user_id = ?`
   db.query(sql, user_id, (error, data) => {
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

         let sql2 = `UPDATE address SET isDefault= '0' WHERE id in (${ids.join(',')})`
         db.query(sql2, (error, data) => {
            if (error) {
               res.json({
                  "ok": 0,
                  "error": error
               })
            } else {
               // UPDATE address SET isDefault= '0' WHERE id in (${ids.join(',')}
               sql3 = `UPDATE address SET isDefault= '1' WHERE id = ?`
               db.query(sql3, id, (error, data) => {
                  if (error) {
                     res.json({
                        "ok": 0,
                        "error": error
                     })
                  } else {
                     res.json({
                        "ok": 1
                     })
                  }
               })
            }
         })
      }
   })

})

// 暴露路由
module.exports = router