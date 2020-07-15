<template>
  <div class="selfcom">
    <!-- 导航栏 -->
    <van-nav-bar title="我的评价" left-arrow @click-left="$router.back()" />
    <!-- 没评论显示的内容 -->
    <div class="no_order" v-if="!selfcomList[0]">
      <div class="icon"></div>
      <p class="none">暂时还没有评论哦 ~</p>
    </div>
    <!-- 有评论显示的内容 -->
    <div class="comment" v-else>
      <van-cell-group>
        <van-cell :title="'全部评价('+total+')'">
          <template slot="default">
            <div>
              综合评分
              <van-rate v-model="start" allow-half readonly size="12px" />
            </div>
          </template>
        </van-cell>
      </van-cell-group>
      <!-- 评论 -->
      <van-cell
        size="large"
        :label="item.content"
        class="goods-cell-group"
        v-for="(item,index) in selfcomList"
        :key="index"
      >
        <template class="tel" slot="title">
          <van-image round width="32" height="32" :src="item.path" />
          <div class="com_right">
            <span>{{item.username}}</span>
            <div>
              综合评分
              <van-rate v-model="item.grade" allow-half readonly size="12px" />
            </div>
          </div>
        </template>
      </van-cell>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      // 评论数组
      selfcomList: [],
      start: 0,
      total: 0
    }
  },
  created () {
    // 拿浏览器里的id
    let id = localStorage.getItem('id')
    // 调用 我的评论接口
    this.$http.get(`/selfcom/${id}`).then(res => {
      this.selfcomList = res.data.data
      this.start = res.data.start
      this.total = res.data.total
    })
  }
}
</script>

<style lang="less" scoped>
html,
body,
#app {
  height: 100%;
}
.selfcom {
  background-color: #f3f4f6;
  height: 100%;
  .icon {
    margin: 50px auto auto;
    width: 61px;
    height: 50px;
    background-position: 317px 653px;
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

  .van-divider {
    border-style: none;
  }

  .van-cell--large {
    margin-bottom: 5px;
  }

  .tel {
    position: relative;
  }
  .com_right {
    position: absolute;
    top: 5px;
    left: 58px;
    span {
      color: #666666;
      font-size: 0.26rem;
    }
    div {
      color: #999999;
      font-size: 0.26rem;
      margin-top: -6px;
    }
  }
  .van-nav-bar {
    background: #ffd474;
  }
}
</style>
