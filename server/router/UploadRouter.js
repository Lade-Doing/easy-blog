const express = require('express')
const router = express.Router()
const path = require('path')
const formidable = require('formidable');
const { db,genid } = require("../db/config")


// 实现文件上传的路由
router.post("/file", async (req, res) => {
	// console.log(req)
	// 创建formidable表单解析对象
	const form = new formidable.IncomingForm({
		//配置上传文件的存放位置
		uploadDir: path.join(__dirname, '../', 'public', 'uploads'),
		//保留上传文件后缀
		keepExtensions: true,
	})
	form.parse(req, (err, fields, files) => {
		// 将客户端传递过来的文件地址响应到客户端
		if(err){
			return res.send(
				{
					errno:1,
					message:"出现异常",
					err
				}
			)
		}
		// console.log(files['wangeditor-uploaded-image'].filepath.split('public')[1])
		return res.send({
			errno:0,
			data:{
				url:files['wangeditor-uploaded-image'].filepath.split('public')[1],
				alt:'无'
			}
		});
	});
})
module.exports = router