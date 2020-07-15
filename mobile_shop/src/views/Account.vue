<template>
  <div class="account">
    <van-nav-bar title="订单详情" left-text left-arrow @click-left="$router.back()" />
    <!-- 联系人卡片 -->
    <van-cell-group>
      <van-cell
        class="cell"
        :title="addressList.name"
        :label="addressList.address"
        @click="$router.push('/site')"
      >
        <div slot="default" class="tel">{{addressList.tel}}</div>
      </van-cell>
    </van-cell-group>
    <!-- 商品 -->
    <van-panel title="供应商：合泰文化">
      <div>
        <van-card
          v-for="(item, index) in payList"
          :key="index"
          :num="item.count"
          :price="item.price"
          :desc="item.standards"
          :title="item.goods_name"
          :thumb="item.path"
        />
      </div>
    </van-panel>
    <van-panel title="总价" :status="'￥'+ totalPrice"></van-panel>
    <!-- 付款 -->
    <van-submit-bar :price="totalPrice * 100" button-text="提交订单" @submit="postOrder">
      <span class="count">共计:{{sum}} 件</span>
    </van-submit-bar>

    <!-- 支付弹出层 -->
    <van-popup v-model="show" closeable close-icon-position="top-left" @close="closePay">
      <h3 class="title">钱包支付</h3>
      <van-row class="name" type="flex" justify="center">
        <van-col span="15">{{this.payList.goods_name}}</van-col>
      </van-row>
      <!-- 价格 -->
      <van-row type="flex" class="price" justify="center">
        <van-col span="15">
          <h1>￥{{this.totalPrice}}</h1>
        </van-col>
      </van-row>
      <!-- 微信支付 -->
      <van-row type="flex" class="icon" justify="left">
        <van-col span="15">
          <van-cell title="钱包支付" icon="balance-o" />
        </van-col>
      </van-row>
      <!-- 提交支付 -->
      <van-row type="flex" class="pay" justify="center">
        <van-col span="20">
          <van-button type="info" size="large" @click="subPay">确定支付</van-button>
        </van-col>
      </van-row>
    </van-popup>
    <!-- 支付密码输入 -->
    <!-- 密码输入框 -->
    <van-popup v-model="passNum">
      <van-password-input :value="pass" info="密码为 6 位数字" :focused="showKeyboard" @focus="subPass" />

      <!-- 数字键盘 -->
      <van-number-keyboard
        :show="showKeyboard"
        @input="onInput"
        @delete="onDelete"
        @blur="showKeyboard = false"
      />
    </van-popup>
  </div>
</template>

<script>
export default {
  data () {
    return {
      // 键盘密码
      pass: '',
      showKeyboard: false,
      passNum: false,
      // 购物车数组
      payList: [],
      // 总价
      totalPrice: 0,
      // 件数
      sum: 0,
      // 地址信息
      addressList: {},
      // 是否显示支付
      show: false,
      // 订单号
      sn: 0
    }
  },
  methods: {
    // 数字键盘
    onInput (key) {
      this.pass = (this.pass + key).slice(0, 6)
      // 获取密码
      let payPassword = '123456'
      let id = window.localStorage.getItem('id')

      if (this.pass.length === 6) {
        this.$http.get(`user?id=${id}`).then(res => {
          payPassword = res.data.data[0].paypsd
          // console.log(payPassword, '111')
          if (payPassword === null || payPassword.length !== 6) {
            this.$toast('请设置支付密码')
            // console.log(payPassword)

            this.$router.push('/setting')
          } else {
            if (this.pass === payPassword) {
              let id = window.localStorage.getItem('id')
              this.$http.get(`/user/?id=${id}`).then(res => {
                // console.log(res)
                let money = res.data.data[0].money
                if (money < this.totalPrice) {
                  this.$toast('余额不足,请充值！')
                  this.show = false
                  return false
                } else {
                  this.money = res.data.data[0].money - this.totalPrice
                  let goodsList = []
                  for (let i = 0; i < this.payList.length; i++) {
                    let goods = {}
                    goods.goods_id = this.payList[i].goods_id
                    goods.count = this.payList[i].count
                    goodsList.push(goods)
                  }
                  let list = {
                    user_id: window.localStorage.getItem('id'),
                    totalPrice: this.money,
                    goods: goodsList
                  }
                  this.$http.post('/pay', list).then(res => {
                    if (res.data.ok !== 1) {
                      this.$toast('支付失败！')
                      return false
                    } else {
                      let status = {
                        status: 1,
                        sn: this.sn
                      }
                      // 根据id删除勾选的商品
                      for (let i = 0; i < this.payList.length; i++) {
                        this.$http
                          .delete(`/cart/${this.payList[i].id}`)
                          .then(res => {})
                      }
                      // 改变订单状态
                      this.$http.put('/status', status, res => {
                        this.$toast(res)
                        // console.log(status)
                      })
                      this.$toast('支付成功！')

                      this.show = false
                      this.$router.push('/')
                    }
                  })
                }
              })
            } else {
              this.$toast('支付密码错误')
              this.pass = ''
              this.passNum = false
              return false
            }
          }
        })
      }
    },
    onDelete () {
      this.pass = this.pass.slice(0, this.pass.length - 1)
    },
    //   获取收货人信息
    getAddress () {
      let id = localStorage.getItem('id')
      this.$http.get(`/address/${id}`).then(res => {
        res.data.data.forEach(v => {
          if (v.isDefault === 1) {
            v.address =
              v.province +
              '|' +
              v.city +
              '|' +
              v.county +
              '|' +
              v.addressDetail
            this.addressList = v
          }
        })
      })
    },
    // 提交订单
    postOrder () {
      this.show = true
      let cartList = []
      for (let i = 0; i < this.payList.length; i++) {
        let cart = {}
        cart.goods_id = this.payList[i].goods_id
        cart.count = this.payList[i].count
        cartList.push(cart)
      }
      let order = {
        address_id: this.addressList.id,
        cart: cartList
      }
      this.$http.post('/stock', order).then(res => {
        if (res.data.ok !== 1) {
          this.$toast('请添加收货地址！！！')
          this.$router.push('/addsite')
          return false
        } else {
          this.sn = res.data.data
          // console.log(this.sn)

          this.show = true
        }
      })
    },
    // 确定支付
    subPay () {
      // console.log('1')
      this.passNum = true
      this.showKeyboard = true
      this.show = false

      // let id = window.localStorage.getItem('id')
      // this.$http.get(`/user/?id=${id}`).then(res => {
      //   console.log(res)
      //   let money = res.data.data[0].money
      //   if (money < this.totalPrice) {
      //     this.$toast('余额不足,请充值！')
      //     this.show = false
      //     return false
      //   } else {
      //     this.money = res.data.data[0].money - this.totalPrice
      //     let goodsList = []
      //     for (let i = 0; i < this.payList.length; i++) {
      //       let goods = {}
      //       goods.goods_id = this.payList[i].goods_id
      //       goods.count = this.payList[i].count
      //       goodsList.push(goods)
      //     }
      //     let list = {
      //       user_id: window.localStorage.getItem('id'),
      //       totalPrice: this.money,
      //       goods: goodsList
      //     }
      //     this.$http.post('/pay', list).then(res => {
      //       if (res.data.ok !== 1) {
      //         this.$toast('支付失败！')
      //         return false
      //       } else {
      //         let status = {
      //           status: 1,
      //           sn: this.sn
      //         }
      //         // 根据id删除勾选的商品
      //         for (let i = 0; i < this.payList.length; i++) {
      //           this.$http.delete(`/cart/${this.payList[i].id}`).then(res => {})
      //         }
      //         // 改变订单状态
      //         this.$http.put('/status', status, (res) => {
      //           this.$toast(res)
      //         })
      //         this.$toast('支付成功！')

      //         this.show = false
      //         this.$router.push('/')
      //       }
      //     })
      //   }
      // })
    },
    closePay () {},
    subPass () {
      if (this.pass.length === 6) {
        // console.log(this.pass)
      }
    }
  },
  created () {
    // 获取收货人信息
    this.getAddress()
    // 从浏览器拿出数据
    let shopList = JSON.parse(localStorage.getItem('shopList'))
    this.payList = shopList
    for (let i = 0; i < this.payList.length; i++) {
      this.totalPrice += this.payList[i].count * this.payList[i].price
      this.sum += this.payList[i].count
    }
  }
}
</script>

<style lang="less" scoped>
.account {
  .van-popup {
    .van-password-input {
      margin-top: 20px;
    }
    width: 90%;
    height: 335px;
    border-radius: 12px;
    .title {
      text-align: center;
      line-height: 15px;
    }
    .name {
      border-top: 1px solid #e0e0e0;
      background-color: #f5f5f5;
      text-align: center;
      padding-top: 12px;
    }
    .price {
      border-bottom: 1px solid #e0e0e0;
      background-color: #f5f5f5;
      text-align: center;
    }
    .icon {
      border-bottom: 1px solid #e0e0e0;
      .van-cell__title {
        font-size: 24px;
      }
      .van-cell__left-icon,
      .van-cell__right-icon {
        font-size: 24px;
        color: #f4d313;
      }
    }
    .pay {
      margin-top: 40px;
      margin-bottom: 30px;
    }
  }
  .tel {
    color: #000;
  }
  .account .van-cell__label {
    width: 144%;
  }
  .van-cell-group {
    margin-bottom: 5px;
  }
  .cell::before {
    position: absolute;
    right: 0;
    bottom: 0;
    left: 0;
    height: 2px;
    background: -webkit-repeating-linear-gradient(
      135deg,
      #ff6c6c 0,
      #ff6c6c 20%,
      transparent 0,
      transparent 25%,
      #1989fa 0,
      #1989fa 45%,
      transparent 0,
      transparent 50%
    );
    background: repeating-linear-gradient(
      -45deg,
      #ff6c6c 0,
      #ff6c6c 20%,
      transparent 0,
      transparent 25%,
      #1989fa 0,
      #1989fa 45%,
      transparent 0,
      transparent 50%
    );
    background-size: 80px;
    content: "";
  }
  .cell {
    color: #333333;
    font-size: 18px;
  }

  .van-cell__label {
    width: 80%;
    margin-top: 3px;
    color: #969799;
    font-size: 12px;
    line-height: 18px;
    margin-left: 46px;
  }
  .cell .van-cell__value[data-v-e8599b44] {
    position: relative;
    overflow: hidden;
    color: #333333;
    text-align: left;
    margin-left: -255px;
    vertical-align: middle;
  }
  .van-submit-bar {
    z-index: 2000;
  }
  .van-button--danger {
    color: #333333;
    background-color: #ffd54f;
    border: 1px solid #ffd54f;
  }
  .count {
    font-size: 14px;
    color: #323233;
    margin-left: 10px;
  }
}
</style>

<style lang="less">
.pay {
  .van-popup {
    border-radius: 12px;
  }
}
</style>
