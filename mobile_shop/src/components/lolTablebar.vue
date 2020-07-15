<template>
  <div class="table-bar" ref="tableBar">
    <ul class="table-bar_content">
      <li :class="classes[0]" @click="tabChange(0)">
        <div class="home_icon icon"></div>
        <br />
        <div class="home_text text">首页</div>
      </li>
      <li :class="classes[1]" @click="tabChange(1)">
        <div class="sort_icon icon"></div>
        <br />
        <div class="sort_text text">分类</div>
      </li>
      <li :class="classes[2]" @click="tabChange(2)">
        <div class="shopping_icon icon"></div>
        <br />
        <div class="shopping_text text">购物车</div>
      </li>
      <li :class="classes[3]" @click="tabChange(3)">
        <div class="me_icon icon"></div>
        <br />
        <div class="me_text text">我</div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data () {
    return {
      to: ['/', '/sort', '/shopping', '/me'],
      classes: ['home active', 'sort', 'shopping', 'me'],
      defaultClasses: ['home', 'sort', 'shopping', 'me']
    }
  },
  methods: {
    tabChange (index) {
      this.classes = [...this.defaultClasses]
      this.classes[index] += ' active'
      this.$router.push(this.to[index])
    },
    childfn: function (toName) {
      // toName = 0 时就不让它显示
      if (toName === 0) {
        this.$refs.tableBar.style.display = 'none'
        return
      }

      this.$refs.tableBar.style.display = 'block'
      let index = this.defaultClasses.findIndex(item => item === toName)
      this.classes = [...this.defaultClasses]
      this.classes[index] += ' active'
    }
  },
  created () {}
}
</script>

<style lang="less" scoped>
* {
  transition: 300ms all;
}
#app {
  .table-bar {
    z-index: 500;
    width: 100%;
    height: 50px;
    border-top: 1px solid #f9f9f9;
    border-bottom: 1px solid #f9f9f9;
    box-sizing: border-box;
    position: fixed;
    bottom: 0px;
    background-color: #fff;
  }
  .table-bar ul {
    list-style: none;
    padding: 0;
    margin: 0;
    width: 100%;
    height: 100%;
  }
  .table-bar ul li {
    width: 25%;
    height: 100%;
    text-align: center;
    float: left;
    font-size: 12px;
    color: #a3a7ad;
  }
  .icon {
    width: 24px;
    height: 24px;
    margin-top: 4px;
    display: inline-block;
    background: url("../assets/img/ico-mall.png");
    background-size: 380px 500px;
    position: relative;
  }
  .text {
    display: inline-block;
  }
  .home_icon {
    background-position: -59px -117px;
  }
  .sort_icon {
    background-position: -2px -117px;
  }
  .shopping_icon {
    background-position: -277px -89px;
  }
  .me_icon {
    background-position: -147px -117px;
  }
  .active .text {
    color: #333;
  }
  .active .home_icon::after {
    display: block;
    content: "";
    width: 24px;
    height: 24px;
    position: absolute;
    left: 0;
    top: 0;
    background: url("../assets/img/ico-mall.png");
    background-size: 380px 500px;
    background-position: -88px -117px;
  }
  .active .sort_icon::after {
    display: block;
    content: "";
    width: 24px;
    height: 24px;
    position: absolute;
    left: 0;
    top: 0;
    background: url("../assets/img/ico-mall.png");
    background-size: 380px 500px;
    background-position: -30px -117px;
  }
  .active .shopping_icon::after {
    display: block;
    content: "";
    width: 24px;
    height: 24px;
    position: absolute;
    left: 0;
    top: 0;
    background: url("../assets/img/ico-mall.png");
    background-size: 380px 500px;
    background-position: -336px -89px;
  }
  .active .me_icon::after {
    display: block;
    content: "";
    width: 24px;
    height: 24px;
    position: absolute;
    left: 0;
    top: 0;
    background: url("../assets/img/ico-mall.png");
    background-size: 380px 500px;
    background-position: -117px -117px;
  }
  .shopping {
    padding: 0
  }
}
</style>
