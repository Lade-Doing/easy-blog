import { createRouter, createWebHashHistory } from "vue-router"

let routes = [
    {path:'/test',component:()=> import('../views/Test.vue')},
    { path: "/", component: () => import("../views/HomePage.vue") },
    { path: "/detail", component: () => import("../views/Detail.vue") },
    {path:'/login',component:()=> import('../views/Login.vue')},
    {
        path: "/dashboard", component: () => import("../views/dashboard/Dashboard.vue"), children: [
            { path: "/dashboard/category", component: () => import("../views/dashboard/Category.vue") },
            { path: "/dashboard/article", component: () => import("../views/dashboard/Article.vue") },
        ]
    },
    
]

const router = createRouter({
    history: createWebHashHistory(),
    routes,
})

export { router, routes }