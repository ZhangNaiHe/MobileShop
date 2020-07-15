// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db')

// 添加订单
router.post('/stock', (req, res) => {
  //  console.log(req.body);
   
   let address_id = req.body.address_id
   let cart = req.body.cart
  //  订单状态
  //  let status = req.body.status;
  
 // 参数验证
      // 验证收货人id是否正确
      let numRe = /^\d+$/
      if(!numRe.test(address_id)) {
        res.json({
          'ok': 0,
          'error': '无效的收货人地址'
        })
        return
      }
   
  // 判断商品库存量
  let goodsIds = []  // 所有的商品id
  // 循环购物车中的所有商品 提取出商品id
  cart.forEach(v => {
    goodsIds.push(v.goods_id)
  })
  // 根据id查询商品库存量
  goodsIds = goodsIds.join(',')  // 转字符串
  // console.log(goodsIds)
  let sql = `SELECT * FROM goods WHERE Id IN(${goodsIds})`
  db.query(sql, (error, data) => {
    if (error) return console.log(error)
    goodsData = data
    // console.log(data)
    // 总价格
    let totalPrice = 0
    // 循环数据库查询到的库存量
    for (let i = 0; i < data.length; i++) {
      // 根据商品id从购物车查询对应的商品
      let goods = cart.find(v => {
        return v.goods_id === data[i].id
      })


      // 判断购买数量是否大于库存量
      if (goods.count > data[i].inventory) {
        res.json({
          'ok': 0,
          'error': '商品库存量不足！'
        })


        return
      }
      // 计算商品小计并加到总价上
      totalPrice += goods.count * data[i].price
    }
    // 生成订单
    // 生成订单号 13位当前时间戳+7位随机数
    let sn = new Date().getTime().toString() + parseInt(Math.random() * 10000000)

    // 根据收货地址id (address_id) 查询地址信息
    let asql = `SELECT
    
        user_id,
        tel shr_phone,
        name shr_name,
        province shr_province,
        city shr_city,
        county shr_area,
        addressDetail shr_address,
        postalCode shr_zipcode

         FROM address WHERE id = ?`
    db.query(asql, address_id, (error, data) => {
      let orderData = {
        user_id: data[0].user_id,  // 从令牌解析出了用户id
        status: 0,  // 订单状态 默认0： 未支付
        addtime: parseInt(new Date().getTime() / 1000),  // 下订单的当前时间戳 默认为毫秒 转为秒/1000
        order_sn: sn, // 订单号 唯一且没有规律
        ...data[0],  // 把地址表的数据放进订单表
        total_price: totalPrice,
        property: "常规"

      }
      let sql2 = 'INSERT INTO goods_orders SET ?'
      db.query(sql2, orderData, (error, data2) => {
        if (error) {
          res.json({
            "error": error
          })
        } else {
          // 把购物车商品添加到订单商品表中
          //   res.json({
          //      "cart":cart
          // })
          // console.log(cart)
          // console.log(goodsData)
          for (let i = 0; i < cart.length; i++) {
            // 根据购物车中的商品id 查询商品数组找出对应的商品
            let goodsInfo = goodsData.find(v => { return v.id === cart[i].goods_id })
            // console.log(goodsInfo)

            db.query('SELECT path FROM goods_img WHERE goods_id = ?', cart[i].goods_id, (error, path) => {
              if (error) {
                res.json({
                  "ok": 0,
                  "error": error
                })
              } else {
                let orderGoodsData = {
                  goods_id: cart[i].goods_id,
                  buy_count: cart[i].count,
                  order_id: data2.insertId,
                  price: goodsInfo.price,
                  goods_name: goodsInfo.goods_name,
                  goods_image: path[0].path
                }
                db.query('INSERT INTO shop_order_goods SET ?', orderGoodsData, (error, data) => {
                  if (error) return res.json({
                    'ok': 0,
                    'error': error
                  })
                  if (i === cart.length - 1) {
                    res.json({
                      "ok": 1,
                     "data":sn
                    })
                  }

                })
              }

            })

          }




        }

      })
    })
  })

})
// 修改订单状态


// 暴露路由
module.exports = router