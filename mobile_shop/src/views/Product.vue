
<template>
  <div class="goods">
    <!-- 顶部导航 -->
    <van-nav-bar left-arrow @click-left="$router.back()" @click-right="$router.push('/shopping')">
      <template slot="title">
        <ul class="title">
          <li
            @click="anchor(item.to)"
            v-for="(item,index) in goodsFun"
            :key="index"
            :class="{'colordisplay':display}"
          >{{item.name}}</li>
        </ul>
      </template>
      <van-icon name="shopping-cart-o" slot="right" size="20" color="black" />
    </van-nav-bar>
    <!-- 轮播图 -->
    <van-swipe class="goods-swipe" :autoplay="3000" indicator-color="white" id="shangpin">
      <van-swipe-item v-for="(item,index) in goods.thumb" :key="index">
        <img :src="item.path" />
      </van-swipe-item>
    </van-swipe>
    <!-- 售价、销量 -->
    <van-cell-group>
      <van-cell>
        <div class="goods-title">{{ goods.goods_name }}</div>
        <div class="goods-price">
          &yen;&nbsp;{{ goods.price }}
          <a>已售:{{goods.total_sale}}件</a>
        </div>
      </van-cell>
    </van-cell-group>
    <!-- 保障 -->
    <van-cell-group class="goods-cell-group">
      <van-cell id="pingjia">
        <template slot="title">
          <ul class="qa_icon">
            <li class="li_one">
              <div></div>官方周边
            </li>
            <li class="li_two">
              <div></div>售后保障
            </li>
          </ul>
        </template>
      </van-cell>
    </van-cell-group>
    <!-- 用户评价 -->
    <van-cell-group class="goods-cell-group">
      <van-cell icon="arrow-left" @click="getComment(goods.id)">
        <template slot="title">用户评价({{totalnum(total) }})</template>
        <template slot="default">
          <div>
            综合评分
            <van-rate v-model="start" readonly size="12px" />
          </div>
        </template>
      </van-cell>
    </van-cell-group>
    <!-- 商品图片 -->
    <div id="xiangqing">
      <van-image width="100%" v-for="(item,index) in  goodsImg" :key="index" :src="item.path" />
    </div>
    <!-- 底部导航 （加入购物车、购买） -->
    <van-goods-action>
      <van-goods-action-icon icon="shop-o" @click="onClickCart">首页</van-goods-action-icon>
      <van-goods-action-icon icon="service-o" @click="sorry">客服</van-goods-action-icon>

      <van-goods-action-button type="warning" color="#333333" @click="postCart">加入购物车</van-goods-action-button>
      <van-goods-action-button type="danger" color="#ffd54f" @click="postCart">立即购买</van-goods-action-button>
    </van-goods-action>
    <!-- 商品规格 -->
    <!-- 基础用法 -->
    <div class="sku-container">
      <van-sku
        v-model="showBase"
        :sku="skuData.sku"
        :goods="skuData.goods_info"
        :goods-id="skuData.goods_id"
        :hide-stock="skuData.sku.hide_stock"
        :quota="skuData.quota"
        :quota-used="skuData.quota_used"
        :initial-sku="initialSku"
        reset-stepper-on-hide
        reset-selected-sku-on-hide
        disable-stepper-input
        :close-on-click-overlay="closeOnClickOverlay"
        :custom-sku-validator="customSkuValidator"
        @buy-clicked="onBuyClicked"
        @add-cart="onAddCartClicked"
      />
      <!-- <van-button block type="primary" @click="showBase = true">xxx</van-button> -->
    </div>
  </div>
</template>

<script>

export default {

  data () {
    return {
      // 商品规格
      skuData: {
        sku: {
          // 所有sku规格类目与其值的从属关系，比如商品有颜色和尺码两大类规格，颜色下面又有红色和蓝色两个规格值。
          // 可以理解为一个商品可以有多个规格类目，一个规格类目下可以有多个规格值。
          tree: [
            // {
            //   k: '型号',
            //   k_id: '1',
            //   v: [
            //     {
            //       id: '30349',
            //       name: '常规'
            //     }
            //   ],
            //   k_s: 's1',
            //   count: 2
            // },
            // {
            //   k: '规格',
            //   k_id: '2',
            //   v: [
            //     {
            //       id: '1193',
            //       name: '常规'
            //     },
            //     {
            //       id: '1192',
            //       name: '不常规'
            //     }
            //   ],
            //   k_s: 's2',
            //   count: 2
            // }
          ],
          // 所有 sku 的组合列表，如下是：白色1、白色2、天蓝色1、天蓝色2
          list: [
            // {
            //   id: 2257,
            //   price: 130,
            //   discount: 132,
            //   s1: '30349',
            //   s2: '1193',
            //   s3: '0',
            //   s4: '0',
            //   s5: '0',
            //   stock_num: 10, // 库存
            //   goods_id: 946755
            // },
            // {
            //   id: 2258,
            //   price: 130,
            //   discount: 132,
            //   s1: '30349',
            //   s2: '1192',
            //   s3: '0',
            //   s4: '0',
            //   s5: '0',
            //   stock_num: 60, // 库存
            //   goods_id: 946755
            // }
          ],
          price: '5.00',
          stock_num: 300, // 商品总库存
          none_sku: true, // 是否无规格商品
          hide_stock: false // 是否隐藏剩余库存
        },
        goods_id: '946755',
        // quota: 3, // 限购数量
        quota_used: 0, // 已经购买过的数量
        goods_info: {
          title: '测试商品A',
          picture:
            'https://img.yzcdn.cn/upload_files/2017/03/16/Fs_OMbSFPa183sBwvG_94llUYiLa.jpeg?imageView2/2/w/100/h/100/q/75/format/jpg'
        },
        initialSku: {
          s1: '1',
          s2: '13',
          selectedNum: 1
        }
      },
      showBase: false,
      showCustom: false,
      showStepper: false,
      showSoldout: false,
      closeOnClickOverlay: true,
      initialSku: {
        s1: '30349',
        s2: '1193',
        selectedNum: 1
      },
      customSkuValidator: () => '请选择xxx!',
      // ********************//
      display: true,
      active: 0,
      star: 5,
      grade: 2,
      goodsFun: [
        {
          to: 'shangpin',
          name: '商品'
        },
        {
          to: 'pingjia',
          name: '评价'
        },
        {
          to: 'xiangqing',
          name: '详情'
        }
      ],
      goods: {
        // thumb: []
      },
      goodsImg: [],
      total: 0,
      start: 0
    }
  },
  methods: {
    totalnum () {
      if (this.total === undefined) {
        return 0
      } else {
        return this.total
      }
    },
    formatPrice () {
      return '¥  ' + (this.goods.price / 100).toFixed(2)
    },
    onClickCart () {
      this.$router.push('/')
    },
    postCart () {
      this.showBase = true
    },
    sorry () {},
    // 头部锚点
    anchor (to) {
      document.querySelector('#' + to).scrollIntoView(true)
    },
    // 获取商品详情
    getGoodsProduct () {
      let id = this.$route.params.id
      this.$http.get(`/product/${id}`).then(res => {
        console.log(res)
        this.goods = res.data.data[0]
        this.goods.thumb = res.data.path
        this.goodsImg = res.data.details_path
      })
    },
    // 跳转评论页面
    getComment (id) {
      if (this.total === undefined) {
        return false
      } else {
        this.$router.push(`/comment/${id}`)
      }
    },
    putComment () {
      let id = this.$route.params.id
      this.$http.get(`comment/${id}`).then(res => {
        this.total = res.data.total
        this.start = res.data.start
      })
    },
    // 商品规格
    getPropety () {
      let id = this.$route.params.id
      // console.log(id)

      this.$http.get(`/product/${id}`).then(res => {
        // console.log(res.data)
        // 图片
        this.skuData.goods_info.picture = res.data.path[0].path
        // id
        this.skuData.goods_id = res.data.data[0].id
        // this.skuData.sku.list[0].goods_id = res.data.data[0].id
        // 标题
        // console.log(res.data.data[0].goods)

        this.skuData.goods_info.title = res.data.data[0].goods_name
        // 价钱
        this.skuData.sku.price = res.data.data[0].price
        // this.skuData.sku.list[0].price = res.data.data[0].price * 100
        // 剩余
        this.skuData.sku.stock_num = res.data.data[0].inventory
        // this.skuData.sku.list[0].stock_num = res.data.data[0].inventory
        // 规格

        // 把属性 (prop) 添加到 tree
        res.data.props.forEach((item, index) => {
          let branch = {}
          branch.k = item.property_name
          branch.v = []
          if (index === 0) {
            branch.imgUrl = res.data.path[0].path
          }
          // 把属性值 (attr) 添加到属性 (prop)
          res.data.attrs.forEach(item2 => {
            if (item2.property_id === item.id) {
              let attr = {}
              attr.id = item2.id
              attr.name = item2.name
              branch.v.push(attr)
            }
          })
          branch.k_s = 's' + (index + 1)
          this.skuData.sku.tree.push(branch)
        })
        // 把可选项添加到list
        let propItem1 = res.data.props[0]
        let propItem2 = res.data.props[1]
        let listItemId = 1
        // 第一个参数 : propItem1 、 attrItem1
        res.data.attrs.forEach(attrItem1 => {
          if (attrItem1.property_id === propItem1.id) {
            // 第二个参数 : propItem2 、 attrItem2
            res.data.attrs.forEach(attrItem2 => {
              if (attrItem2.property_id === propItem2.id) {
                let listItem = {}
                listItem.id = listItemId++ // 随便一个数
                listItem.price = res.data.data[0].price
                listItem.s1 = '' + attrItem1.id
                listItem.s2 = '' + attrItem2.id
                listItem.s3 = ''
                listItem.stock_num = 1
                // 添加到list
                this.skuData.sku.list.push(listItem)
              }
            })
          }
        })
        this.skuData.sku.selectedSkuComb = []
        // console.log(this.skuData.sku.tree)
        // console.log(this.skuData)
      })
    },

    onBuyClicked (data) {
      let cartList = {
        goods_id: data.goodsId,
        count: data.selectedNum,
        ischk: 1,
        user_id: window.localStorage.getItem('id'),
        standards: '常规'
      }
      // console.log(cartList.user_id)
      // console.log(JSON.stringify(cartList))
      window.sessionStorage.setItem('cartList', JSON.stringify(cartList))
      this.$router.push('/pay')
    },

    onAddCartClicked (data) {
      console.log('132')
      console.log(data)
      let id = window.localStorage.getItem('id')
      if (!id) {
        this.$toast('请登录！')
        return false
      }
      let cartList = {
        goods_id: data.goodsId,
        count: data.selectedNum,
        ischk: 0,
        user_id: window.localStorage.getItem('id'),
        standards: '常规'
      }
      // console.log(cartList.user_id)
      this.$http.post('/cart', cartList).then(res => {
        // console.log(res)
        this.$toast('已加入购物车')
        this.showBase = false
      })
    }
  },
  created () {
    this.getPropety()
    this.putComment()
    this.getGoodsProduct()
  }
}
</script>
<style lang="less" scoped>
// 头部标题·1
.van-nav-bar {
  position: fixed;
  width: 100%;
}
.title {
  .colordisplay {
    box-sizing: border-box;
    border-bottom: 2px solid #f4d313;
    height: 46px;
    font-size: 18px;
    line-height: 49px;
  }
  overflow: hidden;
  li {
    float: left;
    color: #6f6f6f;
    margin-left: 35px;
    height: 40px;
    /* text-align: center; */
  }
}
// 图标
.qa_icon ul {
  overflow: hidden;
}
.qa_icon li {
  float: left;
  width: 25%;
  // margin-left: 10px;
  padding-left: 20px;
}
.li_one {
  position: relative;
  color: #666666;
  div {
    position: absolute;
    top: -7px;
    left: -12px;
    width: 36px;
    height: 37px;
    /* background-color: #f7545f; */
    background-image: url(https://js01.daoju.qq.com/zb/v2/ico-mall.png);
    background-position: -348px -178px;
    /* border-radius: 50%; */
    -webkit-transform: scale(0.6, 0.6);
    transform: scale(0.5, 0.5);
  }
}
.li_two {
  position: relative;
  color: #666666;
  div {
    position: absolute;
    top: -7px;
    left: -12px;
    width: 36px;
    height: 37px;
    /* background-color: #f7545f; */
    background-image: url(https://js01.daoju.qq.com/zb/v2/ico-mall.png);
    background-position: -6px -177px;
    /* border-radius: 50%; */
    -webkit-transform: scale(0.6, 0.6);
    transform: scale(0.5, 0.5);
  }
}

.goods {
  padding-bottom: 50px;
  &-swipe {
    img {
      width: 100%;
      display: block;
    }
  }
  &-title {
    font-size: 17px;
  }
  &-price {
    font-size: 25px;
    color: #f7545f;
    margin-top: 15px;
    a {
      font-size: 13px;
      color: #999999;
      float: right;
    }
  }
  &-express {
    color: #999;
    font-size: 12px;
    padding: 5px 15px;
  }
  &-cell-group {
    margin: 15px 0;
    .van-cell__value {
      color: #999;
    }
  }
  &-tag {
    margin-left: 5px;
  }
}
// 购物栏
.van-goods-action {
  position: fixed;
  z-index: 2000;
}
.van-nav-bar .van-icon {
  font-size: "20px";
  color: #9d9d9d;
  vertical-align: middle;
}
// 购物栏按钮
.van-goods-action-button--first {
  border-top-left-radius: 0px;
  border-bottom-left-radius: 0px;
}
.van-goods-action-button--last {
  border-top-right-radius: 0px;
  border-bottom-right-radius: 0px;
}

.van-goods-action-button--last {
  border-top-right-radius: 0px;
  border-bottom-right-radius: 0px;
  margin-right: 0;
  height: 50px;
  font-size: 18px;
}

.van-goods-action-button--first {
  border-top-right-radius: 0px;
  border-bottom-right-radius: 0px;
  margin-right: 0;
  height: 50px;
  font-size: 18px;
}

.van-sku-actions .van-button--warning {
  background: #383838;
}

.van-sku-actions .van-button--danger {
  background: #ffd54f;
}
</style>
