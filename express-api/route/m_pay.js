// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')
var isShow = true;   //定义开关变量
// 

router.get('/user', (req, res) => {
   // res.json({
   //    "data":req.query
   // })
   let id = req.query.id;
   let sql = 'SELECT * FROM user WHERE id  =? '
   db.query(sql, id, (error, data) => {
      if (error) {
         res.json({
            "ok": 0,
            "error": error
         })
      } else {
         res.json({
            "ok": 1,
            "data": data
         })
      }
   })
})

// 支付商品
router.post('/pay', (req, res) => {
   let sql = `UPDATE user SET money=${req.body.totalPrice} WHERE id = ${req.body.user_id}`
   db.query(sql, (error, data) => {
      if (error) {
         res.json({
            "ok": 0,
            "error": error
         })
      } else {
         let ids = []
         req.body.goods.forEach(v => {
            ids.push(v.goods_id)
         })
         db.query(`SELECT total_sale,inventory,id FROM goods WHERE id in (${ids.join(',')})`, (error, data2) => {
            if (error) {
               res.json({
                  "ok": 0,
                  "error": error
               })
            } else {
               for (var i = 0; i < data2.length; i++) {
                  let num = req.body.goods[i].count
                  let sql3 = `UPDATE goods SET total_sale =${data2[i].total_sale +Number(num) } ,inventory =${data2[i].inventory -Number(num)} WHERE id = ${data2[i].id}`;
                  db.query(sql3, (error, data3) => {
                     console.log(data3)
                     if (error) {
                        res.json({
                           "ok": 0,
                           "error": error
                        })
                     } else {
                        isShow = true
                        console.log('1', isShow);
                     }
                  })
               }
            }
         })
      }
    
      if(isShow==true){
                  
         return res.json({
            "ok":1
         })
   
      }

   })


})
// 支付成功 改变订单状态
router.put('/status',(req,res)=>{
   let sql = `UPDATE goods_orders SET status=${req.body.status} WHERE order_sn = ${req.body.sn}`
   db.query(sql,(error,data)=>{
      if(error){
         res.json({
            "error":error
         })
      }else{
         res.json({
            "ok":1,
            "data":data
         })
       
      }
   })

})
// 暴露路由
module.exports = router
