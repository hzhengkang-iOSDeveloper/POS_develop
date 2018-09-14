//
//  HPDStatusCode.h
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import <Foundation/Foundation.h>

// soap methods
extern NSString *const kSoapMethodUserLogin;        ///< user login method {login_name, login_pwd}
extern NSString *const kSoapMethodUserLogout;       ///< user logout method {nil}
extern NSString *const kSoapMethodDailyBids;        ///< daily bid {nil}
extern NSString *const kSoapMethodBidDetail;        ///< bid/order detail {order_id}
extern NSString *const kSoapMethodBidDetailM;       ///< 标的详情 新接口
extern NSString *const kSoapMethodhqtDetailM;
extern NSString *const kSoapMethodSendMessage;      ///< to get phone vertify code if forget trade number {nil}
extern NSString *const kSoapMethodRetrievePassword; ///< get phone vertify code if forget password {phone}
extern NSString *const kSoapMethodVertifyCode;      ///< vertify the phone code for find back login password {phone, verification_code}
extern NSString *const kSoapMethodModifyPassword;   ///< modify the login password {phone, password}
extern NSString *const kSoapMethodModifyPasswordM;  ///< 修改密码
extern NSString *const kSoapMethodModifyTradePassword;          ///< modify trade password {pay_pwd} @cookie yes
extern NSString *const kSoapMethodFeedback;         ///< feedback user ideas {contact}
extern NSString *const kSoapMethodGetCode;          ///< get vertify code to regiter {phone}
extern NSString *const kSoapMethodUserRegest;       ///< regest new user {phone, verification_code, password}
extern NSString *const kSoapMethodGetOrderContent;  ///< Get Order Content {order_id}
extern NSString *const kSoapMethodOrderCustDetail;  ///< Order Cust Detail {order_id}
extern NSString *const kSoapMethodOrderCustIdent;   ///< Order CustIdent {order_id}
extern NSString *const kSoapMethodGetOrderRecord;   ///< Get Order Record
extern NSString *const kSoapMethodUserAccount;      ///< user account info {nil}    @cookie yes
extern NSString *const kSoapMethodOrderOpera;       ///< Order Operaation
extern NSString *const kSoapMethodGetMyHP;          ///< mine hepan  @{nil}  @cookie yes
extern NSString *const kSoapMethodBankCardManage;   ///< back card manage @{nil} @cookie yes
extern NSString *const kSoapMethodProvince;          ///< get provice @{nil}  @cookie yes
extern NSString *const kSoapMethodBank;             ///< get bank list @{nil} @cookie yes
extern NSString *const kSoapMethodCity;             ///< get city list @{province_code} @cookie yes
extern NSString *const kSoapMethodBankBranch;       ///< 分行地址 @{bank_code, city_code}   @cookie yes
extern NSString *const kSoapMethodBindBankCard;     ///< bind bank card @{account, bank, province, city, subbranch, idcard, verification_code}  @cookie yes
extern NSString *const kSoapMethodBankCardModify;   ///< modify bank card @{account, bank, province, city, subbranch, idcard, verification_code}  @cookie yes
extern NSString *const kSoapMethodCashout;         ///< cashout, apply for the moneny @{money, pay_pwd, verification_code} @cookie yes
extern NSString *const kSoapMethodGetAutoBid;      ///< Get AutoBid @{nil} @cookie
extern NSString *const kSoapMethodSetAutoBid;      ///< Set AutoBid @{nil} @cookie
extern NSString *const kSoapMethodCloseOrOpenAutoBid; ///< Close Or Open AutoBid @{nil} @cookie
extern NSString *const kSoapMethodReturnInvestment;///< 回款中投资   @{currPageNum, pageSize} @cookie yes
extern NSString *const kSoapMethodSettlementInvestment;         ///< 已结清投资      @{currPageNum, pageSize}  @cookie yes
extern NSString *const kSoapMethodBiddingInvestment;///< 招标中投资  @{currPageNum, pageSize} @cookie yes
extern NSString *const kSoapMethodGetMyhepan;       ///< 我的合盘   @{nil}  @cookie yes
extern NSString *const kSoapMethodModifiedPwd;      ///< 修改密码（登录） @{...} @cookie yes
extern NSString *const kSoapMethodGetTradeNo;       ///< 获取充值订单号    @{recharge} @cookie yes
extern NSString *const kSoapMethodGetTradeNoYLM;    ///< 获取易联支付订单号 @{recharge bankeAccount} @cooking yes
extern NSString *const KSoapMethodDailyOrderV2;     ///< 每日新表  第二个版本  @{nil} @cookie no
extern NSString *const KSoapMethodRegisterV2;       ///< 注册第二个版本 @{phone,verification_code,password,recommendMobile}
extern NSString *const kSoapMethodUserRegistNewM;   ///< 注册第三个版本 添加渠道号 200 @{phone,verification_code,password,recommendMobile,source}
extern NSString *const kSoapMethodAccountInfoV2;    ///< 获取用户信息 @{nil} @cookie yes
extern NSString *const kSoapMethodNameArgument;     ///< 实名认证   @{real_name, idcard} @cookie yes
extern NSString *const kSoapMethodModifiedMobile;   ///< 修改手机号码 @{verification_code, new_mobile}    @cookie yes
extern NSString *const kSoapMethodGetAnnouncementList; ///<获取公告清单 @{currPageNum, pageSize}
extern NSString *const kSoapMethodGetAnnouncementListIOS; ///< 获取公告清单 @{currPageNum, pageSize}
extern NSString *const kSoapMethodGetAnnouncementDetail; ///< 获取公告详情 @{id}
extern NSString *const kSoapMethodGetMessage;            ///< 消息清单
extern NSString *const kSoapMethodModifyPwdV2;        ///< 修改登陆密码 @{verification_code, new_password}  @cookie yes
extern NSString *const kSoapMethodModifyTradePwdV2;   ///< 修改交易密码 @{verification_code, new_password}  @cookie yes
extern NSString *const kSoapMethodInvestmentSummeryV2;///< 我的投资信息汇总 @{nil} @cookie  yes
extern NSString *const kSoapMethodMyInvestmentHJV2;     ///< 回款中或已结清投资  @{currPageNum, pageSize, searchType} @cookie yes
extern NSString *const kSoapMethodMyInvestmentZBV2;     ///< 招标中投资  @{currPageNum, pageSize} @cookie yes
extern NSString *const kSoapMethodWithdrawRecordV2;     ///< 资金记录 v2 @{currPageNum,pageSize,start,end,state} @cookie yes
extern NSString *const kSoapMethodBenefitListV2;        ///< 收益记录 v2 @{currPageNum,pageSize,start,end,state} @cookie yes
extern NSString *const kSoapMethodRechargeRecordV2;     ///< 充值记录 v2 @{currPageNum,pageSize,start,end,state} @cookie yes
extern NSString *const kSoapMethodWithdrawRecordNewV2;  ///< 提现记录 v2 @{currPageNum,pageSize,start,end,state} @cookie yes
extern NSString *const kSoapMethodBankCardAddMV2;       ///< 添加银行卡 v2 @{bank_code,Province_code,city_code, subbranch,account,verification_code} @cookie yes
extern NSString *const kSoapMethodBankCardModifyMV2;    ///< 银行卡修改 v2 @{custbankcard_id,bank_code,province_code,city_code,subbranch,account,verification_code}  @cookie yes
extern NSString *const kSoapMethodBankCardQueryMV2;     ///< 银行卡查询 v2 @{custbankcard_id} @cookie yes
extern NSString *const kSoapMethodBankCardDeleteMV2;    ///< 银行卡删除 v2 @{custbankcard_id} @cookie yes
extern NSString *const kSoapMethodBankCardListMV2;      ///< 银行卡列表  v2 @{nil}  @cookie yes
extern NSString *const kSoapMethodSendEmailVerifyMV2;     ///< 邮箱认证   v2 @{email} @cookie yes
extern NSString *const kSoapMethodWhetherCertification;     ///< 是否已经实名认证   @{nil}  @cookie yes
extern NSString *const kSoapMethodBankCardllListM;      ///< 连连支付 银行卡列表 @{nil}  @cookie yes
extern NSString *const kSoapMethodCashoutM;             ///< 提现申请 @{money, pay_pwd, verification_code, card_no}   @cookie yes

extern NSString *const kSoapMethodSetAutoBidNewM;       ///< 新 自动投标设置
extern NSString *const kSoapMethodGetAutoBidNewM;       ///< 新 获取自动投标详情
extern NSString *const kSoapMethodGetAutoBidNewNM;      ///< 新2 获取自动投标详情
extern NSString *const kSoapMethodSetAutoBidNewNM;      ///< 新2 自动投标设置
extern NSString *const kSoapMethodResetAutoBidNM;       ///< 新2 重置自动投标

extern NSString *const kSoapMethodMyAutoBidListM;       ///< 自动投标队列 @{nil}   @cookie  yes
extern NSString *const kSoapMethodCancelAutoBidQueue;   ///< 取消自动投标队列   @{queue_id}     @cookie yes
extern NSString *const kSoapMethodResetAutoBidM;        ///< 新的自动投标设置
extern NSString *const kSoapMethodGetBannerM;           ///< 获取动态的banner    @{nil}  @cookie no
extern NSString *const ksoapMethodIOSSysUpdateM;        ///< 强制更新 @{nil}

extern NSString *const kSoapMethodGetOrderList;;         ///< 标的列表
extern NSString *const kSoapMethodGetOrderListM;         ///< 新的 标的列表



extern NSString *const kSoapMethodShareFriendsM;         ///< 获取分享信息    @{nil} @cookie yes
extern NSString *const kSoapMethodsharefriendsMineM;     ///< 获取我的分享信息 @{nil} @cookie yes
extern NSString *const kSoapMethodShareFriendsRecommendListM ;  ///< 获取推荐奖励列表   @{nil} @cookie yes
extern NSString *const kSoapMethodShareFriendsProductM;  ///< 获取好友推荐奖励  @{currPageNum(当前页[从1开始]),pageSize(请求条数)} @cookie yes
extern NSString *const kSoapMethodShareFriendsMedialM;   ///< 自媒体奖励 @{currPageNum(当前页[从1开始]),pageSize(请求条数)} @cookie yes


extern NSString *const kSoapMethodBankCardListNewM;      ///< 获取银行卡列表 新接口
extern NSString *const kSoapMethodSameCardAmountM;       ///< 同卡进出 @{card_no} @cookie yes

extern NSString *const kSoapMethodGetProductDetailM;     ///< 定期通产品详情 @{id}
extern NSString *const kSoapMethodGetProductListM;       ///< 定期通列表 @{currPageNum,pageSize}
extern NSString *const kSoapMethodInvestProductM;        ///< 投资定期通 @{id(产品id),amount(投标金额),pay_pwd(支付密码)}
extern NSString *const kSoapMethodGetProductDetailProM;  ///< 定期通详情 @{id(产品id)}
extern NSString *const kSoapMethodGetProductApplyListM;  ///< 获取定期通加入列表(手机) @{currPageNum(当前页[从1开始]),pageSize(请求条数),id(产品id)}

extern NSString *const kSoapMethodGethqtIntroDuctionM;

extern NSString *const kSoapMethodGetInvestListM;        ///< 账户定期通列表 @{currPageNum(当前页[从1开始]),pageSize(请求条数)} @cookie yes
extern NSString *const kSoapMethodGetInvestListDetailM;  ///< 账户定期通详情列表  @{id} @cookie yes
extern NSString *const kSoapMethodGetProductReserveDetailM;     ///< 定期通预约详情  @{versionID(产品类型id)} @cookie NO
extern NSString *const kSoapMethodGetReserveListM;       ///< 获取预约定期通列表 @{currPageNum(当前页[从1开始]),pageSize(请求条数)} @cookie yes

extern NSString *const kSoapMethodGethqtInvestDetailM;
//活期通提前退出
extern NSString *const kSoapMethodGethqtwithdrawM;

extern NSString *const kSoapMethodGetHQTList; ///< 获取活期通列表(需登录) @{currPageNum(当前页[从1开始]),pageSize(请求条数)} @cookie yes

extern NSString *const kSoapMethodGetProductListLM;      ///< 获取定期通列表(需登录) @{currPageNum(当前页[从1开始]),pageSize(请求条数)} @cookie yes
extern NSString *const kSoapMethodGetProductListV2M;     ///< 获取定期通列表(未登录) @{currPageNum(当前页[从1开始]),pageSize(请求条数)} @cookie NO
extern NSString *const kSoapMethodAddBespokeM;           ///< 预约定期通 @{versionID(产品id),BespokeMoney(预约金额),payPwd(交易密码)} @cookie no

extern NSString *const kSoapMethodDailyOrderM;           ///< 每日新标 包含定期通 @{nil} @cookie yes
extern NSString *const kSoapMethodDailyProductM;         ///< 每日新标 只推荐定期通 @{nil} @cookie yes

extern NSString *const kSoapMethodGetbrowserDetailM;     ///< 投资详情 @{orderdetail_id(详情ID),type(类型，1为招标中，2为回收中 3，为已结清)} @cookie yes
extern NSString *const kSoapMethodGetReserveDetailM;     ///< 定期通预约详情 @{versionID(定期通种类ID)}

extern NSString *const kSoapMethodInvestListM;           ///< 资金记录 @{currPageNum(当前页[从1开始]),pageSize(请求条数),start(开始时间),end(截止时间),operation(操作),state(状态)}

extern NSString *const kSoapMethodCashFeeM;              ///< 提现手续费 @{money(提现金额)}  @cookie yes
extern NSString *const kSoapMethodGetMyInvestM;          ///< 我的投资  @{currPageNum(当前页[从1开始]),pageSize(请求条数)} @cookie yes
extern NSString *const kSoapMethodInvestRecordM;         ///< 交易记录  @{currPageNum(当前页[从1开始]),pageSize(请求条数),type(类型),time(时间)} @cookie yes
extern NSString *const kSoapMethodRedBagRecordM;         ///< 红包奖励  @{currPageNum(当前页[从1开始]),pageSize(请求条数),type(类别)} @cookie yes
extern NSString *const kSoapMethodBonusBellM;            ///< 抽奖次数  @{} @cookie yes

// response statu
extern NSString *const kSoapResponseStatu;          ///< doStatu
extern NSString *const kSoapResponseObject;         ///< doObject
extern NSString *const kSoapResponseMsg;            ///< doMsg
extern NSString *const kSoapResponseErrCode;         ///< errCode
//新增的接口
//我的奖励
extern NSString *const kSoapMethodMyBonusM;
//我的投资
extern NSString *const kSoapMethodGetMyInvestListM;
//交易记录
extern NSString *const kSoapMethodInvestRecordListM;
//待收统计
extern NSString *const kSoapMethodGetDueInAmountM;
//首页中利率、投资状态
extern NSString *const kSoapMethodGetFirstPageM;

//我的卡券列表
extern NSString *const kSoapMethodGetMyjxqListM;

//过滤过的加息卷列表
extern NSString *const kSoapMethodjxqListM;

//活期通逐月递增图片接口
extern NSString *const kSoapMethodGetHqtPictureM;

//获取支付类型
extern NSString *const kSoapMethodGetPayChannelM;

//获取我的红包
extern NSString *const kSoapMethodGetMyRedBagM;

//获取分享连接
extern NSString *const kSoapMethodGetShareMyRedBagM;

//我的加息卷
extern NSString *const kSoapMethodGetMyjxqM;

//分享成功的回调
extern NSString *const kSoapMethodGetShareMyRedBagSucessM;

//理财中心
extern NSString *const kSoapMethodGetFinancingCenterM;

//上传IDFA编码
extern NSString *const kSoapMethodSendIDFA;

//获取用户签到次数
extern NSString *const kSoapMethodUserSignSummary;

// 获取用户签到规则
extern NSString *const kSoapMethodUserSignRule;

//用户签到
extern NSString *const kSoapMethodUserSign;

//获取分享内容
extern NSString *const kSoapMethodUserSignShareURL;

//分享
extern NSString *const kSoapMethodUserSignShare;

//用户签到记录
extern NSString *const kSoapMethodUserSignLog;

//检测是否正在维护中
extern NSString *const kSoapMethodGetSysMaintainInfo;

//错误提示
extern NSString *const kErrorMsg;

//获取协议号和订单号
extern NSString *const KsoapMethodGetCard_OrderInfo;

//校验验证码
extern NSString *const kSoapMethodCheckVerifyCode_NoSubmit;

extern NSString *const KLeftViewControllerPush; ///< leftView点击跳转通知

//extern NSString *const LastUserDic;///< 最后一次登录存储的用户信息

extern NSString *const KSoapMethodUploadHeadImage; ///< 上传头像接口

extern NSString *const KSoapMethonGetUserOtherInfo; ///< 获取用户其他信息的接口

extern NSString *const KSoapMethonGetMessageList; ///< 获取系统消息

extern NSString *const KSoapMethonUpdateMessage; ///< 更新系统消息状态

extern NSString *const GestureViewAndApnsIsShow;///< 标示手势页是否在使用

extern NSString *const RemoteNotification;///< 收到推送消息的通知

extern NSString *const KSoapMethonSendGERedEnvelopes;  ///< 推荐好友发红包

extern NSString *const KSoapMethonGetCustReward;  ///< 获取推荐页面数据

extern NSString *const KSoapMethonGetSysConfig;  ///<获取推荐规则数据

extern NSString *const KSoapMethonUpdatetMessage;///<更新系统数据

extern NSString *const KSoapMethonGetCustRewardList;///<好友赚钱详情

extern NSString *const kSoapMethodShare_CustReward;///<好友分享红包

extern NSString *const KSoapMethonGetShareMyFootprint;///<获取足迹信息

extern NSString *const kSoapMethodGetLoadingImage;///< 获取登录图片

extern NSString *const kSoapMethodProc_GetPeas;///<获取豆子信息

extern NSString *const KsoapMethodGetShareMyFootprint;///<获取足迹分享

extern NSString *const KsoapMethodShareMyFootprintCallBack;///<我的足迹分享回调

extern NSString *const KsoapMethodGet_Feedback; ///获取反馈信息

extern NSString *const KsoapMethodGet_DQTDetailM;///<新定期通投资详情

extern NSString *const KsoapMethodAddFeedback;///<提交反馈信息

extern NSString *const KsoapMethodGet_Transaction_Type;///<获取code

extern NSString *const KsoapMethodGet_Transaction_Log; ///<获取交易信息

extern NSString *const KsoapMethodGet_Invest_List; ///<获取投资列表

extern NSString *const KsoapMethodGet_HQTDetailM;///<活期通投资详情

extern NSString *const KsoapMethodGet_OrderDetailM;///<活期通投资详情

extern NSString *const KsoapMethodHQTExitBankCardListNewM;///<活期通退出银行卡列表

extern NSString *const KsoapMethodCulcaInterestCashFee;///<提前退出手续费计算

extern NSString *const KsoapMethodAdvanceQuitApply;///<提前退出

extern NSString *const kSoapMethodBankCardListNewM_ReChange;

extern NSString *const KsoapMethodGetOrderRepayPut;///<房贷通回款明细

extern NSString *const KsoapMethonGetFDTTransferList;///<获取房贷通列表

extern NSString *const KsoapMethonGetFDTTransferDetail;///<房贷通详情

extern NSString *const KsoapMethonInvestTransferOrder;///<流转变现投资

extern NSString *const KsoapMethodGet_HouseInvestTransferList;///<承接

extern NSString *const KsoapMethodGet_HouseTransList;///<转让

extern NSString *const KsoapMethodGet_HouseTransInfo;///<转让详情

extern NSString *const KsoapMethodGet_HouseInvestTransferInfo;///<承接详情

extern NSString *const KsoapMethodChangeCash;///<房贷通变现操作

extern NSString *const KsoapMethodTransferApply;///<房贷通申请变现

extern NSString *const KsoapMethodGet_FDTTransferLog;///<单个流房贷通的承接记录

extern NSString *const KsoapMethodGetGoodSMain;///<积分商城

extern NSString *const KsoapMethodGetMyGoodList;///<我的礼品

extern NSString *const KsoapMethodGetMyAssetInfo;///<资产详情

extern NSString *const KsoapMethodGetHomeFirstOrder;///<新首页项目接口

extern NSString *const KsoapMethodGetPlatformData;///<平台数据接口

extern NSString *const KsoapMethodGetProductCenter;///<新项目列表界面

extern NSString *const KsoapMethodGetFindBannerList;///<发现banner

extern NSString *const KsoapMethodGetFindRedCount;///<发现-红点

extern NSString *const KsoapMethodEditCustNickName;///<修改昵称

extern NSString *const KsoapMethodGetHomeLastInvesrtInfo;///<首页底部模块

extern NSString *const KsoapMethodGetCustAccountTest;///<体验金

extern NSString *const KsoapMethodGetHPDRule;///<我的福利-规则

extern NSString *const KsoapMethodUserBindCard;///<绑定银行卡

extern NSString *const ACTION_BTNACTION;///<金币按钮操作信息

extern NSString *const KsoapMethodGetInvestIncome;///<服务器计算收益

extern NSString *const kWebOpenProductListNotification;///<webView打开对应项目列表通知

extern NSString *const KsoapMethodGetHomeTopInfo;///<首页头部信息

@interface HPDStatusCode : NSObject

@property (nonatomic, readonly, strong) NSDictionary *statusCode;

+ (id)getInstance;

- (id)init;

- (NSString *)messageWithCode:(NSInteger)code;
- (NSString *)messageWithKey:(id)key;
- (NSString *)messageWithDict:(NSDictionary *)dict;

@end
