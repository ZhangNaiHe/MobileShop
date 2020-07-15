// 引入express并创建路由
const router = require('express').Router()
// 引入fs包
const fs = require('fs')
// 引入path包
const path = require('path')
// 引入上传文件中间件
const multer = require('multer')
// 引入数据库
const db = require('../db')
// 定义保存图片的地址
const saveImg = './public/images/'
// 网页访问图片时的地址
const fileBaseUrl = 'http://localhost:9999/api/v1/public/images/'
// 上传图片接口
router.put('/upload/:id', multer().single('file'), (req, res) => {
    // console.log(req.file)
    let id = req.params.id
    console.log(id);
    // let token = req.headers.Authorization
    try {
        let {
            buffer,
            originalname
        } = req.file
        // 把图片写入public文件里
        fs.writeFileSync(path.join(__dirname, saveImg + originalname), buffer)
        // 拿到图片地址
        let imgUrl = fileBaseUrl + originalname
        // 把图片地址添加进数据库用户表里
        console.log(imgUrl);
        // tokeId(token)
        let sql = `update user set path = '${imgUrl}' where id = ${id}`
        db.query(sql, (error, result) => {
            res.json({
                'status': 200,
                'imgUrl': imgUrl
            })
            
        })
    } catch (err) {
        res.json(err)
    }
})

// 返回图片
router.get('/public/images/*', (req, res) => {
    let imgName = req.params[0]
    res.sendFile(path.join(__dirname, saveImg + imgName))
})

// 暴露路由
module.exports = router;
