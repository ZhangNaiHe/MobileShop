// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 添加到购物车
router.post('/cart', (req, res) => {
   let cartList = req.body

   let sql2 = `SELECT * FROM cart WHERE user_id=${cartList.user_id} AND goods_id = ${cartList.goods_id}`;
   db.query(sql2, (error, data1) => {
      if (error) {
         res.json({
            "ok": 0,
            "error": error
         })
      } else {
         if (data1.length == 0) {
            let sql = 'INSERT INTO cart SET ?'
            db.query(sql, cartList, (error, data) => {
               if (error) {
                  res.json({
                     "ok": 0,
                     "error": error
                  })
               } else {

                  res.json({
                     "ok": 1,

                  })
               }
            })
         } else {
            let newCount = data1[0].count + 1
            let id = data1[0].id
            let sql3 = `UPDATE cart SET count= ${newCount} WHERE id  = ${id}`
            db.query(sql3, (error, data) => {
               if (error) {
                  res.json({
                     "error": error
                  })
               } else {
                  res.json({
                     "ok": 1,
                     "data": "count++"
                  })
               }
            })
         }

      }
   })


   // let sql = 'INSERT INTO cart SET ?'
   // db.query(sql,cartList,(error,data)=>{
   //    if(error){
   //       res.json({
   //          "ok":0,
   //          "error":error
   //       })
   //    }else{




   //    }
   // })
   // res.json({
   //    "data":req.body
   // })
})

// 查询购物车商品
router.get('/cart/:id(\\d+)', (req, res) => {
   let id = req.params.id
   // sql查询语句
   let sql = 'select * from cart where user_id = ?'
   db.query(sql, id, (error, data) => {
      if (error) {
         res.json({
            'ok': 0,
            'error': error
         })
      } else {
         // 没商品时
         if (data.length === 0) {
            return res.json({
               'ok': 1,
               'data': data
            })
         }
         // console.log('dfsf')
         // console.log(data)
         let goodsId = []
         data.forEach(ele => {
            goodsId.push(ele.goods_id)
         });
         goodsId = goodsId.join(',')
         // 根据goods_id在shop_order_goods 查询出商品名称、价格和图片
         let sql = `select goods_name, price,id from goods where id in (${goodsId})`
         db.query(sql, (error, data2) => {

            // 合并对象
            data.forEach(item => {
               data2.forEach(item2 => {
                  if (item.goods_id === item2.id) {
                     item.goods_name = item2.goods_name
                     item.price = item2.price
                  }
               })
            })
            // console.log(data)
            if (error) {
               res.json({
                  'ok': 0,
                  'error': error
               })
            } else {
               // 查图片
               let sql = `select * from goods_img where goods_id in (${goodsId})`
               // if (goodsId) sql += ``

               db.query(sql, (error, data3) => {
                  console.log('liuliu')
                  console.log(data3)
                  // 合并对象
                  for (var i = 0; i < data.length; i++) {
                     data.forEach(item => {
                        data3.forEach(item3 => {
                           if (item.goods_id === item3.goods_id) {
                              item.path = item3.path
                           }
                        })
                     })
                  }
                  if (error) {
                     res.json({
                        'ok': 0,
                        "error": error
                     })
                  } else {
                     res.json({
                        'ok': 1,
                        'data': data
                        // 'path': data3
                     })
                  }
               })
            }
         })
      }
   })
})

// 保存购物车修改状态
router.put('/cart/:id(\\d+)', (req, res) => {
   // 获取参数
   // let ischk = req.body.ischk
   let count = req.body.count
   // 定义要修改的数据
   let dataList = {}
   // 修改数据放进 datalist
   // dataList.ischk = ischk
   dataList.count = count
   // 获取id
   let id = req.params.id
   // sql修改语句
   let sql = `update cart set ? where id = ?`
   // 执行sql语句
   db.query(sql, [dataList, id], (error, data) => {
      if (error) {
         res.json({
            'ok': 0,
            'error': error
         })
      } else {
         res.json({
            'ok': 1,
            'data': dataList
         })
      }
   })
})

router.put('/ischk/:id(\\d+)', (req, res) => {
   // 获取参数
   let ischk = req.body.ischk
   // let count = req.body.count
   // 定义要修改的数据
   let dataList = {}
   // 修改数据放进 datalist
   dataList.ischk = ischk
   // dataList.count = count
   // 获取id
   let id = req.params.id
   // sql修改语句
   let sql = `update cart set ? where id = ?`
   // 执行sql语句
   db.query(sql, [dataList, id], (error, data) => {
      if (error) {
         res.json({
            'ok': 0,
            'error': error
         })
      } else {
         res.json({
            'ok': 1,
            'data': dataList
         })
      }
   })
})

// 删除
router.delete('/cart/:id(\\d+)', (req, res) => {
   // 获取id
   let id = req.params.id
   // sql删除语句
   let sql = 'delete from cart where id = ?'
   db.query(sql, id, (error, data) => {
      if (error) {
         res.json({
            'ok': 0,
            'error': error
         })
      } else {
         res.json({
            'ok': 1
         })
      }
   })
})

// 暴露路由
module.exports = router