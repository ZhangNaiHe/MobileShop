<template>
  <div class="register">
    <!-- 导航栏 -->
    <van-nav-bar title="注册" left-arrow @click-left="$router.go(-1)" />
    <van-cell-group>
      <van-field
        label="用户名"
        left-icon="manager"
        placeholder="请输入用户昵称"
        v-model="userInfo.username"
        :error-message="userRef.username"
      />
      <van-field
        label="手机号"
        left-icon="phone"
        placeholder="请输入手机号"
        v-model="userInfo.phone"
        :error-message="userRef.phone"
      />
      <van-field
        label="密码"
        left-icon="lock"
        type="password"
        placeholder="请输入密码"
        v-model="userInfo.password"
        :error-message="userRef.password"
      />
    </van-cell-group>
    <van-button type="info" @click="postReg">注册</van-button>
  </div>
</template>

<script>
import { Dialog } from 'vant'
export default {
  data () {
    return {
      userInfo: {
        username: 'admin',
        password: '123456',
        phone: '13336696363',
        path: 'https://game.gtimg.cn/images/zb/comm/jcp.png'
      },
      userRef: {
        username: '',
        password: '',
        phone: ''
      }
    }
  },

  methods: {
    // 注册
    postReg () {
      let mobRef = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/
      let passRef = /^[\w_-]{6,16}$/
      let userRef = /^[\u4e00-\u9fa5A-Za-z0-9-_]*$/
      // 手机号正则验证
      if (!mobRef.test(this.userInfo.phone)) {
        this.userRef.phone = '手机号码格式不正确'
        return false
      }
      // 昵称正则
      if (!userRef.test(this.userInfo.username)) {
        this.userRef.username = '只能中英文，数字，下划线，减号'
        return false
      }
      // 密码正则验证
      if (!passRef.test(this.userInfo.password)) {
        this.userRef.password = '密码必须是6-16位字母数字_-组成！'
        return false
      }
      this.$http.post('/register', this.userInfo).then(res => {
        // console.log(res)
        if (res.data.ok === 1) {
          Dialog.alert({
            message: '注册成功！'
          }).then(() => {
            this.userInfo = {}
            this.$router.push('/login')
          })
        } else {
          Dialog.alert({
            message: res.data.error
          }).then(() => {

          })
        }
      }, error => error)
    }
  },
  created () {
    this.$emit('getTo', 0)
  }
}
</script>

<style lang="less" scoped>
.van-button {
  margin-left: 5%;
  border-radius: 5px;
  width: 90%;
  opacity: 0.7;
  margin-top: 25px;
}
.van-nav-bar {
  background-image: linear-gradient(to right, #317ef3, #179bfe);
  margin-bottom: 25px;
}
.van-nav-bar__title {
  color: #fff;
}
.van-icon-arrow-left:before {
  content: "\F008";
  color: #fff;
}
</style>
