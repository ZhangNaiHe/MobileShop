<template>
  <div class="classify">
    <!-- 搜索栏 -->
    <van-search @focus="$router.push('/search')" />
    <!-- 下拉菜单 -->
    <van-dropdown-menu>
      <van-dropdown-item v-model="isDefault" title="默认" :options="option1" />
      <van-dropdown-item v-model="classify.classify_id" :options="option2" />
      <van-dropdown-item v-model="classify.sort" :options="option3" />
    </van-dropdown-menu>
    <!-- 商品列表 -->
    <van-list v-model="loading" :offset="600" :finished="finished" finished-text="暂时没有更多商品" @load="onLoad">
      <van-grid class="rec_goods" :column-num="2" :gutter="5">
        <van-grid-item
          v-for="(item, index) in goodsList"
          :key="index"
          route
          :to="'/product/'+item.id"
        >
          <!-- 标签 -->
          <div slot="text" class="ico-mall" v-if="item.status == 2 || item.status == 3">
            <span class="mark-txt" v-if="item.status == 2">新品</span>
            <span class="mark-txt" v-if="item.status == 3">限定</span>
          </div>
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
    </van-list>
  </div>
</template>

<script>
export default {
  data () {
    return {
      isDefault: true,
      // 分类的各个属性
      classify: {
        classify_id: 0,
        sort: 0,
        status: 0
      },
      defaultClassify: {
        classify_id: 0,
        sort: 0,
        status: 0
      },
      // 商品信息数组
      goodsList: [],
      // 分页
      page: {
        page_num: 1,
        page_size: 10
      },
      option1: [{ text: '默认', value: true }],
      option2: [{ text: '所有分类', value: 0 }],
      option3: [
        { text: '默认排序', value: 0 },
        { text: '新品优先', value: 'time' },
        { text: '销量排序', value: 'total_sale' },
        { text: '价格降序', value: 'price desc' },
        { text: '价格升序', value: 'price' }
      ],
      option4: [
        { text: '全部', value: 0 },
        { text: '有货', value: 1 },
        { text: '限定', value: 2 }
      ],
      // 是否处于加载状态,如果是true就不能在加载
      loading: false,
      // 是否加载完成
      finished: false
    }
  },
  watch: {
    classify: {
      handler: function (newV) {
        this.isDefault = false
        this.goodsList = []
        this.page.page_num = 0
        this.onLoad()
        this.loading = true
        this.finished = false
      },
      deep: true
    },
    isDefault: function (newV) {
      if (newV === true) {
        this.classify = { ...this.defaultClassify }
      }
    }
  },
  methods: {
    // 滚动条与底部距离小于 offset 时触发的方法
    onLoad () {
      // console.log(this.page)
      let queryInfo = {
        page: this.page,
        classify: this.classify
      }
      // 默认商品
      this.$http.get(`/goods`, { params: queryInfo }).then(async res => {
        // 循环商品，找到与商品id对应的图片路径
        await res.data.goods.forEach(good => {
          let index = res.data.img.findIndex(item => item.goods_id === good.id)
          good.imgSrc = res.data.img[index].path
        })
        await this.goodsList.push(...res.data.goods)
        this.loading = false
        // 设置最多加载12条数据
        if (this.goodsList.length >= 50 || res.data.goods.length < 10) {
          // 加载完成
          this.finished = true
        } else {
          this.page.page_num++
        }
      })
    }
  },
  created () {
    // 给tableBar发送现在在哪个页面
    this.$emit('getTo', 'sort')

    // 渲染分类
    this.$http.get('/sort').then(res => {
      // 将数据赋值给分类
      res.data.data.forEach((item, index) => {
        this.option2.push({
          text: item.class_name,
          value: item.id
        })
      })
    })

    // 根据路由参数，设置分类参数
    this.classify.classify_id = Number(this.$route.query.classify_id) || 0
    this.classify.sort = this.$route.query.sort || 0
    this.classify.status = this.$route.query.status || 0
  }
}
</script>

<style lang="less" scoped>
.classify {
  .van-search__content {
    border-radius: 15px;
  }

  .van-search .van-cell {
    padding: 2px 8px 2px 0;
  }

  .van-ellipsis {
    font-size: 13.5px;
  }

  [class*="van-hairline"]::after {
    border-top: none;
  }

  .van-grid {
    background-color: #f3f4f6;
    padding-top: 5px;
    padding-bottom: 5px;
  }

  .van-cell__title,
  .van-cell__value {
    font-size: 13px;
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
}
.classify {
  padding-bottom: 50px;
}
</style>

<style>
.van-list__finished-text {
  background-color: #f3f4f6;
}
.sort .van-cell {
  color: #999999;
  font-size: 15px;
}
.van-dropdown-menu__title {
  color: #999999;
}
.classify .van-dropdown-menu__title--active {
  color: #333333;
}
.pop-filter .filter-bd .filter-list .filter-listul li {
  color: #999999;
}
.van-dropdown-item__option--active,
.van-dropdown-item__option--active .van-dropdown-item__icon {
  color: #333333;
}
.van-grid-item__content--center {
  padding: 0px;
}
#app .classify .van-grid {
  background-color: #f3f4f6;
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
