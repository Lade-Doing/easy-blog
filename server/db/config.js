const mysql = require('mysql')
const GenId = require('../utils/SmokeFlake')

const genid = new GenId({WorkerId:1})
var db = mysql.createConnection({
    host: 'localhost',
    port: '3306',
    user: 'root',
    password: 密码,
    database: 'blog'
})
db.connect( (err) => {
    if (err) {
        console.log('数据库连接失败')
    } else {
        console.log('数据库连接成功')
    }
})
db.async = {} //创建一个空对象
db.async.all = (sql,params)=>{
    return new Promise((resolve,reject)=>{
        db.query(sql,params,(err,rows) => {
            resolve({err,rows})
        })
    })
}

module.exports={
    db,
    genid
}
