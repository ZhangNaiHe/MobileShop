import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

// 引入vantui
import Vant from 'vant'
import 'vant/lib/index.css'

// 配置axios
import axios from 'axios'
import '@vant/touch-emulator'

// 全局注册

axios.defaults.baseURL = 'http://localhost:9999/api/v1'
Vue.prototype.$http = axios
Vue.config.productionTip = false
Vue.use(Vant)
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
