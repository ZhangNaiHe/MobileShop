<template>
  <div class="search">
    <van-search placeholder="搜索你想要的宝贝" v-model="searchStr" ref="search" />
    <!-- 商品列表 -->
    <van-list
      v-model="loading"
      :finished="finished"
      finished-text="暂时没有更多商品"
      @load="search"
      v-if="searchStr"
    >
      <van-grid :column-num="2" :gutter="5">
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
            <van-image :src="item.imgSrc"></van-image>
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
      // 分页
      page: {
        page_num: 1,
        page_size: 10
      },
      searchStr: '',
      goodsList: [],
      loading: true,
      finished: false
    }
  },
  watch: {
    searchStr () {
      this.search()
    }
  },
  methods: {
    // 进入页面时聚焦input
    inputFocus () {
      this.$refs.search.focus()
      document.getElementsByClassName('van-field__control')[0].focus()
    },
    // 搜索查询商品
    async search () {
      console.log(this.searchStr)
      if (!this.searchStr) {
        return false
      }
      let { data: res } = await this.$http.get('/search', {
        params: { page: this.page, searchStr: this.searchStr }
      })
      // 循环商品，找到与商品id对应的图片路径
      res.goods.forEach(good => {
        let index = res.img.findIndex(item => item.goods_id === good.id)
        good.imgSrc = res.img[index].path
      })
      console.log(res.goods)
      this.goodsList = res.goods
      this.loading = false
      this.finished = true
    }
  },
  created () {
    // 给tableBar发送现在在哪个页面
    this.$emit('getTo', 'sort')

    this.$nextTick(() => {
      this.inputFocus()
    })
  }
}
</script>

<style scoped lang="less">
.van-search__content {
  border-radius: 15px;
}

.van-search .van-cell {
  padding: 2px 8px 2px 0;
}
.van-grid-item__content {
  padding: 0px;
}
.search .van-grid {
  background: #fff;
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
.search {
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
.search {
  padding-bottom: 50px;
}
</style>

<style>
.sort .van-cell {
  color: #999999;
  font-size: 15px;
}
.van-dropdown-menu__title {
  color: #999999;
}
.search .van-dropdown-menu__title--active {
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
#app .search .van-grid {
  background-color: #fff;
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
