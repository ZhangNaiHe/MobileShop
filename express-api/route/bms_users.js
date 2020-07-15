// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询用户
router.get('/user', (req, res) => {
    let pagenum = req.query.pagenum || 1
    let pagesize = req.query.pagesize || 5
    let search = req.query.search || ""
    // 开始的下标
    let offset = (pagenum - 1) * pagesize
    let sql = `SELECT * FROM user`
    if (search) sql += ` WHERE username LIKE '%${search}%'`
    sql += ` LIMIT ${offset},${pagesize}`
    db.query(sql, (error, results) => {
        if (error) return console.log(error);
        let userList = results
        //  查询总数
        let sql2 = 'SELECT COUNT(*) total FROM user'
        if (search) sql2 += ` WHERE username LIKE '%${search}%'`
        db.query(sql2, (error, results) => {
            res.json({
                'status': 200,
                'userList': userList,
                'user_total': results[0].total,
            })
            return
        })
    })
})
// 删除用户
router.delete('/user/:id', (req, res) => {
    let id = req.params.id
    let sql = 'DELETE FROM user WHERE id=?'
    db.query(sql, id, (error, results) => {
        if (error) return console.log(error);
        res.json({
            'status': 200,
            'meta': '删除成功'
        })
    })
})


module.exports = router;