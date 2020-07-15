// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 
router.post('/demo', (req, res) => {
  res.send({"code":1})
})

// 暴露路由
module.exports = router