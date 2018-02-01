//
//  Config.h
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/8.
//  Copyright © 2017年 付新明. All rights reserved.
//

#ifndef Config_h
#define Config_h
#define Server_Host @"http://121.199.18.39"


#define APP_ID          @"wx432ceec6c2fa0341"               //APPID
#define APP_SECRET      @"9e7f2ca5bf9eb3494b578334e2ccb468" //appsecret
#define MCH_ID          @"1433460702"//商户号，填写商户对应参数
// 支付宝回调Scheme
#define Alipay_Scheme @"com.yunjukeji.huiqitian.alipay"
#define Alipay_AppId @"2016080901724989"


#define  GTAppID @"hc3fsjGD0j5qy78X6wY0e6"
#define  GTAppSecret @"EW9OmjaDPRALxj2516VkF7"
#define  GTAppKey @"vM5DJiMIEbA30u56VWo0H7"

#define BaiduMapKey @"IGyD5uYcglnM52z7HZNMjhG0ZwVmf40j" //yunju.com.huiqitian
//#define BaiduMapKey @"mFwSu2gl85dGFuhTmFOIltR07d0z7G0v" //com.shanjin.OMeng.PA
//URL
//获取验证码
#define Api_GetPhoneCode @"/app/pin/gen.do"
//验证验证码
#define Api_CheckPhoneCode @"/app/pin/verify.do"

//接口名称：快速注册 mobile pin password
#define Api_QuickReg @"/app/buyer/reg.do"
//接口名称：登录 user_name password
#define Api_BuyerLogin @"/app/buyer/login.do"
#define Api_Buyer_getuser @"/app/buyer/getuser.do"

//接口名称：验证手机号码是否已被注册 mobile
#define Api_BuyerCkmobile @"/app/user/ckmobile.do"
//接口名称：设置用户当前位置 lng：经度 lat：纬度
#define Api_BuyerLocate @"/app/buyer/locate.do"
//接口名称：绑定CID CID：（String，必填）
#define Api_cid_bind @"/app/cid/bind.do"
//接口名称：获取积分
#define Api_buyer_getpoint @"/app/buyer/getpoint.do"

//接口名称：获取金币
#define Api_buyer_getcoin @"/app/buyer/getcoin.do"
//首页接口------------------------------------------------------
/*
curpage：当前多少页（Integer，非空）
rp：每页多少条（Integer，非空）
sortname：排序字段（String，非空）{
    销量："qty"
    口碑："score"
    价格："price"
    距离："distance"
}
sortorder：{
    升序："asc"
    倒序："desc"
}
 */
//接口名称：进口食品组 需要登录：否 curpage：当前多少页（Integer，非空） rp：每页多少条（Integer，非空）
#define Api_BuyerGoodImport @"/app/buyer/good/import.do"
//接口名称：获取买家App轮播图
#define Api_BuyerCarousel @"/app/buyer/carousel.do"
//接口名称：为你推荐猜你喜欢
#define Api_BuyerGoodRecommend @"/app/buyer/good/recommend.do"

//接口名称：获取某店铺的热卖商品
#define Api_BuyerGoodHot @"/app/buyer/good/hot.do"
//接口名称：搜索商品
#define Api_BuyerGoodSearch @"/app/buyer/good/search.do"

//接口名称：通过分类和排序获取商品分类接口参数：{
	//curpage：当前多少页（Integer，非空）
	//rp：每页多少条（Integer，非空）
	//sortname：排序字段（String，非空）{
	//	销量："qty"
	//	口碑："score"
	//	价格："price"
	//	距离："distance"
	//}
	//sortorder：{
	//	升序："asc"
	//	倒序："desc"
	//}
	//catId：分类编号（Integer，非空）
//}
#define Api_Buyer_Good_listbycat @"/app/buyer/good/listbycat.do"



//接口名称：通过level检索商品分类
#define Api_CategoryList @"/app/category/list.do"


//接口名称：获取商品的评价summary
//id：商品编号（Integer，必填）
//type：商品类型（byte，0：正常商品，2：每日精选，3：秒杀，必填）
//分页参数
#define Api_Buyer_GoodEval @"/app/buyer/good/eval/summary.do"


#define Api_GetCityList @"/app/area.do"

//接口名称：获取用户代金券 //status：代金券状态，1未使用2已使用3已过期
#define Api_buyer_voucher @"/app/buyer/voucher/list.do"


//接口名称：修改用户头像
#define Api_buyer_avatar_change @"/app/buyer/avatar/change.do"


//接口名称：修改用户信息
//接口参数：（参数可以是一个或者组合）{
//	nickName：昵称（String，20个汉字）
//	realName：真实姓名（String，20个汉字）
//	sex：性别（byte，0--保密，1--男，2--女）
//	birthday：生日（String，yyyy-MM-dd)
//	name : String (必填)
//	mobile : String (必填)
//}
#define Api_buyer_modify @"/app/buyer/modify.do"

//接口名称：修改绑定手机
//接口参数：{
//	mobile：手机号码(String，必填)
//	pin：验证码(String，必填)
//}
#define Api_buyer_setmobile @"/app/buyer/setmobile.do"

//接口名称：获取用户收货地址
#define Api_buyer_address_list @"/app/buyer/address/list.do"

//接口名称：购物车添加 id：商品编号（Integer） type：商品类型（byte，0：正常商品，2：每日精选，3：秒杀
#define Api_buyer_cart_add @"/app/buyer/cart/add.do"
//接口名称：购物车删除
#define Api_buyer_cart_del @"/app/buyer/cart/del.do"
//接口名称：去结算
#define Api_buyer_cart_estimate @"/app/buyer/cart/estimate.do"
//接口名称：购物车商品修改数量
#define Api_buyer_cart_alterqty @"/app/buyer/cart/alterqty.do"
//接口名称：购物车订单提交cartGoodsIds：购物车id集合(Integer[], 非空) orderOrigin：订单来源(Byte, 非空) deliveryInfoId：收货信息编号(Integer, 非空)voucher：代金券({id:代金券id(Integer)}) message：订单留言(String)
#define Api_buyer_order_add @"/app/buyer/order/add.do"

//接口名称：购物车查看
#define Api_buyer_cart_list @"/app/buyer/cart/list.do"

//接口名称：立即购买 需要登录：是 id：商品id(Integer,必须) type：商品类型(Byte,必须)
#define Api_buyer_good_buying @"/app/buyer/good/buying.do"

//接口名称：立即购买提交订单
//goodsId：商品id(Integer,必须) type：商品类型(Byte,必须) deliveryInfoId：收货信息id(Integer,必须) orderOrigin：订单来源(Byte,必须) 1 安卓, 2 iPhone voucherId：代金券id(Integer,可无)
#define Api_buyer_order_buying @"/app/buyer/order/buying.do"

//接口名称：微信支付预下单 //ids ids：订单id集合(String[]) 必填
#define Api_buyer_order_wechatpay @"/app/buyer/order/wechatpay.do"

//接口名称：微信支付预下单 //ids ids：订单id集合(String[]) 必填
#define Api_buyer_order_alipay @"/app/buyer/order/alipay.do"

//接口名称：获取当前用户的所有订单 curpage：当前多少页（Integer，非空） rp：每页多少条（Integer，非空） state：订单状态(全部-0,待付款-1,待发货-3,待收货-4,待评价-5)
#define Api_buyer_order_list @"/app/buyer/order/list.do"
//各状态数量
#define Api_buyer_order_listcnt @"/app/buyer/order/listcnt.do"
//接口名称：订单详情 id：订单id(String, 必填)
#define Api_buyer_order_view @"/app/buyer/order/view.do"
//接口名称：订单删除 id：订单id
#define Api_buyer_order_del @"/app/buyer/order/del.do"

//接口名称：获取附近店铺
#define Api_buyer_market_list @"/app/buyer/market/list.do"

//接口名称：获取某店铺的今日上新
#define Api_buyer_good_latest @"/app/buyer/good/latest.do"
//接口名称：反馈 text
#define Api_buyer_opinion_add @"/app/buyer/opinion/add.do"
//接口名称：新增地址
#define Api_buyer_address_add @"/app/buyer/address/add.do"
//接口名称：编辑地址
#define Api_buyer_address_update @"/app/buyer/address/update.do"
//接口名称：删除地址
#define Api_buyer_address_del @"/app/buyer/address/del.do"
//接口名称：设置默认收货地址
#define Api_buyer_address_setdefault @"/app/buyer/address/setdefault.do"
//接口名称：查看订单配送信息
#define Api_buyer_order_viewdispatch @"/app/buyer/order/viewdispatch.do"

//接口名称：确认订单
#define Api_buyer_order_confirm @"/app/buyer/order/confirm.do"
//接口名称：订单商品评价基础数据
#define Api_goods_evalbase @"/app/goods/evalbase.do"
//接口名称：评价提交
#define Api_order_eval_add @"/app/buyer/order/eval/add.do"
//接口名称：订单投诉查看
#define Api_buyer_complaint_view @"/app/complaint/get.do"
//接口名称：添加投诉
#define Api_buyer_complaint_add @"/app/buyer/complaint/add.do"
//接口名称：图片上传
#define Api_img_save @"/app/img/save.do"

//接口名称：获取商品的详细评价
#define Api_buyer_good_eval_list @"/app/buyer/good/eval/list.do"



//接口名称：签到首页初始化
#define Api_buyer_signin_init @"/app/buyer/signin/init.do"
//接口名称：查看抽奖商品
#define Api_buyer_luckygood_list @"/app/buyer/luckygood/list.do"
//接口名称：查看当前用户的所有中奖记录
#define Api_buyer_lucky_list @"/app/buyer/lucky/list.do"

//接口名称：签到
#define Api_buyer_signin_signin @"/app/buyer/signin/signin.do"

//接口名称：查看金币明细
#define Api_buyer_coin_list @"/app/buyer/coin/list.do"

//接口名称：抽奖
#define Api_buyer_lucky_draw @"/app/buyer/lucky/draw.do"

//接口名称：查看所有积分商品
#define Api_buyer_pointgood_list @"/app/buyer/pointgood/list.do"

//接口名称：积分商品兑换
#define Api_buyer_pointgood_exchange @"/app/buyer/pointgood/exchange.do"

//接口名称：查看积分商城兑换记录
#define Api_buyer_exchange_list @"/app/buyer/exchange/list.do"

//---------------------------------------------------------------
#endif /* Config_h */
