// 引入md5
const md5 = require('md5');
const { md5_key } = require('../config');
// 引入数据库
const db = require('../db');
// 引入令牌
const jwt = require('../jwt');
// 创建路由
const router = require('express').Router();

// 注册管理员
router.post('/abmregist', (req, res) => {
    //   接收表单中的数据
    let username = req.body.username
    let password = req.body.password

    //   验证用户名
    if (!username) {
        res.json({
            'status': 400,
            'error': '用户名不能为空'
        })
        return
    }
    //  验证密码
    let passwordRe = /^[0-9a-zA-Z_]{6,18}$/
    if (!passwordRe.test(password)) {
        res.json({
            'status': 400,
            'error': '密码必须是6到18位的数字、字母、下划线！'
        })
        return
    }
    // 判断用户名是否已经存在
    let sql = 'SELECT COUNT(*) c FROM admin WHERE username = ?'
    db.query(sql, username, (error, results) => {
        if (error) return console.log(error)
        //    res.json(results)
        // 判断数据库中是否已经存在这个管理员的纪录
        if (results[0].c > 0) {
            res.json({
                'status': 400,
                'error': '用户名已存在'
            })
            return
        } else {
            sql = 'INSERT INTO admin SET ?'
            let data = {
                username,
                //   将密码加密
                password: md5(password + md5_key)
            }
            db.query(sql, data, (error, results) => {
                if (error) return console.log(error);

                res.json({
                    'status': 200
                })
            })
        }
    })
})

// 登录
router.post('/abmlogin', (req, res) => {
    // 获取 用户昵称和密码
    let username = req.body.username;
    let password = req.body.password;

    // sql语句
    let sql = 'SELECT * FROM admin WHERE username = ?';

    db.query(sql, [username], (error, results, fields) => {
        if (error) return console.log(error);
        // 判断用户昵称是否存在
        if (results[0]) {
            // 判断密码是否正确
            if (password == results[0].password) {
                results[0].password = '******';
                res.json({
                    "status": 200,
                    "message": "登录成功",
                    "data": results[0],
                    "token": jwt.makeJWT({
                        id: results[0].id
                    })
                })
                return
            } else {
                res.json({
                    "status": 400,
                    "error": "密码错误"
                })
                return
            }
        } else {
            res.json({
                "code": 400,
                "error": "用户名不存在"
            })
            return
        }
    })
})


module.exports = router;