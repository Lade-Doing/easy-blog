/**
 * axios 
 * pinia
 * sass
 * vue-router
 * naive-ui
 */
import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
//引入naive-ui
import naive from 'naive-ui'
//引入全局组件API
import { createDiscreteApi } from 'naive-ui'
//引入pinia
import { createPinia } from 'pinia'
//引入路由
import { router } from './common/router'
//引入axios
import axios from 'axios'
//全局配置请求地址
axios.defaults.baseURL = "http://localhost:3000"
//引入全局store
import { AdminStore } from './store/AdminStore'
//创建全局API
const { message, notification, dialog } = createDiscreteApi(["message", "dialog", "notification"])

const app = createApp(App)

// 全局提供属性
app.provide("axios", axios)
app.provide("message", message)
app.provide("notification", notification)
app.provide("dialog", dialog)
app.provide("server_url", axios.defaults.baseURL )


app.use(naive)
app.use(createPinia())
app.use(router)

const adminStore = AdminStore()
//axios拦截器
axios.interceptors.request.use((config)=>{
    //每次请求都在headers中添加token
    config.headers.token = adminStore.token
    return config
})

app.mount('#app')
