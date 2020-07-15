import Vue from 'vue'
import VueRouter from 'vue-router'
import Index from '../views/Index.vue'

import { Toast } from 'vant'
Vue.use(Toast)

Vue.use(VueRouter)

const routes = [
  // 首页
  {
    path: '/',
    name: 'index',
    component: Index
  },
  // 登录页
  {
    path: '/login',
    name: 'login',
    component: () => import('../views/Login.vue')
  },
  // 注册
  {
    path: '/register',
    name: 'register',
    component: () => import('../views/Register.vue')
  },
  // 分类
  {
    path: '/sort',
    name: 'sort',
    component: () => import('../views/Sort.vue')
  },
  // 搜索
  {
    path: '/search',
    name: 'search',
    component: () => import('../views/Search.vue')
  },
  // 购物车
  {
    path: '/cart',
    name: 'cart',
    component: () => import('../views/Cart.vue'),
    meta: { mustLogin: true }
  },
  // 我
  {
    path: '/me',
    name: 'me',
    component: () => import('../views/Me.vue'),
    meta: { mustLogin: true }
  },
  // demo
  {
    path: '/demo',
    component: () => import('../components/demo.vue')
  },
  // 我的订单页
  {
    path: '/order',
    component: () => import('../views/Order.vue'),
    meta: { mustLogin: true }
  },
  // 商品详情页
  {
    path: '/product/:id',
    component: () => import('../views/Product.vue')
  },
  // 商品评论页
  {
    path: '/comment/:id',
    component: () => import('../views/Comment.vue')
  },
  {
    path: '/shopping',
    component: () => import('../views/Shopping.vue'),
    meta: { mustLogin: true }
  },
  // 测试
  {
    path: '/ceshi',
    component: () => import('../views/Ceshi.vue'),
    meta: { mustLogin: true }
  },
  // 设置页
  {
    path: '/setting',
    component: () => import('../views/Setting.vue')
  },
  // 地址
  {
    path: '/site',
    component: () => import('../views/Site.vue'),
    meta: { mustLogin: true }
  },
  // 添加地址
  {
    path: '/addsite',
    component: () => import('../views/Addsite.vue'),
    meta: { mustLogin: true }
  },
  // 我的评价
  {
    path: '/selfcom',
    component: () => import('../views/Selfcom.vue')
  },
  // 支付页面
  {
    path: '/pay',
    component: () => import('../views/Pay.vue'),
    meta: { mustLogin: true }
  },
  // 去结算页面
  {
    path: '/account',
    component: () => import('../views/Account.vue')

  },
  // 发表评论
  {
    path: '/addComment',
    component: () => import('../views/AddComment.vue'),
    meta: { mustLogin: true }

  }

]

window.document.title = '移动端手机商城'

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})
// 路由导航守卫
router.beforeEach((to, form, next) => {
  // 根据meta里判断有没有mustLogin属性
  if (to.meta !== undefined && to.meta.mustLogin !== undefined && to.meta.mustLogin) {
    // 判断有没有token
    let token = localStorage.getItem('token')
    // 如果没token 就去登录页
    if (!token) {
      Toast('请先登录')
      return next('/login')
    }
  }
  // 否则放行
  next()
})

export default router
