// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

router.get('/goods_main',(req,res) => {
    // 获取销量最高商品的sqi语句
    let sql = 'SELECT * FROM goods ORDER BY total_sale DESC LIMIT 0,3'
    db.query(sql,(error,results) => {
        if(error) return console.log(error);
        let sql2 = 'SELECT * FROM goods_img GROUP BY goods_id'
        let goodsdata = results
        db.query(sql2,(error,data) => {
         if(error) return console.log(error);
         res.json({
             'status':200,
             'goodsData' :goodsdata,
             'goodsImg':data
         })
        })
        //  res.json({
        //      'status':200,
        //      'data':results
        //  })
    })
})


module.exports = router;