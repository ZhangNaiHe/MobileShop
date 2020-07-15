// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询订单
router.get('/order', (req, res) => {
    let pagenum = req.query.pagenum || 1
    let pagesize = req.query.pagesize || 5
    let search = req.query.search
    // 开始的下标
    let offset = (pagenum - 1) * pagesize
    if (!search) {
        let sql = `SELECT * FROM goods_orders LIMIT ${offset},${pagesize}`
        db.query(sql, (error, results) => {
            if (error) return console.log(error);
            let ordersList = results
            let sql2 = 'SELECT * FROM user'
            // ordersList.forEach(item => {
            //     let user_id = item.id
            //     sql2 += `SELECT * FROM user WHERE id=${user_id};`
            // })
            db.query(sql2, (error, userdata) => {
                let userData = userdata
                //  查询订单商品
                db.query('SELECT * FROM shop_order_goods', (error, results) => {
                    let goods_orderlist = results
                    db.query('SELECT COUNT(*) total FROM goods_orders', (error, results) => {
                        res.json({
                            'status': 200,
                            'ordersList': ordersList,
                            'goods_total': results[0].total,
                            'goods_orderlist': goods_orderlist,
                            'userData': userData
                        })
                        return
                    })
                })
            })
        })
    } else if (search) {
        let sql = `SELECT * FROM goods_orders WHERE order_sn like '%${search}%' LIMIT ${offset},${pagesize}`
        db.query(sql, (error, results) => {
            if (error) return console.log(error);
            let ordersList = results
            let sql2 = 'SELECT * FROM user'
            // ordersList.forEach(item => {
            //     let user_id = item.id
            //     sql2 += `SELECT * FROM user WHERE id=${user_id}`
            // })
            db.query(sql2, (error, userdata) => {
                let userData = userdata
                //  查询订单商品
                db.query('SELECT * FROM shop_order_goods', (error, results) => {
                    let goods_orderlist = results
                    db.query('SELECT COUNT(*) total FROM goods_orders', (error, results) => {
                        res.json({
                            'status': 200,
                            'ordersList': ordersList,
                            'goods_total': results[0].total,
                            'goods_orderlist': goods_orderlist,
                            'userData': userData
                        })
                        return
                    })
                })
            })
        })
    }
})

// 查询订单下的商品详情
router.get('/ordergoods/:id', (req, res) => {
    let order_id = req.params.id
    let sql = 'SELECT * FROM shop_order_goods WHERE order_id=?'
    db.query(sql, order_id, (error, results) => {
        if (error) return console.log(error);
        res.json({
            'status': 200,
            'data': results
        })
    })
})
// 修改订单
router.put('/order/:id', (req, res) => {
    let id = req.params.id
    let shr_name = req.body.shr_name
    let shr_phone = req.body.shr_phone
    let shr_zipcode = req.body.shr_zipcode
    let shr_address = req.body.shr_address
    let sql = `UPDATE goods_orders SET shr_name ='${shr_name}', shr_phone='${shr_phone}',shr_zipcode=${shr_zipcode},shr_address='${shr_address}' WHERE id= ${id}`
    db.query(sql, (error, results) => {
        if (error) return console.log(error);
        res.json({
            'status': 200
        })
    })
})

// 取消订单
router.delete('/order/:id', (req, res) => {
    let id = req.params.id
    let sql = 'DELETE FROM  goods_orders WHERE id=?'
    db.query(sql, id, (error, results) => {
        if (error) return console.log(error);
        res.json({
            'status': 200,
            'meta': '删除成功'
        })
    })
})

// 订单发货
router.put('/orderdely/:id', (req, res) => {
    let id = req.params.id
    let status = req.body.status
    db.query(`SELECT status FROM goods_orders WHERE id =${id}`, (error, result) => {
        if (result[0].status == 0) {
            res.json({
                'code': 200,
                'error': '此订单还未付款!不予发货'
            })
        }
        else if (result[0].status == 1) {
            let sql = `UPDATE goods_orders SET status=${status} WHERE id = ${id}`
            db.query(sql, (error, results) => {
                if (error) return console.log(error);
                res.json({
                    'code': 400
                })
            })
        } else if (result[0].status != 1) {
            res.json({
                'code': 200,
                'error': '此订单已发货'
            })
        }
    })
})

module.exports = router;