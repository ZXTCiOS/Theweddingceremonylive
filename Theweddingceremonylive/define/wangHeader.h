//
//  wangHeader.h
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/10.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#ifndef wangHeader_h
#define wangHeader_h

#define KTime   20//设置重新发送的时间  自己可以改


#define user_token  @"TOKEN"
#define user_uid    @"UID"



#define BASE_URL   @"http://88.irapidtech.net/"

//注册
#define post_logup          @"/interface.php/Home/register/register"
//登录验证
#define post_login          @"/interface.php/Home/Login/login"
//验证码
#define post_value          @"/interface.php/Home/Login/getVerify"
//完善个人信息
#define post_edit           @"/interface.php/Home/User/edit"

#define post_value          @"/interface.php/Home/Login/getVerify"


//找回密码
#define post_getpwd         @"/interface.php/Home/Login/getpwd"
//查询个人信息
#define post_getinfo        @"/interface.php/Home/User/getinfo"
//登录后完善个人信息
#define post_finish         @"/interface.php/Home/User/finish"
//修改密码
#define post_editpwd        @"/interface.php/Home/User/editpwd"
//修改手机号
#define post_editphone      @"/interface.php/Home/User/editphone"
//我的礼物列表
#define post_getgift        @"/interface.php/Home/User/getgift"
//查送礼物人信息
#define post_finduserinfo   @"/interface.php/Home/User/finduserinfo"
//关注的商家
#define post_guanzhu        @"/interface.php/Home/User/getguanzhu"
//我的订单

//论坛首页
#define post_bbsgetinfo     @"/interface.php/Home/Bbs/getinfo"
//发帖
#define post_fatie          @"/interface.php/Home/Bbs/post"

//点赞
#define post_point          @"/interface.php/Home/Bbs/point"
#endif /* wangHeader_h */
