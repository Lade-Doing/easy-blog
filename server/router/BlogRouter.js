const express = require('express')
const router = express.Router()
const { db,genid } = require("../db/config")
/**
 * 博客文章内容有添加、修改、删除、查询
 */

//文章详细
router.get("/detail", async (req, res) => {

    let { id } = req.query
    let detail_sql = "SELECT * FROM `blog` WHERE `id` = ? "
    let { err, rows } = await db.async.all(detail_sql, [id]) ;

    if (err == null) {
        res.send({
            code: 200,
            msg: "获取成功",
            rows
        })
    } else {
        res.send({
            code: 500,
            msg: "获取失败"
        })
    }

})
//查询博客
router.post('/search', async (req, res) => {
    /**
     * keyword 关键字
     * 要不是按照分类名字查询要不然就是按照关键字查询标题或者是内容
     * 
     */
    let { keyword, categoryId, page, pageSize } = req.body
    page = page == null ? 1 : page
    pageSize = pageSize == null ? 2 : pageSize
    categoryId = categoryId == null ? 0 : categoryId
    keyword = keyword == null ? "" : keyword


    //拼接MySQL语句
    let params = []
    let whereSqls = []
    if (categoryId != 0) {
        whereSqls.push(" `category_id` = ? ")
        params.push(categoryId)
    }

    if (keyword !== "") {
        whereSqls.push("(`title` LIKE ? OR `content` LIKE ?)")
        params.push("%" + keyword + "%")
        params.push("%" + keyword + "%")
    }

    let whereSqlStr = ""
    if (whereSqls.length > 0) {
        whereSqlStr = "WHERE" + whereSqls.join(" AND ")
    }
    // console.log(params)
    // console.log(whereSqlStr)
    //查找分页数据
    let searchSql = "SELECT * FROM `blog` " + whereSqlStr + " ORDER BY `create_time` DESC LIMIT ?,?"
    let searchSqlParams = params.concat([(page - 1) * pageSize, pageSize])

    //查询数据总数
    let searchCountSql = "SELECT count(*) As count FROM `blog`" + whereSqlStr
    let searchCountParams = params

    //分页查找sql
    let searchResult = await db.async.all(searchSql, searchSqlParams)
    let countResult = await db.async.all(searchCountSql, searchCountParams)

    console.log(searchSql)
    console.log(searchCountSql)
    console.log(searchResult.err)
    console.log(countResult.err)
    if (searchResult.err === null && countResult.err === null) {
        res.send({
            code: 200,
            msg: '查询成功',
            data: {
                keyword,
                categoryId,
                page,
                pageSize,
                rows: searchResult.rows,
                count:countResult.rows[0].count
            }
        })
    } else {
        res.send({
            code: 500,
            msg: '查询失败'
        })
    }
})






//添加 验证成功
router.post("/_token/add", async (req, res) => {
    let { title, categoryId, content } = req.body
    let id = genid.NextId()
    let create_time = new Date().getTime();
    const insert_sql = "INSERT INTO `blog`(`id`,`title`,`category_id`,`content`,`create_time`) VALUES(?,?,?,?,?)"
    let params = [id, title, categoryId, content, create_time]

    let { err, rows } = await db.async.all(insert_sql, params)

    if (err === null) {
        res.send({
            code: 200,
            msg: "添加成功"
        })
    } else {
        res.send({
            code: 500,
            err,
            msg: "添加失败"
        })
    }
})
//修改 验证成功
router.put("/_token/update", async (req, res) => {
    let { id, title, categoryId, content } = req.body
    // let update_time = new Date().getTime()  之后再添加功能

    const update_sql = "UPDATE `blog` SET `title` = ?,`content` = ?,`category_id` = ? WHERE `id` = ?"
    let params = [title, content, categoryId, id]
    let { err, rows } = await db.async.all(update_sql, params)
    if (err === null) {
        res.send({
            code: 200,
            msg: "修改成功"
        })
    } else {
        res.send({
            code: 500,
            err,
            msg: "修改失败"
        })
    }
})
//删除  验证成功
router.delete("/_token/delete", async (req, res) => {
    let id = req.query.id
    const delete_sql = "DELETE FROM `blog` WHERE `id` = ?"
    let { err, rows } = await db.async.all(delete_sql, [id])
    if (err === null) {
        res.send({
            code: 200,
            msg: "删除成功"
        })
    } else {
        res.send({
            code: 500,
            err,
            msg: "删除失败"
        })
    }
})
module.exports = router