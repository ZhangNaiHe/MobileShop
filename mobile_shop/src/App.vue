<template>
  <div id="app">
    <tableBar v-show="false" ref="tableBar"></tableBar>
    <router-view ref="view" @getTo="getTo" />
    <tableBar ref="tableBar"></tableBar>
  </div>
</template>

<script>
import tableBar from './components/lolTablebar.vue'
export default {
  components: {
    tableBar: tableBar
  },
  data () {
    return {
      toName: 'home'
    }
  },
  methods: {
    getTo (data) {
      this.toName = data
      this.$refs.tableBar.childfn(this.toName)
    },
    created () {
      window.document.title = '移动端手机商城'
    }
  }
}
</script>

<style lang="less" scoped>
#app {
  // background-color: #f3f4f6;
  .van-image {
    position: relative;
    display: inline-block;
    height: 190px;
    display: flex;
    align-items: center;
    background: #fff;
    overflow: hidden;

    img {
      height: auto;
    }
  }

  .classify_btns {
    .van-image {
      background: none;
    }
  }

  .van-swipe{
    .van-image {
      background: none;
      height: auto;
    }
  }

  #xiangqing {
    .van-image {
      height: auto;
    }
  }
}
</style>
