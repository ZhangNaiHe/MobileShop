// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 根据用户id查询出评论
router.get('/selfcom/:id(\\d+)', (req, res) => {
  // 获取id
  let id = req.params.id
  // sql根据user_id查询
  let sql = `select * from order_comment where user_id = ?`
  db.query(sql, id, (error, data1) => {
    if (error) {
      res.json({
        'ok': 0,
        'error': error
      })
    } else {
      // 根据user_id查询到用户名和头像
      let sql = `select username, path from user where id = ${id}`
      db.query(sql, (error, data2) => {
        let start = 0
        // 合并对象
        for (var i = 0; i < data1.length; i++) {
          start += data1[i].grade
          // Object.assign() 方法用于将所有可枚举属性的值从一个或多个源对象复制到目标对象。它将返回目标对象。
          // Object.assign(target, ...sources)    【target：目标对象】，【souce：源对象（可多个）】
          Object.assign(data1[i], data2[0]);
        }
        if (error) {
          res.json({
            'ok': 0,
            'error': error
          })
        } else {
          res.json({
            'ok': 1,
            'data': data1,
            'total': data1.length,
            "start": start/ data1.length
          })
        }
      })
    }
  })
})

// 暴露路由
module.exports = router