// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 查询商品分类数据
router.get('/sort', (req, res) => {
  // 查询数据
  let sql = `SELECT * FROM goods_classify`
  db.query(sql, (error, results) => {
    if (error) {
      res.json({
        "ok": 0,
        "error": error
      })
    } else {
      res.json({
        "ok": 1,
        "data": results
      })
    }
  })
})


// 分类商品
router.get(`/goods`, (req, res) => {
  console.log(req.query)
  // 接收分页参数
  let page = JSON.parse(req.query.page)
  let page_num = page.page_num || 1;
  let page_size = page.page_size || 10
  // 接收分类参数
  let classify = JSON.parse(req.query.classify)
  let classify_id = classify.classify_id;
  let sort = classify.sort;
  let status = classify.status;

  // return false

  // where
  let where = ``
  if (classify_id && status) {
    where = ` WHERE classify_id =  ${classify_id} AND status = ${status}`
  } else if (!classify_id && status) {
    where = ` WHERE  status = ${status}`
  } else if (classify_id && !status) {
    where = ` WHERE classify_id =  ${classify_id}`
  } else {
    where = ``
  }
  // order by
  let orderBy = sort == 0 ? '' : ` ORDER BY ${sort}`
  // limit
  let offset = (page_num - 1) * page_size
  let limit = ` LIMIT ${offset}, ${page_size}`

  // 查询
  let sql = `SELECT * FROM goods` + where + orderBy + limit
  db.query(sql, (error, data1) => {
    if (error) {
      res.json({
        'ok': 0,
        'error': error
      })
    } else {
      // 查询所有商品图片数据
      let sql = `SELECT * FROM goods_img`
      db.query(sql, (error, data2) => {
        console.log(data1)
        if (error) {
          res.json({
            'ok': 0,
            'error': error
          })
        } else {
          // 分类sql语句
          res.json({
            'ok': 1,
            'goods': data1,
            'img': data2
          })
        }
      })
    }
  })
})

// 搜索商品
router.get(`/search`, (req, res) => {
  // 接收分页参数
  let page_num = req.query.page.page_num || 1;
  let page_size = req.query.page.page_size || 10
  // 接收分类参数
  let searchStr = req.query.searchStr || ''

  // return false

  // where
  let where = searchStr ? ` WHERE GOODS_NAME LIKE '%${searchStr}%'` : ''
  // limit
  let offset = (page_num - 1) * page_size
  let limit = ` LIMIT ${offset}, ${page_size}`

  // 查询
  let sql = `SELECT * FROM goods` + where + limit
    db.query(sql, (error, data1) => {
    if (error) {
      return res.json({
        'ok': 0,
        'error': error
      })
    }
    let ids = []
    data1.forEach(item => {
      ids[ids.length] = item.id
    })
    // 如果没有商品，直接返回
    if (!ids[0]) {
      res.json({
        'ok': 1,
        'goods': [],
        'img': []
      })
      return
    }

    // 查询所有商品图片数据
    let where2 = ` WHERE goods_id IN (${ids})`
    let sql2 = `SELECT * FROM goods_img ${where2} GROUP BY goods_id`
    db.query(sql2, (error, data2) => {
      if (error) {
        res.json({
          'ok': 0,
          'error': error
        })
      } else {
        res.json({
          'ok': 1,
          'goods': data1,
          'img': data2
        })
      }
    })
  })
})


// 暴露路由
module.exports = router