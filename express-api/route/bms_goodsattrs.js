// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询商品 + 属性
router.get('/goods/attrs', (req, res) => {
  let pagenum = req.query.pagenum || 1
  let pagesize = req.query.pagesize || 5
  let search = req.query.search || ''
  // 开始的下标
  let offset = (pagenum - 1) * pagesize
  // 查询所有商品
  let sql = `SELECT * FROM goods`
  sql += search ? ` WHERE goods_name like '%${search}%'` : ''
  sql += ` LIMIT ${offset},${pagesize};`
  // 查询商品总数
  let sql2 = `SELECT COUNT(*) total FROM goods`
  sql2 += search ? ` WHERE goods_name like '%${search}%'` : ''
  db.query(sql + sql2, (error, results) => {
    if (error) return console.log(error);
    let goodsList = results[0]
    let total = results[1][0].total
    // 当没找到数据时
    if (!goodsList[0]) {
      return res.json({
        "status":200,
        'goodsList': goodsList,
        'goods_total': 0
      })
    }

    let goods_ids = []
    goodsList.forEach(item => {
      goods_ids.push(item.id)
    })
    //  查询属性（名）
    db.query('SELECT * FROM goods_property WHERE goods_id IN (?);SELECT * FROM goods_attribute WHERE goods_id IN (?)', [goods_ids, goods_ids, goods_ids], (error, results) => {
      if (error) return console.log(error);
      let propList = results[0]
      let attrList = results[1]
      db.query('SELECT COUNT(*) total FROM goods', (error, results) => {
        res.json({
          'status': 200,
          'goodsList': goodsList,
          'goods_total': total,
          'propList': propList,
          'attrList': attrList
        })
        return
      })
    })
  })
})

// 添加属性 (property)
router.post('/addprop', (req, res) => {
  sql = 'INSERT INTO goods_property SET ?'
  db.query(sql, req.body, (error, results) => {
    if (error) return console.log(error);
    if (results.affectedRows) {
      res.json({
        "code": 200
      })
    }
  })
})


// 删除属性 (property)
router.get('/delprop', (req, res) => {
  let id = req.query.prop_id
  let sql = 'DELETE FROM goods_property WHERE id=?'
  db.query(sql, id, (error, results) => {
    if (error) {
      return res.json({
        'code': 400,
        'meta': error
      })
    }
    if (results.affectedRows) {
      res.json({
        'code': 200,
        'meta': '删除成功'
      })
    } else {
      res.json({
        'code': 400,
        'meta': '删除失败'
      })

    }
  })
})


// 添加属性值 (attribute)
router.post('/addattr', (req, res) => {
  sql = 'INSERT INTO goods_attribute SET ?'
  db.query(sql, req.body, (error, results) => {
    if (error) return console.log(error);
    if (results.affectedRows) {
      res.json({
        "code": 200
      })
    }
  })
})


// 删除属性
router.get('/delattr', (req, res) => {
  let id = req.query.attr_id
  let sql = 'DELETE FROM goods_attribute WHERE id=?'
  db.query(sql, id, (error, results) => {
    if (error) {
      return res.json({
        'code': 400,
        'meta': error
      })
    }
    if (results.affectedRows) {
      res.json({
        'code': 200,
        'meta': '删除成功'
      })
    } else {
      res.json({
        'code': 400,
        'meta': '删除失败'
      })

    }
  })
})



module.exports = router;