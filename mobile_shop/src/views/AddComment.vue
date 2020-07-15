<template>
  <div class="addcomment">
    <!-- 导航 -->
    <van-nav-bar title="标题" left-arrow @click-left="$router.back()"></van-nav-bar>
    <van-panel v-for="(item,index) in orderData.goods" :key="index">
      <!-- 描述 -->
      <van-row type="flex">
        <van-col span="5">
          <van-image width="60" height="60" fit="fill" style="overflow:hidden" :src="item.goods_image" />
        </van-col>
        <van-col span="12">
          <p class="miaoshu">{{item.goods_name}}</p>
        </van-col>
      </van-row>
      <van-row type="flex">
        <van-col span="4" style="line-height:42px">
          评分
        </van-col>
        <van-col span="12">
          <van-rate v-model="item.start" size="25px" />
        </van-col>
      </van-row>

      <!-- 评论内容 -->
      <van-cell-group>
        <van-field
          v-model="item.content"
          rows="5"
          autosize
          type="textarea"
          maxlength="300"
          placeholder="宝贝满足你们的期待吗？说说你们的使用心得,分享给想买的他们吧"
          show-word-limit
        />
        <van-button
          round
          type="info"
          color="#ffd54f"
          size="small"
          @click="postComment(item.order_id,item.goods_id,item.start,item.content)"
        >发布评论</van-button>
      </van-cell-group>
    </van-panel>
  </div>
</template>

<script>
export default {
  data () {
    return {
      value: 5,
      message: '',
      userList: [],
      orderData: [

      ]
    }
  },
  methods: {
    // eslint-disable-next-line camelcase
    postComment (order_id, goods_id, start, content) {
      // console.log(order_id, goods_id)
      let List = {
        content,
        grade: start,
        order_id,
        goods_id,
        user_id: window.localStorage.getItem('id')
      }
      this.$http.post('/comment', List).then(res => {
        // console.log(res)
        if (res.data.ok !== 1) {
          this.$toast('评论失败')
        } else {
          this.$toast('评论成功')
          // let id = window.localStorage.getItem('id')
          this.$router.push(`/product/${List.goods_id}`)
        }
      })
    }
  },
  created () {
    let orderData = this.$route.query.data

    orderData.goods.forEach(v => {
      // console.log(v)
      v.content = ''
      v.start = 5
    })
    // console.log(orderData.goods)
    this.orderData = orderData

    this.$http.get(`/setting/${orderData.user_id}`).then(res => {
      this.userList = res.data.data[0]
      // console.log(res.data.data[0])
    })
  }
}
</script>

<style lang="less" scoped>
.miaoshu {
  margin-top: 12px;
}
.van-row {
  margin-left: 20px;
}
.van-nav-bar {
  margin-bottom: 20px;
}
.van-rate {
  margin-top: 8px;
}
.van-button {
  margin: 10px 0px 10px 300px;
}
</style>
