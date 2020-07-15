<template>
  <div class="order">
    <!-- 导航栏 -->
    <van-nav-bar title="我的订单" left-arrow @click-left="$router.back()" />
    <!-- Tab标签页 -->
    <van-tabs
      @click="orderChange"
      v-model="active"
      line-height="2px"
      line-width="12px"
      :swipe-threshold="8"
    >
      <van-tab title="全部" name="-1"></van-tab>
      <van-tab class="pay" title="待付款" name="0"></van-tab>
      <van-tab title="待发货" name="1"></van-tab>
      <van-tab title="待收货" name="2"></van-tab>
      <van-tab title="待评价" name="3"></van-tab>
    </van-tabs>
    <!-- 内容部分 -->
    <div class="content">
      <!-- 有商品时显示的内容 -->
      <div v-for="(item,index) in orderLists" :key="index" class="orderCard">
        <van-popup v-model="shows">
          <!-- 密码输入框 -->
          <van-password-input
            :value="value"
            info="密码为 6 位数字"
            :focused="showKeyboard"
            @focus="showKeyboard = true"
            disabled
          />

          <!-- 数字键盘 -->
          <van-number-keyboard
            :show="showKeyboard"
            @input="onInput"
            @delete="onDelete"
            @blur="showKeyboard = false"
          />
        </van-popup>

        <van-card
          v-for="(item2, index2) in item.goods"
          :key="index2"
          :num="item2.buy_count"
          :title="item2.goods_name"
          :thumb="item2.goods_image"
          @click="$router.push('/product/'+item2.goods_id)"
        >
          <!-- 自定义价格 -->
          <div class="price" slot="price">￥{{item2.price}}.00</div>
          <van-tag slot="footer" plain round size="medium" class="bianq">本店不支持退换货</van-tag>
        </van-card>
        <span class="order-span">
          共{{item.goods.length}}件商品 合计:￥
          <i class="total_price">{{item.total_price}}</i>
        </span>
        <br />
        <br />
        <van-button
          round
          type="info"
          class="status"
          v-if="item.status == 0"
          @click="payment(item.id,item.status,item.total_price,item.user_id)"
        >去付款</van-button>
        <van-popup v-model="show" closeable close-icon-position="top-left">
          <div class="total_prices">
            ￥
            <span>{{total_price}}</span>
          </div>
          <div class="phone-row">
            <van-row type="flex" justify="space-between">
              <van-col span="8">账号</van-col>
              <van-col span="8">{{phone}}</van-col>
            </van-row>
            <van-row type="flex" justify="space-between">
              <van-col span="6">付款方式</van-col>
              <van-col span="6">钱包支付&nbsp;</van-col>
            </van-row>
          </div>
          <!-- 提交支付 -->
          <van-row type="flex" class="pay" justify="center">
            <van-col span="20">
              <van-button type="info" size="large" @click="dakd">确定支付</van-button>
            </van-col>
          </van-row>
        </van-popup>

        <van-button round type="info" class="status" disabled v-if="item.status == 1">等待发货</van-button>
        <van-button
          round
          type="info"
          class="status"
          v-if="item.status == 2"
          @click="delivery(item.user_id,item.status,item.id)"
          color="#ff7600"
        >确认收货</van-button>
        <van-button
          round
          type="info"
          class="status"
          v-if="item.status == 3"
          :to="{path:'/addComment',query:{data:item}}"
        >去评价</van-button>
        <van-button round type="info" class="status" v-if="item.status == 4" color="#ff3b00" plain>已完成</van-button>
      </div>
      <!-- 没商品时显示的内容 -->
      <div class="no_order" v-if="!orderLists[0]">
        <div class="icon"></div>
        <p class="none">暂时还没有订单哦 ~</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      active: '-1',
      // 订单列表
      orderList: [],
      orderLists: [],
      // 展示商品列表
      showList: [],
      user_id: '',
      show: false,
      phone: localStorage.getItem('phone'),
      value: '',
      showKeyboard: true,
      shows: false,
      or_id: '',
      status: '',
      total_price: '',
      userID: '',
      userList: {
        money: 0,
        paypsd: ''
      }
    }
  },
  methods: {
    // tab切换时按照状态分类
    orderChange (index) {
      // index与name相对应，name表示状态对应的数字
      if (index === '-1') {
        this.orderLists = [...this.orderList]
        return
      }

      let newList = [...this.orderList]
      // 清空
      this.orderLists = []
      // 循环
      newList.forEach(item => {
        // 如果状态与索引对应
        if (item.status === Number(index)) {
          this.orderLists.push(item)
        }
      })
    },
    payment (id, status, totalprice, userID) {
      this.show = true
      this.or_id = id
      this.total_price = totalprice
      this.status = status
      this.userID = userID
      // console.log(this.or_id);
    },
    async onInput (key) {
      this.value = (this.value + key).slice(0, 6)
      // console.log(this.value)

      if (this.value.length === 6) {
        if (this.value === this.userList.paypsd) {
          // console.log(this.money,this.total_price);
          if (this.userList.money >= this.total_price) {
            // eslint-disable-next-line no-unused-vars
            let { data: res } = await this.$http.put(`/payment/${this.or_id}`, {
              status: this.status
            })
            // 用户支付
            let money = this.userList.money - this.total_price
            this.$http
              .put(`/userly/${this.user_id}`, {
                money: money
              })
              .then(res => {
                // console.log(res.data.code);
                if (res.data.code !== 200) {
                  return this.$toast.fail('支付失败')
                }
                this.$toast.success('支付成功')
                this.shows = false
                this.value = ''
                this.active = '1'
                this.orderLists = []
                this.getOrderData()
              })
          } else {
            this.$toast.fail('余额不足！请充值!')
            this.$router.push('/setting')
          }
        } else {
          this.$toast.fail('密码错误！请重新输入')
          this.value = ''
        }
      }
    },
    // eslint-disable-next-line camelcase
    async delivery (id, status, or_id) {
      // console.log(id,status,or_id);
      // eslint-disable-next-line no-unused-vars
      // eslint-disable-next-line camelcase
      // eslint-disable-next-line no-unused-vars
      // eslint-disable-next-line camelcase
      let { data: res } = await this.$http.put(`/payment/${or_id}`, {
        status: status
      })
      console.log(res)
      this.$toast.success('收货成功')
      this.active = '3'
      this.orderLists = []
      this.getOrderData()
    },
    onDelete () {
      this.value = this.value.slice(0, this.value.length - 1)
    },
    dakd () {
      this.shows = true
      this.show = false
    },
    getOrderData () {
      this.$http.get(`/order/${this.user_id}`).then(res => {
        this.orderList = res.data.ordersList
        // console.log(res.data)

        this.showList = res.data.goods_orderlist
        // console.log(this.showList)
        // console.log(this.orderList)

        this.orderList.forEach(item => {
          item.goods = []
          this.showList.findIndex(item2 => {
            if (item.id === item2.order_id) {
              item.goods.push(item2)
            }
          })
        })
        // console.log(this.orderList);
        // // 判断状态 根据状态分类
        if (this.active === '-1') {
          this.orderLists = [...this.orderList]
          return
        }
        let newList = [...this.orderList]
        newList.forEach(v => {
          if (JSON.stringify(v.status) === this.active) {
            this.orderLists.push(v)
          }
        })
      })
    }
  },
  created () {
    // 给tableBar发送现在在哪个页面
    this.$emit('getTo', 0)
    this.user_id = window.localStorage.id
    // 接收路由参数
    this.active = this.$route.query.id
    // 全部商品信息接口
    this.getOrderData()

    this.$http.get(`/user/?id=${this.user_id}`).then(res => {
      this.userList = res.data.data[0]
      //  console.log(this.userList);
    })
  }
}
</script>

<style lang="less" scoped>
.order {
  .content {
    background-color: #f3f4f6;
    padding-bottom: 20px;
  }
  // margin-bottom: 50px;
  .van-image .van-image__img {
    border: 1px solid #f2f3f5;
    border-radius: 7px;
  }
  .phone-row {
    margin-top: 130px;
    margin: 150px 0px 20px 20px;
  }
  .van-row {
    margin-bottom: 20px;
  }
  background-color: #f3f4f6;
  .van-tabs {
    .van-tab {
      line-height: 33px;
    }
    .van-ellipsis {
      font-size: 11px;
    }
  }

  .van-card {
    background-color: #fff;
    margin: 0px;
    border-bottom: 0px;
    margin-bottom: -5px;
    padding-top: 12px;
  }
  .van-tabs__nav--line {
    padding-bottom: 11.5px;
  }

  .van-tabs--line .van-tabs__wrap {
    height: 33px;
  }

  .price {
    position: absolute;
    top: -1px;
    right: -1px;
    color: #414040;
  }

  .van-button--small {
    padding: 0 13px;
    height: 25px;
    line-height: 23px;
  }

  .bianq {
    position: relative;
    top:-12px;
  }

  .all-price {
    font-size: 14px;
    color: #f7545f;
  }

  .icon {
    margin: 100px auto auto;
    width: 45px;
    height: 50px;
    background-position: 105px 653px;
    background-image: url(/img/ico-mall.3e317044.png);
    background-size: 380px 484px;
  }

  .none {
    font-size: 13px;
    color: #9e9e9e;
  }

  .no_order {
    text-align: center;
  }
  .orderCard {
    width: 95%;
    margin: 0px auto;
    border: 1px solid white;
    border-radius: 12px;
    margin-bottom: 7px;
    margin-top: 10px;
    overflow: hidden;
    background-color: white;
    border: 1px solid #9be155;
  }
  .order-span {
    float: right;
    margin-bottom: 5px;
    margin-right: 15px;
  }
  .status {
    border: 1px solid;
    float: right;
    margin-bottom: 15px;
    margin-right: 15px;
    height: 30px;
    line-height: 28px;
    background-color: white;
    color: orange;
  }
  .total_price {
    font-style: normal;
    font-size: 20px;
  }
  .van-popup {
    width: 90%;
    height: 370px;
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
      margin-top: 20px;
    }
  }
  .total_prices {
    position: absolute;
    top: 70px;
    left: 142px;
    font-weight: bold;
    span {
      font-size: 35px;
      font-weight: 500;
    }
  }
  .van-button--large {
    position: absolute;
    bottom: 15px;
    left: 17px;
    width: 90%;
  }
}
</style>

<style lang="less">
html,
body,
#app,
.order {
  height: 100%;
}
.order .van-image .van-image__img {
  border: 1px solid #e3e3e3;
  border-radius: 7px;
}
</style>
