<template>
  <div class="comment">
    <!-- 头部导航 -->
    <van-nav-bar title="用户评论" left-arrow @click-left="$router.go(-1)" />

    <!-- 综合评分 -->
    <van-cell-group>
      <van-cell :title="'用户评价('+total+')'">
        <template slot="default">
          <div>
            综合评分
            <van-rate v-model="start" readonly size="12px" />
          </div>
        </template>
        <!-- 评价 -->
        <div></div>
      </van-cell>
    </van-cell-group>
    <!-- 用户评论 -->

    <van-cell
      size="large"
      :label="item.content"
      class="goods-cell-group"
      v-for="(item,index) in comList"
      :key="index"
    >
      <template class="tel" slot="title">
        <van-image round width="32" height="32" :src="item.path" />
        <div class="com_right">
          <span>{{item.username}}</span>
          <div>
            评分
            <van-rate v-model="item.grade" readonly size="12px" />
          </div>
        </div>
      </template>
    </van-cell>

    <!-- 用户评论 -->

    <!--  -->
    <!-- 底部 -->
    <van-divider>暂时没有更多评论</van-divider>
  </div>
</template>

<script>
export default {
  data () {
    return {
      start: 0,
      comList: [],
      total: 0
    }
  },
  methods: {
    num () {
      return 1
    },

    getComment () {
      let id = this.$route.params.id
      // console.log(id)
      this.$http.get(`comment/${id}`).then(res => {
        // console.log(res)
        this.comList = res.data.data
        if (res.data.total === undefined) {
          res.data.data = 0
        }
        // console.log(res)

        this.total = res.data.total || 0
        this.start = res.data.start
      })
    }
  },
  created () {
    this.getComment()
  }
}
</script>

<style lang="less" scoped>
.van-divider {
  border-style: none;
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
</style>
