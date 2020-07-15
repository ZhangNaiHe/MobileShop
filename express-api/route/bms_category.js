// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询分类
 router.get('/categorys',(req,res)=>{
     db.query('SELECT * FROM goods_classify',(error,data) =>{
         if(error) return console.log(error);
         
         res.json({
             'status':200,
             'data':data
         })
     })
 })

 module.exports = router;