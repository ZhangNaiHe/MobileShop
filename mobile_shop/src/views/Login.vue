<template>
  <div class="login">
    <!-- 导航栏 -->
    <van-nav-bar title="用户登录" left-arrow @click-left="$router.back()" />
    <!-- 表单输入框 -->
    <van-cell-group>
      <van-field placeholder="请输入手机号" v-model="loginInfo.phone" :error-message="errorInfo.phone" />
      <van-field
        placeholder="请输入密码"
        v-model="loginInfo.password"
        :error-message="errorInfo.password"
        type="password"
      />
      <van-button type="primary" @click="login">登录</van-button>
      <van-button type="info" @click="$router.push('/register')">没有账号？去注册</van-button>
    </van-cell-group>
  </div>
</template>

<script>
export default {
  data () {
    return {
      // 登录信息
      loginInfo: {
        phone: '',
        password: ''
      },
      // 错误提示信息
      errorInfo: {
        phone: '',
        password: ''
      }
    }
  },
  methods: {
    // 登录
    login () {
      // 验证手机号
      let phoneRef = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/
      // console.log(this.loginInfo)
      if (!phoneRef.test(this.loginInfo.phone)) {
        this.errorInfo.phone = '手机号格式不正确'
        return false
      } else {
        this.errorInfo.phone = ''
      }

      // 验证密码
      let passRef = /^[\w_-]{6,16}$/
      if (!passRef.test(this.loginInfo.password)) {
        this.errorInfo.password = '密码必须是6-16位字母数字_-组成！'
        return false
      } else {
        this.errorInfo.password = ''
      }

      this.$http
        .post('/login', this.loginInfo)
        .then(res => {
          // console.log(res)
          // 登录成功
          if (res.data.ok === 1) {
            // 清除
            localStorage.clear()
            // 存令牌
            localStorage.setItem('token', res.data.token)
            // 存id
            localStorage.setItem('id', res.data.data.id)
            // 存电话号码
            localStorage.setItem('phone', res.data.data.phone)
            localStorage.setItem('password', '123456')
            localStorage.setItem('money', res.data.data.money)
            // 去首页
            this.$router.push('/')
            // 登录成功的信息
            this.$toast(res.data.message)
          } else {
            // 登录失败的信息
            this.$toast(res.data.error)
          }
        })
        .catch(e => {})
    }
  },
  created () {
    this.$emit('getTo', 0)
  }
}
</script>

<style lang="less" scoped>
.login {
  .van-nav-bar {
    background-image: linear-gradient(to right, #07c160, #18a05e);
    margin-bottom: 25px;
  }

  .van-nav-bar__title {
    color: #fff;
  }

  .van-icon-arrow-left:before {
    content: "\F008";
    color: #fff;
  }

  .van-button {
    margin-left: 5%;
    border-radius: 5px;
    width: 90%;
    opacity: 0.7;
    margin-top: 25px;
  }
}
</style>
