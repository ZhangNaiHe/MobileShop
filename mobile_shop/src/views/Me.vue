<template>
  <div class="me" v-if="user">
    <!-- 头像 -->
    <!-- <van-uploader :after-read="afterRead" /> -->
    <div class="top_line">
      <div class="tx">
        <van-uploader :after-read="afterRead">
          <img :src="user.path" alt />
        </van-uploader>
      </div>
      <div class="username">{{user.username}}</div>
      <div class="balance">钱包余额：￥{{user.money}}</div>
    </div>
    <van-cell title="我的订单" is-link value="全部订单" :to="{path: '/order', query:{id:'-1'}}" />
    <!-- 订单分类 -->
    <van-grid :border="false" :column-num="5">
      <van-grid-item text="待付款" :to="{path: '/order', query:{id:'0'}}">
        <div class="icon" slot="icon">
          <div class="icon_img ione"></div>
        </div>
      </van-grid-item>
      <van-grid-item text="待发货" :to="{path: '/order', query:{id:'1'}}">
        <div class="icon" slot="icon">
          <div class="icon_img itwo"></div>
        </div>
      </van-grid-item>
      <van-grid-item text="待收货" :to="{path: '/order', query:{id:'2'}}">
        <div class="icon" slot="icon">
          <div class="icon_img ithree"></div>
        </div>
      </van-grid-item>
      <van-grid-item text="待评价" :to="{path: '/order', query:{id:'3'}}">
        <div class="icon" slot="icon">
          <div class="icon_img ifour"></div>
        </div>
      </van-grid-item>
      <van-grid-item text="已完成" :to="{path: '/order', query:{id:'4'}}">
        <div class="icon" slot="icon">
          <div class="icon_img ifive"></div>
        </div>
      </van-grid-item>
    </van-grid>
    <!-- 菜单栏 -->

    <van-cell title="地址管理" icon="location-o" to="/site">
      <!-- 使用 right-icon 插槽来自定义右侧图标 -->
      <van-icon slot="right-icon" name="arrow" style="line-height: inherit;" />
    </van-cell>

    <van-cell title="我的评价" icon="chat-o" to="/selfcom">
      <!-- 使用 right-icon 插槽来自定义右侧图标 -->
      <van-icon slot="right-icon" name="arrow" style="line-height: inherit;" />
    </van-cell>

    <van-cell title="个人设置" icon="setting-o" to="/setting">
      <!-- 使用 right-icon 插槽来自定义右侧图标 -->
      <van-icon slot="right-icon" name="arrow" style="line-height: inherit;" />
    </van-cell>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  data () {
    return {
      user: {}
    }
  },
  methods: {
    async afterRead (file) {
      // console.log(file.file)
      // 创建form对象
      let params = new FormData()
      // 通过append向form对象添加数据  第一个参数字符串可以填任意字符
      params.append('file', file.file)
      let config = {
        headers: {
          Authorization:
          'Bearer' + window.localStorage.getItem('token'),
          'Content-Type': 'multipart/form-data'
        }
        // console.log(headers)
      }
      let id = window.localStorage.getItem('id')
      console.log(id)
      let { data: res } = await this.$http.put(`/upload/${id}`, params, config)
      console.log(res)
      if (res.status === 200) {
        this.$toast.success('修改头像成功')
        this.getUser()
      }
    },
    getUser () {
      let id = window.localStorage.getItem('id')
      let _this = this
      this.$http.get(`/setting/${id}`).then(res => {
        _this.user = res.data.data[0]
        // console.log(res.data)
      })
    }
  },
  created () {
    // 给tableBar发送现在在哪个页面
    this.$emit('getTo', 'me')

    this.getUser()
  }
}
</script>

<style lang="less" scoped>
.van-grid {
  // margin-top: 10px;
  margin-bottom: 10px;
}
// 头像
.head_portrait {
  .van-grid {
    margin-top: 10px;
  }
  margin-top: 10px;

  width: 100%;
  background-color: #fff;
  // border: 1px solid #c3c3c3;
  .head_img {
    width: 60px;
    height: 60px;
    border: 1px dashed #ccc;
    background: url(https://js01.daoju.qq.com/zb/v2/default.png) center center
      no-repeat;
    background-size: 60% auto;
  }
}
.icon .icon_img {
  width: 46px;
  height: 49px;
  background-position: -689px -21px;
  background-image: url(https://js01.daoju.qq.com/zb/v2/ico-mall.png);
  background-repeat: no-repeat;
  -webkit-transform: scale(0.5);
}
.icon .itwo {
  background-position: -630px -21px;
}
.icon .ithree {
  background-position: -161px -77px;
}
.icon .ifour {
  background-position: -103px -77px;
}
.icon .ifive {
  background-position: -3px -77px;
}
// 图标颜色
.van-icon-arrow:before {
  content: "\F00A";
  color: #cdcdcd;
}
.dafault {
  height: 60px;
  width: 60px;
  border: 1px solid #eeeeee;
  border-radius: 50%;
  margin-left: 15px;
}

.top_line {
  padding: 20px;
}
.top_line::after {
  content: "";
  display: block;
  clear: both;
}
.tx {
  float: left;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  overflow: hidden;

  img {
    width: 100%;
  }
}
.balance {
  float: right;
  margin-top: 18px;
}
.username {
  float: left;
  margin-left: 20px;
  font-size: 22px;
  font-weight: 550;
  line-height: 60px;
}
</style>
