const express = require('express')
const router = express.Router()
const { db,genid } = require("../db/config")


router.get("/search",async(req,res)=>{
    const target = "ADMIN"
    const sql = "SELECT * FROM " + target
    const reuslt = await db.async.all(sql,[])
    res.send(reuslt)
})
module.exports = router