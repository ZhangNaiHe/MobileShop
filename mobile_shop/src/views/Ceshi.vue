<template>
  <div class="ceshi">
    <!-- 基础用法 -->
    <div class="sku-container">
      <van-sku
        v-model="showBase"
        :sku="skuData.sku"
        :goods="skuData.goods_info"
        :goods-id="skuData.goods_id"
        :hide-stock="skuData.sku.hide_stock"
        :quota="skuData.quota"
        :quota-used="skuData.quota_used"
        :initial-sku="initialSku"
        reset-stepper-on-hide
        reset-selected-sku-on-hide
        disable-stepper-input
        :close-on-click-overlay="closeOnClickOverlay"
        :custom-sku-validator="customSkuValidator"
        @buy-clicked="onBuyClicked"
        @add-cart="onAddCartClicked"
      />
      <!-- <van-button block type="primary" @click="showBase = true">xxx</van-button> -->
    </div>
  </div>
</template>

<script>
// import skuData from './data'
export default {
  data () {
    return {
      skuData: {
        sku: {
          // 所有sku规格类目与其值的从属关系，比如商品有颜色和尺码两大类规格，颜色下面又有红色和蓝色两个规格值。
          // 可以理解为一个商品可以有多个规格类目，一个规格类目下可以有多个规格值。
          tree: [
            {
              k: '型号',
              k_id: '1',
              v: [
                {
                  id: '30349',
                  name: '常规'
                }
              ],
              k_s: 's1',
              count: 2
            },
            {
              k: '规格',
              k_id: '2',
              v: [
                {
                  id: '1193',
                  name: '常规'
                }
              ],
              k_s: 's2',
              count: 2
            }
          ],
          // 所有 sku 的组合列表，如下是：白色1、白色2、天蓝色1、天蓝色2
          list: [
            {
              id: 2257,
              price: 130,
              discount: 132,
              s1: '30349',
              s2: '1193',
              s3: '0',
              s4: '0',
              s5: '0',
              stock_num: 0, // 库存
              goods_id: 946755
            }
          ],
          price: '5.00',
          stock_num: 300, // 商品总库存
          none_sku: false, // 是否无规格商品
          hide_stock: false // 是否隐藏剩余库存
        },
        goods_id: '946755',
        quota: 3, // 限购数量
        quota_used: 0, // 已经购买过的数量
        goods_info: {
          title: '测试商品A',
          picture:
            'https://img.yzcdn.cn/upload_files/2017/03/16/Fs_OMbSFPa183sBwvG_94llUYiLa.jpeg?imageView2/2/w/100/h/100/q/75/format/jpg'
        },
        initialSku: {
          s1: '0001',
          s2: '1001',
          selectedNum: 3
        }
      },
      showBase: true,
      showCustom: false,
      showStepper: false,
      showSoldout: false,
      closeOnClickOverlay: true,
      initialSku: {
        s1: '30349',
        s2: '1193',
        selectedNum: 3
      },
      customSkuValidator: () => '请选择xxx!'
    }
  },

  methods: {
    // 商品规格
    getPropety () {
      this.$http.get('/product/1').then(res => {
        // console.log(res.data)
        // console.log(this.skuData)
        // 图片
        this.skuData.goods_info.picture = res.data.details_path[0].path
        // id
        this.skuData.goods_id = res.data.data[0].id
        this.skuData.sku.list[0].goods_id = res.data.data[0].id
        // 标题
        this.skuData.goods_info.title = res.data.data[0].name
        // 价钱
        this.skuData.sku.price = res.data.data[0].price
        this.skuData.sku.list[0].price = res.data.data[0].price * 100
        // 剩余
        this.skuData.sku.stock_num = res.data.data[0].inventory
        this.skuData.sku.list[0].stock_num = res.data.data[0].inventory
        // 规格
        this.skuData.sku.tree[0].v.name = res.data.data[0].property
        this.skuData.sku.tree[1].v.name = res.data.data[0].property
      })
    },

    onBuyClicked (data) {
      this.$toast('buy:' + JSON.stringify(data))
      // console.log(JSON.stringify(data))
    },

    onAddCartClicked (data) {
      // this.$toast('add cart:' + JSON.stringify(data))
      // 添加到购物车
      // console.log(data)

      let cartList = {
        goods_id: data.goodsId,
        count: data.selectedNum,
        ischk: 0,
        user_id: 1,
        standards: '常规'
      }
      this.$http.post('/cart', cartList).then(res => {
        // console.log(res)
        this.$toast('已加入购物车')
        this.showBase = false
      })
    }
  },
  created () {
    this.getPropety()
  }
}
</script>

<style scoped>
</style>
