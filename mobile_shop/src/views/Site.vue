<template>
  <div class="site">
<van-nav-bar
  title="收货地址"
  left-arrow
  @click-left="$router.go(-1)"
/>
<van-address-list
  v-model="chosenAddressId"
  :list="addressList"
  @select="onSelect"
  @add="onAdd"
  @edit="onEdit"
>

</van-address-list>
<van-row>
  <van-col span="9"></van-col>
  <van-col span="6">
     <van-button style="width:100%" round  color="#ffd474" size="small" to="/addsite">新建收货地址</van-button>
  </van-col>
  <van-col span="8"></van-col>
</van-row>
  </div>
</template>

<script>
// 轻提示
import { Toast } from 'vant'
export default {
  data () {
    return {
      //  默认收货地址
      chosenAddressId: 0,
      // 收货地址数据
      addressList: [

      ]

    }
  },
  methods: {
    onAdd () {

    },

    onEdit (item, index) {

    },
    onSelect (item, index) {
      // console.log(item.id)
      let id = item.id
      this.$http.get(`/address/1/${id}`).then(res => {
        if (res.data.ok === 1) {
          Toast('已修改默认收货地址')
        } else {
          Toast('修改失败')
          return false
        }
      })
    },
    getAddress () {
      let id = window.localStorage.getItem('id')
      this.$http.get(`address/${id}`).then(res => {
        // console.log(res)
        res.data.data.forEach(v => {
          // console.log(v)
          v.address = v.province + v.city + v.county + v.addressDetail
          if (v.isDefault === 1) {
            this.chosenAddressId = v.id
          }
        })
        this.addressList = res.data.data
        // console.log(this.addressList)
      })
    }
  },
  created () {
    //  console.log(new Date().toString())
    this.getAddress()
    this.addressList.forEach(v => {
      if (v.isDefault === 1) {
        v.isDefault = true
        this.chosenAddressId = v.id
      }
    })
  }
}
</script>

<style scoped>
.van-address-item .van-radio__icon--checked .van-icon {
    background-color: #ffe354;
    border-color: #ffe354;
}
.van-radio__icon--checked .van-icon {
    color: #393835;

}
.site .van-button__text{
   color:#333333;
}
.van-row {
    position: fixed;
    width: 100%;
    height: 66px;
    bottom: -13px;
    z-index: 2000;
    background-color: #fff;
}
.van-nav-bar {
  background: #ffd474;
}
</style>
