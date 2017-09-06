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
//帖子详情
#define post_getallinfo     @"/interface.php/Home/Bbs/getallinfo"
//回帖1
#define post_sendmes        @"/interface.php/Home/Bbs/sendmes"
//回帖2
#define post_sendmestouser  @"/interface.php/Home/Bbs/sendmestouser"


//预约房间
#define post_orderup        @"/interface.php/Home/orderup/index"
//下单商品列表
#define post_goodslist      @"/interface.php/Home/orderup/goodslist"
//获得商品信息
#define post_getgoodsinfo   @"/interface.php/Home/orderup/getgoodsinfo"

//完善房间信息
#define post_finish_order_info  @"/interface.php/Home/orderup/finish_order_info"

//是否认证
#define post_is_renzheng    @"/interface.php/Home/User/is_renzheng"
//是否预约
#define post_isyuyue        @"/interface.php/Home/User/is_yuyue"

//认证接口
#define post_renzheng       @"/interface.php/Home/orderup/renzheng"

//我的订单
#define post_ordering       @"/interface.php/Home/User/ordering"

//我的钱包
#define post_wallet         @"/interface.php/Home/User/wallet"

//喜帖
#define post_getxitie       @"/interface.php/Home/orderup/getxitie"

#endif /* wangHeader_h */
