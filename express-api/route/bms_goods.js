// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询商品
router.get('/goods', (req, res) => {
    let pagenum = req.query.pagenum || 1
    let pagesize = req.query.pagesize || 5
    let search = req.query.search
    // 开始的下标
    let offset = (pagenum - 1) * pagesize
    if (!search) {
        let sql = `SELECT * FROM goods LIMIT ${offset},${pagesize}`
        db.query(sql, (error, results) => {
            if (error) return console.log(error);
            let goodsList = results
            //  查询分类
            db.query('SELECT * FROM goods_classify', (error, results) => {
                let classlist = results
                db.query('SELECT COUNT(*) total FROM goods', (error, results) => {
                    res.json({
                        'status': 200,
                        'goodsData': goodsList,
                        'goods_total': results[0].total,
                        'classlist': classlist
                    })
                    return
                })
            })
        })
    } else if (search) {
        let sql = `SELECT * FROM goods WHERE goods_name like '%${search}%' LIMIT ${offset},${pagesize}`
        db.query(sql, (error, results) => {
            if (error) return console.log(error);
            let goodsList = results
            //  查询分类
            let goodstotal = results.length
            db.query('SELECT * FROM goods_classify', (error, results) => {
                res.json({
                    'status': 200,
                    'goodsData': goodsList,
                    'goods_total': goodstotal,
                    'classlist': results
                })
                return
            })
        })
    }
})
// 删除商品
router.delete('/goods/:id', (req, res) => {
    let id = req.params.id
    let sql = 'DELETE FROM goods WHERE id=?'
    db.query(sql, id, (error, results) => {
        if (error) return console.log(error);
        res.json({
            'status': 200,
            'meta': '删除成功'
        })
    })
})

// 修改商品
router.put('/goods/:id', (req, res) => {
    let id = req.params.id
    let goods_name = req.body.goods_name
    let price = req.body.price
    let inventory = req.body.inventory
    let sql = `UPDATE goods SET goods_name='${goods_name}', price=${price},inventory=${inventory} WHERE id= ${id}`
    db.query(sql, (error, results) => {
        if (error) return console.log(error);
        res.json({
            'status': 200
        })
    })
})


module.exports = router;