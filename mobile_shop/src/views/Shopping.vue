<template>
  <div class="shopping">
    <!-- 内容区域 -->
    <div class="content">
      <!-- 购物车没内容时显示 -->
      <van-nav-bar title="购物车" />
      <div class="no_cart" v-if="!shoppingList[0]">
        <div class="cart-icon"></div>
        <p class="none">购物车好空呀，快去选购吧 ~</p>
        <van-button round size="small" color="#9be155" class="visit" to="/">去逛逛</van-button>
      </div>
      <!-- 购物车有内容时显示 -->
      <div class="iscart" v-else>
        <van-checkbox
          checked-color="#9be155"
          v-for="(item, index) in shoppingList"
          @change="changeIschk(item.id, index)"
          :key="index"
          v-model="item.ischk"
          class="check-solid"
          :label-disabled="true"
        >
          <van-card
            :price="item.price"
            :title="item.goods_name"
            :desc="item.standards"
            :thumb="item.path"
          >
            <van-icon
              slot="bottom"
              :size="21"
              name="delete"
              class="delete"
              @click="deleteCart(item.id)"
            />
            <!-- 自定义数量部分 -->
            <van-stepper
              slot="num"
              @change="changeNum(item.id, index)"
              v-model="item.count"
              input-width="28px"
              button-size="22px"
            />
          </van-card>
        </van-checkbox>
        <van-submit-bar :price="totalPrice" color="#9be155" button-text="去结算" @submit="onSubmit">
          <van-checkbox checked-color="#9be155" v-model="allChk">全选</van-checkbox>
        </van-submit-bar>
      </div>
    </div>
    <!-- 推荐商品部分 -->
    <van-divider
      :style="{ color: 'black', borderColor: 'black', padding: '0 120px', fontSize: '17px'}"
    >为你推荐</van-divider>
    <van-grid class="rec_goods" :column-num="2" :gutter="5">
      <van-grid-item
        v-for="(item, index) in recommendList"
        :key="index"
        route
        :to="'/product/'+item.id"
      >
        <!-- 自定义图标（插槽） -->
        <div slot="icon">
          <van-image :class="item.inventory == 0 ? 'no_goods' : ''" :src="item.imgSrc"></van-image>
        </div>
        <!-- 自定义文字 -->
        <div slot="text" style="width:100%;padding:10px 10px;box-sizing:border-box">
          <div class="title">{{item.goods_name}}</div>
          <div class="price">
            <span class="now_price">￥{{item.price}}</span>
            <span class="old_price">￥{{item.price}}</span>
          </div>
        </div>
      </van-grid-item>
    </van-grid>
  </div>
</template>

<script>
export default {
  data () {
    return {
      // 推荐商品数组
      recommendList: [],
      // 购物车数组
      shoppingList: []
    }
  },
  methods: {
    // 点击结算按钮
    onSubmit () {
      let newList = this.shoppingList
      let list = []
      // 遍历数组
      for (var i = 0; i < newList.length; i++) {
        if (newList[i].ischk === true || newList[i].ischk === 1) {
          // 存数组
          list.push(newList[i])
          // 跳转页面
          this.$router.push('/account')
        }
      }
      if (!list[0]) {
        // 必须要勾选一个
        this.$dialog.alert({
          message: '您至少要选择一样商品结算'
        })
      }
      // 保存到浏览器
      localStorage.setItem('shopList', JSON.stringify(list))
    },
    // 购物车商品
    shopGoods () {
      let id = localStorage.getItem('id')
      this.$http
        .get(`/cart/${id}`)
        .then(res => {
          console.log(res)
          this.shoppingList = res.data.data
          if (this.shoppingList.length > 0) {
            // 刚渲染页面时就赋值给 复选框
            this.shoppingList.forEach(v => {
              if (v.ischk === 0) {
                v.ischk = false
              } else if (v.ischk === 1) {
                v.ischk = true
              }
            })
          }
        })
        .catch(e => {})
    },
    // 数量改变时触发的方法
    changeNum (id, index) {
      this.$http.put(`/cart/${id}`, this.shoppingList[index]).then(res => {})
    },
    // 是否选中时触发的方法
    changeIschk (id, index) {
      this.$http.put(`/ischk/${id}`, this.shoppingList[index]).then(res => {})
    },
    // 删除
    deleteCart (id) {
      this.$http.delete(`/cart/${id}`).then(res => {
        if (res.data.ok === 1) {
          // 刷新页面
          this.shopGoods()
          // 删除成功
          this.$toast('删除购物车商品成功')
        }
      })
    }
  },
  created () {
    this.$emit('getTo', 'shopping')
    // 购物车商品
    this.shopGoods()
    this.shoppingList.forEach(v => {
      if (v.ischk === 0 || v.ischk === 'fales') {
        v.ischk = false
      } else {
        v.ischk = true
      }
    })
    this.allChk = false
    // 推荐商品
    this.$http
      .get('/goodsCart')
      .then(res => {
        // 循环商品，找到与商品id对应的图片路径
        res.data.goods.forEach(good => {
          let index = res.data.img.findIndex(item => item.goods_id === good.id)
          good.imgSrc = res.data.img[index].path
        })
        this.recommendList = res.data.goods
      })
      .catch(e => {})
  },
  computed: {
    // 总价
    totalPrice: function () {
      let sum = 0
      // 循环所有商品
      this.shoppingList.forEach(v => {
        // 如果勾选就把价格加到总价上
        if (v.ischk) {
          sum += v.price * v.count
        }
      })
      // 返回结果 (默认是分为单位，所有转化成元 *100)
      return sum * 100
    },
    // 全选
    allChk: {
      // get 获取， set 设置
      // 遍历商品
      get: function () {
        if (this.shoppingList.length > 0) {
          for (let i = 0; i < this.shoppingList.length; i++) {
            // 只要有一个没勾选就返回false
            if (
              this.shoppingList[i].ischk === false ||
              this.shoppingList[i].ischk === 0
            ) {
              return false
            }
          }
          // 否则返回true
          return true
        }
        return false
      },
      // 当点击全选按钮这个函数就被调用 参数：勾选之后的值
      set: function (newValue) {
        this.shoppingList.forEach(v => {
          // 判断商品不为null时修改勾选状态的值
          if (v !== null) {
            v.ischk = newValue
          }
        })
      }
    }
  }
}
</script>

<style lang="less" scoped>
.shopping {
  padding-top: 47px;
  padding-bottom: 54px;
  .cart-icon {
    margin: 80px auto auto;
    width: 56px;
    height: 53px;
    background-position: 379px 598px;
    background-image: url(/img/ico-mall.3e317044.png);
    background-size: 380px 484px;
  }

  .delete {
    position: relative;
    top: -60px;
    right: -155px;
    color: #737372;
  }

  .none {
    font-size: 13px;
    color: #9e9e9e;
  }

  .no_cart {
    text-align: center;
  }

  .visit {
    padding: 0 30px;
  }

  .van-grid-item__content {
    margin-bottom: 31px;
  }

  .now_price {
    color: #f75e68;
  }

  .van-card {
    background-color: #fff;
    margin-top: 10px;
    padding: 10px 5px;
  }

  .van-card__thumb {
    border: 1px solid #e5e5e5;
  }

  .iscart {
    border-bottom: 20px solid #f3f4f6;
  }

  .van-card__num {
    position: relative;
    right: -80px;
    bottom: -30px;
  }

  .van-card__price {
    margin-top: 29px;
    font-size: 13px;
  }

  .van-stepper__input {
    background-color: #fff;
    border: 1px solid #f1f1f1;
  }

  .van-submit-bar {
    position: static;
    height: 50px;
  }

  .check-solid {
    border-bottom: 3px solid #f3f4f6;
  }

  .van-button--danger {
    color: #4c4736;
    background-color: #9be155;
    border: none;
  }

  .van-submit-bar__bar {
    font-size: 13px;
  }

  .van-submit-bar__price {
    font-size: 16px;
  }

  .shopping .van-button--danger {
    font-size: 13.5px;
  }
}

.van-grid-item__content--center {
  padding: 0px;
}
.price {
  .now_price {
    font-size: 18px;
    color: #f7606a;
  }
  .old_price {
    color: #999999;
    text-decoration: line-through;
  }
}
.ico-mall {
  position: absolute;
  top: 0;
  right: 10px;
  width: 30px;
  height: 30px;
  font-size: 10px;
  color: #333;
  text-align: center;
  font-weight: 500;
  display: table;
  background: url(/img/ico-mall.3e317044.png);
  background-size: 23rem 32rem;
  background-position: -4.3rem -25.3rem;
  line-height: 23px;
}
.van-nav-bar {
  font-size: 19px;
  background: #9be155;
  position: fixed;
  top: 0px;
  left: 0px;
  width: 100%;
}
.van-nav-bar__title {
  font-size: 19px;
}
</style>

<style >
.van-checkbox__icon {
  margin-left: 10px;
}
.van-card__title {
  width: 120px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  display: inline;
}
</style>
