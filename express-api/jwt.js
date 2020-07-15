const jwt = require('jsonwebtoken')
const express = require('express')
const { md5_key } = require('./config')

// 创建路由对象
var router = express.Router()

// 中间件 - 验证令牌
router.use((req, res, next) => {
    // 判断是否提交了令牌
    if (req.headers.authorization === undefined) {
        res.json({
            code: "401"
        })
    } else {
        // 获取令牌
        let token = req.headers.authorization.replace(/^Bearer /, '')
        console.log(token);
        console.log(md5_key);

        try {
            // console.log(111);

            // 解析令牌
            var decoded = jwt.verify(token, md5_key);
            //    console.log(decoded);

            // 把解析的数据保存到 req.user 上
            req.user = decoded
            // 继续执行后继代码
            // console.log(req.user)
            next()
        } catch (err) {
            res.json({
                code: "401"
            })
        }
    }
})

// 生成令牌的函数
const makeJWT = function (data) {
    return jwt.sign(data, md5_key, { expiresIn: '2h' })
}

module.exports = {
    makeJWT,
    router
}