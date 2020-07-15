// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询订单
router.get('/order/:id', (req, res) => {
    let user_id = req.params.id
    let sql = `SELECT * FROM goods_orders WHERE user_id=${user_id}`
    db.query(sql, (error, results) => {
        if (error) return console.log(error);
        let ordersList = results
        db.query('SELECT * FROM shop_order_goods', (error, results) => {
            let goods_orderlist = results
            db.query('SELECT COUNT(*) total FROM goods_orders', (error, results) => {
                res.json({
                    'status': 200,
                    'ordersList': ordersList,
                    'goods_orderlist': goods_orderlist,
                })
                return
            })
        })

    })
})

// 修改用户余额
router.put('/userly/:id', (req, res) => {
    let id = req.params.id
    let money = req.body.money
    let sql = `UPDATE user SET money = ${money} WHERE id = ?`
    db.query(sql, id, (error, results) => {
    if(error) return console.log(error);
      res.json({
          'code':200
      })
    })
})


// 暴露路由
module.exports = router