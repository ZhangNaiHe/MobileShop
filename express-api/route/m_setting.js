// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询个人设置
router.get(`/setting/:id(\\d+)`, (req, res) => {
  // 查询id
  let id = req.params.id
  
  // sql语句
  let sql = 'select * from user where id = ?'
  db.query(sql, id, (error, data) => {
    if (error) {
      res.json({
        'ok': 0,
        'error': error
      })
    } else {
      res.json({
        'ok': 1,
        'data': data
      })
    }
  })
})

// 修改个人设置
router.put('/setting/:id(\\d+)', (req, res) => {
  // 接收参数
  let username = req.body.username
  let phone = req.body.phone
  let email = req.body.email
  let sex = req.body.sex
  let paypsd = req.body.paypsd
  // 定义要修改的数据
  let dataList = {}

  dataList.sex = sex
  // 正则
  let userRef = /^[\u4e00-\u9fa5A-Za-z0-9-_]*$/
  let mobRef = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/
  let emailRef = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/
  let payRef = /^[\w_-]{6}$/
  // 判断昵称
  if (username) {
    if (!userRef.test(username)) {
      res.json({
        'ok': 0,
        'error': '昵称只能是中英文，数字，下划线，减号'
      })
      return
    }
    // 添加到数组
    dataList.username = username
  }

  if (phone) {
    // 判断手机号
    if (!mobRef.test(phone)) {
      res.json({
        'ok': 0,
        'error': '手机号格式不正确'
      })
      return
    }
    dataList.phone = phone
  }

  if (email) {
    // 判断邮箱格式
    if (!emailRef.test(email)) {
      res.json({
        'ok': 0,
        'error': '邮箱格式不正确'
      })
      return
    }
    dataList.email = email
  }

  // 判断支付密码
  if (paypsd) {
    if (!payRef.test(paypsd)) {
      res.json({
        'ok': 0,
        'error': '请输入6位的支付密码'
      })
      return
    }
    dataList.paypsd = paypsd
  }

  // sql修改语句
  let sql = 'update user set ? where id = ?'
  // 获取id
  let id = req.params.id
  // 执行sql语句
  db.query(sql, [dataList, id], (error, data) => {
    if (error) {
      res.json({
        'ok': 0,
        'error': error
      })
    } else {
      res.json({
        'ok': 1,
        'data': dataList
      })
    }
  })
})

// 暴露路由
module.exports = router