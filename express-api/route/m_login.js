// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')
// 引入md5
const md5 = require('md5')
// 引入密钥
const md5_key = require('../config').md5_key
// 引入jwt
const jwt = require('../jwt')

// 登录接口
router.post('/login', (req, res) => {
  // 获取电话号码和密码
  let phone = req.body.phone
  let password = req.body.password

  // 正则
  let mobRef = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/
  let passRef = /^[\w_-]{6,16}$/

  // 手机号正则验证
  if (!mobRef.test(phone)) {
      res.json({
          "ok": 0,
          "error": "手机号码格式不正确"
      })
      return
  }
  // 密码正则验证
  if (!passRef.test(password)) {
      res.json({
          "ok": 0,
          "error": "密码必须是6-16位的字母、数字、_-组成！"
      })
      return
  }

  // sql语句查询账号是否存在
  let sql = 'select * from user where phone = ?'
  db.query(sql, phone, (error, data) => {
    if (error) {
      res.json({
        'ok': 0,
        'error': error
      })
    } else {
      // 账号存在
      if (data.length > 0) {
        // 判断密码是否正确
        if (md5(password + md5_key) === data[0].password) {
          // 正确则生成令牌 存令牌
          res.json({
            "ok": 1,
            "message": "登录成功",
            "data": data[0],
            "token": jwt.makeJWT({
              id: data[0].id
            })
          })
        } else {
          // 否则密码错误
          res.json({
            'ok': 0,
            'error': '密码错误'
          })
        }
      } else {
        // 否则账号不存在
        res.json({
          'ok': 0,
          'error': '该用户不存在'
        })
      }
    }
  })
})



// 导出路由
module.exports = router