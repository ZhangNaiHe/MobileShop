<template>
  <div class="setting">
    <!-- 导航 -->
    <van-nav-bar
      title="个人资料"
      right-text="保存"
      left-arrow
      @click-left="$router.back()"
      @click-right="saveUser"
    />
    <!-- 输入框 -->
    <van-cell-group v-for="(item, index) in setList" :key="index">
      <van-field v-model="item.username" label="昵称" />
      <van-field v-model="item.phone" label="手机号" />
      <van-field v-model="item.email" label="邮箱" />
      <van-field v-model="item.paypsd" type="password" label="支付密码" />
      <div class="sex">
        <span style="float:left">性别</span>
        <van-radio-group v-model="item.sex" style="float:left;margin-left:64px">
          <van-radio :name="0" checked-color="#07c160" style="float:left">女</van-radio>
          <van-radio :name="1" checked-color="#07c160" style="float:left;margin-left:30px">男</van-radio>
        </van-radio-group>
      </div>
    </van-cell-group>
    <van-button type="danger" @click="logout" size="large">退出当前账号</van-button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      // username: 'fatshady',
      // phone: '18707055159',
      // sex: '男',
      // email: '2350168078@qq.com',
      // 个人设置数组
      setList: []
    };
  },
  methods: {
    // 修改信息保存
    saveUser() {
      // 调用修改接口
      this.$http
        .put(`/setting/${this.setList[0].id}`, this.setList[0])
        .then(res => {
          // console.log(res)
          if (res.data.ok !== 1) {
            return this.$toast.fail(res.data.error);
          }
          // 修改成功
          this.$toast.success("修改信息成功");
          this.$router.push("/me");
        });
    },
    // 退出
    logout() {
      // 清除token
      localStorage.clear();
      // 去登录页
      this.$router.push("/login");
    }
  },
  created() {
    // 获取浏览器里存的id
    let id = window.localStorage.getItem("id");
    // 调用设置接口
    this.$http.get(`/setting/${id}`).then(res => {
      this.setList = res.data.data;
    });
  }
};
</script>

<style lang="less" scoped>
.setting {
  .van-field__control {
    color: #a2a2a2;
    font-size: 13px;
  }

  .van-field__label {
    font-size: 13px;
  }

  .van-button {
    margin-top: 20px;
  }
}

.sex {
  font-size: 12px;
  padding: 10px;
  padding-left: 18px;
  line-height: 20px;
}
.sex::after {
  content: "";
  display: block;
  clear: both;
}
</style>
