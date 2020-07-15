// 创建路由
const router = require('express').Router()
// 引入数据库
const db = require('../db');
// 加密密文
const md5_key = require('../config').md5_key
// md5
const md5 = require('md5')
// 查询商品
router.post('/register', (req, res) => {


    let username = req.body.username;
    let password = req.body.password;
    let phone = req.body.phone
    let path = req.body.path



    let mobRef = /^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$/
    let passRef = /^[\w_-]{6,16}$/
    let userRef = /^[\u4e00-\u9fa5A-Za-z0-9-_]*$/

    // 手机号正则验证
    if (!mobRef.test(phone)) {
        res.json({
            "ok": 0,
            "error": "手机号码格式不正确"
        })
        return
    }
    // 昵称正则
    if (!userRef.test(username)) {
        res.json({
            "ok": 0,
            "error": "只能中英文，数字，下划线，减号"
        })
        return
    }
    // 密码正则验证
    if (!passRef.test(password)) {
        res.json({
            "ok": 0,
            "error": "密码必须是6-16位字母数字_-组成！"
        })
        return
    }

    let sql = `select count(*) m from user where phone = ?`

    // 查询手机号是否已经添加过
    db.query(sql, phone, (err, data) => {
        if (err) {
            res.json({
                "ok": 0,
                "error": err
            })
        } else {
            // 如果不等于0 则代表手机号已经存在 ，不能再添加
            if (data[0].m !== 0) {
                res.json({
                    "ok": 0,
                    "error": "手机号码已存在！"
                })
                return
            } else {


                let sql2 = 'insert into user set ?'
                let data = {
                    phone: phone,
                    password: md5(password + md5_key),
                    username: username,
                    path: path
                }
                db.query(sql2, data, (err, data) => {
                    if (err) {
                        console.log(err)
                        res.json({
                            "ok": 0,
                            "error": "手机号格式不正确"
                        })
                    } else {
                        res.json({
                            "ok": 1
                        })

                    }
                })
            }


        }
    })


})

// 暴露路由
module.exports = router