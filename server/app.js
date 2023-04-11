const express = require('express')
const bodyParser = require('body-parser')
const path = require('path')
const app = express()
const { db, genid } = require("./db/config")
const port = 3000

//开放端口使用
app.all('*', function (req, res, next) {
    //设置跨域允许访问的类型
    res.header('Access-Control-Allow-Origin', '*');
    //设置前端带过来的访问请求头
    res.header('Access-Control-Allow-Headers', 'Content-Type,token');
    //设置请求方法
    res.header('Access-Control-Allow-Methods', '*');
    //设置参数传递的类型？是form-data形式还是json格式？
    // res.header('Content-Type', 'application/json;charset=utf-8');
    // 因为我还要上传图片，所以不能只用json格式,所以干脆不限制，让浏览器自动判断就行了。
    // res.header('Content-Type', 'multipart/form-data');
    next();
});

app.use(express.static(path.join(__dirname, 'public')))
//处理post请求,解析json数据
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));


//定义中间件
//category/_token/add  有_token进行校验
const ADMIN_TOKEN_PATH = "/_token"

app.all("*", async (req, res, next) => {
    console.log('查找接口是否是权限接口中。。')
    // console.log(req.path.indexOf(ADMIN_TOKEN_PATH))
    if (req.path.indexOf(ADMIN_TOKEN_PATH) !== -1) {
        //权限验证测试，是否有token
        console.log('发现有token，进行校验。')
        let { token } = req.headers
        console.log(token)

        let admin_token_sql = "SELECT * FROM `admin` WHERE `token` = ?"
        let adminResult = await db.async.all(admin_token_sql, [token])
        //数据库中查找不到对应的token,先进行登录。如何查找到token的话
        if (adminResult.err !== null || adminResult.rows.length == 0) {
            res.send({
                code: 403,
                msg: '请先登录'
            })
            return
        }else{
            console.log('token正确了，进行下一步。')
            next()
        }
    } else {
        console.log('没有token，进行下一步。')
        next()
    }
})

// app.use('/text',require('./router/TestRouter'))
app.use('/admin', require('./router/AdminRouter'))
app.use('/category', require('./router/CategoryRouter'))
app.use('/blog', require('./router/BlogRouter'))
app.use('/upload', require('./router/UploadRouter'))


app.listen(port, () => {
    console.log(`启动成功:http://localhost:${port}/`)
})