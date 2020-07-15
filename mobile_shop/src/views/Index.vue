<template>
  <div class="index">
    <!-- 轮播图 -->
    <van-swipe :autoplay="3000" indicator-color="white">
      <van-swipe-item v-for="(item, index) in swipes" :key="index">
        <van-image :src="item.image"></van-image>
      </van-swipe-item>
    </van-swipe>

    <!-- 搜索 -->
    <div class="notice">
      <van-icon class="search_icon" @click="$router.push('/search')" name="search" />
      <van-icon class="sort_icon" @click="$router.push('/sort')" name="apps-o" />
    </div>

    <!-- 分类 -->
    <div class="classify_btns">
      <van-grid>
        <van-grid-item text="美妆护肤" route to="/sort?classify_id=1">
          <van-image
            slot="icon"
            width="44"
            height="44"
            src="https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/19745/21/1415/4886/5c120cbbEe58af0bf/4d19bf58d42fc9c4.png"
          />
        </van-grid-item>
        <van-grid-item text="数码电器" route to="/sort?classify_id=2">
          <van-image
            slot="icon"
            width="44"
            height="44"
            src="https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/39401/17/2391/5859/5cc06fcfE2ad40668/28cda0a571b4a576.png"
          />
        </van-grid-item>
        <van-grid-item text="生鲜直购" route to="/sort?classify_id=3">
          <van-image
            slot="icon"
            width="44"
            height="44"
            src="https://m.360buyimg.com/mobilecms/s120x120_jfs/t17725/156/1767366877/17404/f45d418b/5ad87bf0N66c5db7c.png"
          />
        </van-grid-item>
        <van-grid-item text="全部商品" route to="/sort">
          <van-image
            slot="icon"
            width="44"
            height="44"
            src="https://m.360buyimg.com/mobilecms/s120x120_jfs/t1/28873/5/1455/6885/5c120bb9Eb6610bee/29d349f92aeb6eaf.png"
          />
        </van-grid-item>
      </van-grid>
    </div>
    <!-- 为你推荐 -->
    <van-divider
      class="classify_btn"
    />
    <!--推荐商品 -->
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
      // current: 0,
      // 轮播图,
      swipes: [
        {
          image:
            'https://imgcps.jd.com/ling4/100008348530/5omL5py66LSt5a6e5oOg/5aSH6LSn6LaF5YC8/p-5c1224c882acdd181d12307f/fe4dff22/cr_1125x445_0_171/s1125x690/q70.jpg'
        },
        {
          image:
            'https://m.360buyimg.com/mobilecms/s700x280_jfs/t1/48737/9/11006/280589/5d8080a2Ecb91637d/84e2da70a0986d6d.jpg!cr_1125x445_0_171!q70.jpg.dpg'
        },
        {
          image:
            'https://m.360buyimg.com/mobilecms/s700x280_jfs/t1/95842/38/12546/80187/5e4ba3e7E09e0da3b/92aac67aefdf6b6f.jpg!cr_1125x445_0_171!q70.jpg.dpg'
        },
        {
          image:
            'https://m.360buyimg.com/mobilecms/s700x280_jfs/t1/92914/11/12478/101092/5e4a3fdfEed5ce654/2b7193667947ebc6.jpg!cr_1125x445_0_171!q70.jpg.dpg'
        },
        {
          image:
            'https://m.360buyimg.com/mobilecms/s700x280_jfs/t1/109302/32/6165/35704/5e4a2626Ea8cd4a8c/887a313f101225be.jpg!cr_1125x445_0_171!q70.jpg.dpg'
        }
      ]
    }
  },
  methods: {
    // 获取轮播图
    getSwipes () {
    },
    getGoods () {
      // 推荐商品
      this.$http
        .get('/forGoods')
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
    // 存储点击的商品id
    toGoods (id) {
      this.$router.push(`/product/${id}`)
    }
  },
  created () {
    this.$emit('getTo', 'home')
    // 推荐
    this.getGoods()
    // 获取轮播图
    this.getSwipes()
  }
}
</script>

<style lang="less" scoped>
.index {
  padding-bottom: 50px;
}
.van-icon-search:before {
  content: "\F0AF";
  padding-left: 8px;
  padding-top: 7px;
}
.notice .van-icon.search_icon {
  border-radius: 50%;
  width: 40px;
  height: 40px;
  background: #00000054;
  color: #f8f8f8;
  position: absolute;
  top: 0.9rem;
  right: 0.9rem;
  font-size: 24px;
  line-height: 26px;
}
.notice .van-icon.sort_icon {
  border-radius: 50%;
  width: 40px;
  height: 40px;
  background: #00000054;
  color: #f8f8f8;
  position: absolute;
  top: 0.9rem;
  left: 0.9rem;
  font-size: 24px;
  line-height: 40px;
  text-align: center;
}
.van-icon-bars:before {
  content: "\F016";
  padding-left: 8px;
  padding-top: 7px;
}
.index .van-image__img {
  width: 175px;
  height: 169.16;
}
.sort {
  background: url(https://game.gtimg.cn/images/daojushop/zb/ad/201804/20180418185711_967521.png)
    center center no-repeat;
  background-size: 60% auto;
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
.van-divider {
  height: 4vh;
  background: url(https://img11.360buyimg.com/jdphoto/jfs/t1/31601/22/15554/14040/5cc2a86fEbdb1098b/88174b36f85283b6.png) center center no-repeat;
  background-size: 120% auto;
}
.van-grid.van-hairline--top {
  margin-top: 10px;
}
.van-hairline--top::after {
  border: none;
}
</style>

<style>
.index .van-grid-item__content--center {
  padding: 0px;
}
.rec_goods .van-grid-item__content--center {
  border: 1px solid #9be155;
  border-radius: 20px;
}
.rec_goods .van-image__img {
  border-radius: 20px 20px 0 0;
}
.index .classify_btns .van-grid-item__content::after {
  border: none;
}
.index .van-grid-item__content::after {
  border-width: 1px;
}
.van-grid {
  background: #f3f4f6;
}
div.title {
  min-height: 40px;
}
.title,
.price {
  text-align: left;
}
.no_goods::after {
  display: block;
  content: "缺货";
  width: 50px;
  height: 50px;
  text-align: center;
  line-height: 50px;
  color: #111;
  font-size: 14px;
  font-weight: 200;
  border-radius: 50%;
  background-color: rgba(255, 189, 67, 0.692);
  position: absolute;
  left: 50%;
  top: 70px;
  margin-left: -25px;
  z-index: 1;
}
.no_goods::before {
  display: block;
  content: "";
  width: 100%;
  height: 100%;
  position: absolute;
  left: 0px;
  top: 0px;
  background-color: rgba(255, 255, 255, 0.48);
  z-index: 0;
}
</style>
