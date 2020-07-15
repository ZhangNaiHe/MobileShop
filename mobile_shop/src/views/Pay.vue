<template>
  <div class="pay">
    <!-- 联系人卡片 -->
    <van-nav-bar title="订单详情" left-text left-arrow @click-left="$router.back()" />
    <van-cell-group>
      <van-cell
        class="cell"
        :title="addressList.name"
        :value="addressList.tel"
        :label="addressList.address"
        @click="$router.push('/site')"
      />
    </van-cell-group>
    <!-- 商品 -->
    <van-panel title="供应商：合泰文化">
      <div>
        <van-card
          :num="cartList.count"
          :price="goodsList.price"
          :desc="cartList.standards"
          :title="goodsList.name"
          :thumb="goodsList.path"
        />
      </div>
    </van-panel>

    <van-panel title="总价" :status="'￥'+(this.cartList.count*this.goodsList.price)"></van-panel>
    <!-- 付款 -->
    <van-submit-bar
      :price="(this.cartList.count*this.goodsList.price)*100"
      button-text="立即付款"
      @submit="postOrder"
    >
      <span class="count">共计:{{this.cartList.count}}件</span>
    </van-submit-bar>
    <!-- 支付弹出层 -->

    <van-popup v-model="show" closeable close-icon-position="top-left" @close="closePay">
      <h3 class="title">钱包支付</h3>
      <van-row class="name" type="flex" justify="center">
        <van-col span="15">{{this.goodsList.goods_name}}</van-col>
      </van-row>
      <!-- 价格 -->
      <van-row type="flex" class="price" justify="center">
        <van-col span="15">
          <h1>￥{{(this.cartList.count*this.goodsList.price)}}</h1>
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
    <!-- 支付密码 -->
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
      pass: '',
      showKeyboard: false,
      passNum: false,
      // pass: '1',
      // showKeyboard: true,
      show: false,
      cartList: JSON.parse(window.sessionStorage.getItem('cartList')),
      // 地址信息
      addressList: {},
      // 商品信息
      goodsList: [],
      money: 0,
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
                let totalPrice = this.cartList.count * this.goodsList.price
                if (money < totalPrice) {
                  this.$toast('余额不足,请充值！')
                  this.show = false
                  return false
                } else {
                  this.money = res.data.data[0].money - totalPrice
                  let list = {
                    user_id: window.localStorage.getItem('id'),
                    totalPrice: this.money,
                    goods: [
                      {
                        goods_id: this.goodsList.id,
                        count: this.cartList.count
                      }
                    ]
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
                      // 改变订单状态
                      this.$http.put('/status', status, res => {
                        // this.$toast(res)
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
      // console.log(this.cartList.user_id)

      this.$http.get(`/address/${this.cartList.user_id}`).then(res => {
        //   console.log(res)
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
        // console.log(this.addressList)
      })
    },
    //  获取商品信息
    getGoods () {
      // console.log(this.cartList)
      this.$http.get(`/product/${this.cartList.goods_id}`).then(res => {
        // console.log(res)
        this.goodsList = res.data.data[0]
        this.goodsList.path = res.data.path[0].path
        // console.log(this.goodsList)
      })
    },

    // 提交订单
    postOrder () {
      this.show = true
      if (this.sn === 0) {
        let order = {
          // 已支付
          address_id: this.addressList.id,
          cart: [
            {
              goods_id: this.goodsList.id,
              count: this.cartList.count
            }
          ]
        }

        this.$http.post('/stock', order).then(res => {
          if (res.data.ok !== 1) {
            this.$toast('请添加购物地址！！')
            this.$router.push('/addsite')
          } else {
            this.sn = res.data.data
            // console.log(this.sn)
          }
        })
      } else {
        return false
      }
    },
    subPay () {
      this.passNum = true
      this.showKeyboard = true
      this.show = false
      // let id = window.localStorage.getItem('id')
      // this.$http.get(`/user/?id=${id}`).then(res => {
      //   console.log(res)
      //   let money = res.data.data[0].money
      //   let totalPrice = this.cartList.count * this.goodsList.price
      //   if (money < totalPrice) {
      //     this.$toast('余额不足,请充值！')
      //     this.show = false
      //     return false
      //   } else {
      //     this.money = res.data.data[0].money - totalPrice
      //     let list = {
      //       user_id: window.localStorage.getItem('id'),
      //       totalPrice: this.money,
      //       goods: [{ goods_id: this.goodsList.id, count: this.cartList.count }]
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
      //         // 改变订单状态
      //         this.$http.put('/status', status, res => {
      //           // this.$toast(res)
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
    // console.log(this.cartList)
    this.getAddress()
    this.getGoods()
  }
}
</script>

<style lang="less" scoped>
// 弹出层

// 数字键盘

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
  margin-left: -225px;
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
</style>
