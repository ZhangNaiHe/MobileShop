// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

router.put('/payment/:id', (req, res) => {
    let id = req.params.id
    let status = req.body.status
    console.log(id,status);
    if (status == 0) {
        let sql = 'UPDATE goods_orders SET status = 1 WHERE id =?'
        db.query(sql, id, (error, results) => {
            if (error) return console.log(error);
            res.json({
                'code': 400,
                'meta': '付款成功'
            })
        })
    } else if (status == 2) {
        let sql = 'UPDATE goods_orders SET status = 3 WHERE id =?'
        db.query(sql, id, (error, results) => {
            if (error) return console.log(error);
            res.json({
                'code': 401,
                'meta': '收货成功'
            })
        })
    } else if (status == 3) {
        let sql = 'UPDATE goods_orders SET status = 4 WHERE id =?'
        db.query(sql, id, (error, results) => {
            if (error) return console.log(error);
            res.json({
                'code': 402,
                'meta': '评价成功'
            })
        })
    } else {
        res.json({
            'code': 200,
            'meta': '欢迎下次再来'
        })
        return
    }
})

module.exports = router;