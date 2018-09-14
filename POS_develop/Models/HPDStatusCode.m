//
//  HPDStatusCode.m
//  HePanDai2_0
//
//  Created by HePanDai on 14-8-5.
//  Copyright (c) 2014年 HePanDai. All rights reserved.
//

#import "HPDStatusCode.h"

#pragma mark - soap method 

NSString *const kSoapMethodUserLogin = @"UserLogin";
NSString *const kSoapMethodUserLogout = @"SingOut";
NSString *const kSoapMethodDailyBids = @"DailyOrder";
NSString *const kSoapMethodBidDetail = @"GetOrderDetail";
NSString *const kSoapMethodBidDetailM = @"GetOrderDetailM";
NSString *const kSoapMethodhqtDetailM = @"hqtDetailM";
NSString *const kSoapMethodSendMessage = @"SendMessage";
NSString *const kSoapMethodRetrievePassword = @"RetrievePassword";
NSString *const kSoapMethodVertifyCode = @"VerificationFindPassword";
NSString *const kSoapMethodModifyPassword = @"SetPassword";
NSString *const kSoapMethodModifyPasswordM = @"SetPasswordM";
NSString *const kSoapMethodModifyTradePassword = @"SetPayPwd";
NSString *const kSoapMethodFeedback = @"Feedback";
NSString *const kSoapMethodGetCode = @"GetCode";
NSString *const kSoapMethodUserRegest = @"UserRegist";
NSString *const kSoapMethodGetOrderContent = @"GetOrderContent";
NSString *const kSoapMethodOrderCustDetail = @"OrderCustDetail";
NSString *const kSoapMethodOrderCustIdent = @"OrderCustIdent";
NSString *const kSoapMethodGetOrderRecord = @"GetOrderRecord";
NSString *const kSoapMethodUserAccount = @"UserAccount";
NSString *const kSoapMethodOrderOpera = @"OrderOpera";
NSString *const kSoapMethodGetMyHP = @"GetMyhepan";
NSString *const kSoapMethodBankCardManage = @"BankCardManage";
NSString *const kSoapMethodProvince = @"Province";
NSString *const kSoapMethodBank = @"ChooseBank";
NSString *const kSoapMethodCity = @"City";
NSString *const kSoapMethodBankBranch = @"BankBranch";
NSString *const kSoapMethodBindBankCard = @"IdcardVerification";
NSString *const kSoapMethodBankCardModify = @"BankCardModify";
NSString *const kSoapMethodCashout = @"Cashout";
NSString *const kSoapMethodGetAutoBid = @"GetAutoBid";
NSString *const kSoapMethodSetAutoBid = @"SetAutoBid";
NSString *const kSoapMethodCloseOrOpenAutoBid = @"CloseOrOpenAutoBid";
NSString *const kSoapMethodReturnInvestment = @"ReturnInvestment";
NSString *const kSoapMethodSettlementInvestment = @"SettlementInvestment";
NSString *const kSoapMethodBiddingInvestment = @"BiddingInvestment";
NSString *const kSoapMethodGetMyhepan = @"GetMyhepanM";
NSString *const kSoapMethodModifiedPwd = @"ModifiedPwd";
NSString *const kSoapMethodGetTradeNo = @"GetTradeNo";
NSString *const kSoapMethodGetTradeNoYLM = @"GetTradeNoYLM";
NSString *const KSoapMethodDailyOrderV2 = @"DailyOrderV2";
NSString *const KSoapMethodRegisterV2 = @"UserRegistM";
//NSString *const kSoapMethodUserRegistNewM = @"UserRegistNewM";
NSString *const kSoapMethodUserRegistNewM = @"Unify_UserRegistNewM";
NSString *const kSoapMethodAccountInfoV2 = @"GetUserAccountInfo";
NSString *const kSoapMethodNameArgument = @"NameArgument";
NSString *const kSoapMethodModifiedMobile = @"ModifiedMobile";
NSString *const kSoapMethodGetAnnouncementList = @"GetAnnouncementList";
NSString *const kSoapMethodGetAnnouncementListIOS = @"GetAnnouncementListIOS";
NSString *const kSoapMethodGetAnnouncementDetail = @"GetAnnouncementDetail";
NSString *const kSoapMethodGetMessage = @"GetMessage";
NSString *const kSoapMethodModifyPwdV2 = @"ModifiedPwdAddCode";
NSString *const kSoapMethodModifyTradePwdV2 = @"ModifiedPayPwd";
NSString *const kSoapMethodInvestmentSummeryV2 = @"MyInvestmentSummery";
NSString *const kSoapMethodMyInvestmentHJV2 = @"MyInvestmentHJ";
NSString *const kSoapMethodMyInvestmentZBV2 = @"MyInvestmentZB";
NSString *const kSoapMethodWithdrawRecordV2 = @"WithdrawRecordNew";
NSString *const kSoapMethodBenefitListV2 = @"BenefitList";
NSString *const kSoapMethodRechargeRecordV2 = @"RechargeRecordNew";
NSString *const kSoapMethodWithdrawRecordNewV2 = @"WithdrawRecordNew";
NSString *const kSoapMethodBankCardAddMV2 = @"BankCardAddM";
NSString *const kSoapMethodBankCardModifyMV2 = @"BankCardModifyM";
NSString *const kSoapMethodBankCardQueryMV2 = @"BankCardQueryM";
NSString *const kSoapMethodBankCardDeleteMV2 = @"BankCardDeleteM";//解绑银行卡
NSString *const kSoapMethodBankCardListMV2 = @"BankCardListM";
NSString *const kSoapMethodSendEmailVerifyMV2 = @"SendEmailVerifyM";
NSString *const kSoapMethodWhetherCertification = @"WhetherCertification";
NSString *const kSoapMethodBankCardllListM = @"BankCard_llListM";
NSString *const kSoapMethodGetPayChannelM = @"GetPayChannelM";
NSString *const kSoapMethodGetOrderList = @"GetOrderLis";
NSString *const kSoapMethodGetOrderListM = @"GetOrderListM";
NSString *const kSoapMethodCashoutM = @"CashoutM";

NSString *const kSoapMethodSetAutoBidNewM = @"SetAutoBidNewM";
NSString *const kSoapMethodGetAutoBidNewM = @"GetAutoBidNewM";
NSString *const kSoapMethodResetAutoBidM = @"ResetAutoBidM";

NSString *const kSoapMethodGetAutoBidNewNM = @"GetAutoBidNewNM";
NSString *const kSoapMethodSetAutoBidNewNM = @"SetAutoBidNewNM";
NSString *const kSoapMethodResetAutoBidNM = @"ResetAutoBidNM";


NSString *const kSoapMethodMyAutoBidListM = @"MyAutoBidListM";
NSString *const kSoapMethodCancelAutoBidQueue = @"CancelAutoBidQueue";
NSString *const kSoapMethodGetBannerM = @"GetHomeBannerList";
NSString *const ksoapMethodIOSSysUpdateM = @"IOSSysUpdateM";


// 定期通
NSString *const kSoapMethodGetProductDetailM = @"GetProductDetailM";
NSString *const kSoapMethodGetProductListM = @"GetProductListM";
NSString *const kSoapMethodInvestProductM = @"InvestProductM";
NSString *const kSoapMethodGetProductDetailProM = @"GetProductDetailProM";
NSString *const kSoapMethodGetProductApplyListM = @"GetProductApplyListM";

//活期通产品介绍
NSString *const kSoapMethodGethqtIntroDuctionM = @"hqtIntroDuctionM";

NSString *const kSoapMethodGetHQTList = @"hqtListM";
NSString *const kSoapMethodGetProductListLM = @"GetProductListLM";
NSString *const kSoapMethodGetProductListV2M = @"GetProductListV2M";
NSString *const kSoapMethodAddBespokeM = @"AddBespokeM";

NSString *const kSoapMethodGetProductReserveDetailM = @"GetProductReserveDetail1M";

NSString *const kSoapMethodGetReserveListM = @"GetReserveListM";

// 定期通我的投资
NSString *const kSoapMethodGetInvestListM = @"GetInvestListM";
NSString *const kSoapMethodGetInvestListDetailM = @"GetInvestListDetailM";

// 活期通我的投资
NSString *const kSoapMethodGethqtInvestDetailM = @"hqtInvestDetailM";
//活期通提前退出
NSString *const kSoapMethodGethqtwithdrawM = @"hqtwithdrawM";


// 分享好友 推荐奖励
NSString *const kSoapMethodShareFriendsM = @"ShareFriendsM";
NSString *const kSoapMethodsharefriendsMineM = @"ShareFriendsMineM";
NSString *const kSoapMethodShareFriendsRecommendListM = @"ShareFriendsRecommendListM";
NSString *const kSoapMethodShareFriendsProductM = @"ShareFriendsProductM";
NSString *const kSoapMethodShareFriendsMedialM = @"ShareFriendsMedialM";
NSString *const kSoapMethodShare_CustReward = @"Share_CustReward";

// 同卡进出
NSString *const kSoapMethodSameCardAmountM = @"SameCardAmountM";
NSString *const kSoapMethodBankCardListNewM = @"BankCardListNewM";//用户绑定银行卡列表
NSString *const kSoapMethodBankCardListNewM_ReChange = @"BankCardListNewM_ReChange";


NSString *const kSoapMethodDailyProductM = @"DailyProductM";

NSString *const kSoapMethodGetbrowserDetailM = @"GetbrowserDetailM";
NSString *const kSoapMethodGetReserveDetailM = @"GetReserveDetailM";

NSString *const kSoapMethodInvestListM = @"InvestListM";

NSString *const kSoapMethodCashFeeM = @"CashFeeM";

NSString *const kSoapMethodGetMyInvestM = @"GetMyInvestM";
NSString *const kSoapMethodInvestRecordM = @"InvestRecordM";
NSString *const kSoapMethodRedBagRecordM = @"RedBagRecordM";

NSString *const kSoapMethodBonusBellM = @"BonusBellNM";

// response
NSString *const kSoapResponseStatu = @"doStatu";
NSString *const kSoapResponseObject = @"doObject";
NSString *const kSoapResponseMsg = @"doMsg";
NSString *const kSoapResponseErrCode = @"errCode";
// 每日新标
NSString *const kSoapMethodDailyOrderM = @"DailyOrderM";

//新增的接口
//我的奖励
NSString *const kSoapMethodMyBonusM = @"MyBonusM";
//我的投资
NSString *const kSoapMethodGetMyInvestListM = @"GetMyInvestListM";
//交易记录
NSString *const kSoapMethodInvestRecordListM = @"InvestRecordListM";
//待收统计
NSString *const kSoapMethodGetDueInAmountM = @"GetDueInAmountM";

//首页中利率、投资状态
NSString *const kSoapMethodGetFirstPageM = @"GetFirstPageM";

//我的卡券列表
NSString *const kSoapMethodGetMyjxqListM = @"GetMyjxqListM";

//过滤过的加息卷列表
NSString *const kSoapMethodjxqListM = @"jxqListM";

//活期通逐月递增图片接口
NSString *const kSoapMethodGetHqtPictureM = @"GetHqtPictureM";

//我的红包
NSString *const kSoapMethodGetMyRedBagM = @"MyRedBagM";

//获取分享连接
NSString *const kSoapMethodGetShareMyRedBagM = @"ShareMyRedBagM";

//我的加息卷
NSString *const kSoapMethodGetMyjxqM = @"MyjxqM";

//分享成功的回调
NSString *const kSoapMethodGetShareMyRedBagSucessM = @"ShareMyRedBagSucessM";

//理财中心
NSString *const kSoapMethodGetFinancingCenterM = @"FinancingCenterM";

//上传IDFA广告码
NSString *const kSoapMethodSendIDFA = @"SendIDFA";

//获取用户签到信息
NSString *const kSoapMethodUserSignSummary = @"UserSignSummary";

//获取用户签到规则
NSString *const kSoapMethodUserSignRule = @"Get_App_Config";

//用户签到
NSString *const kSoapMethodUserSign = @"CustSign";

//获取分享内容
NSString *const kSoapMethodUserSignShareURL = @"UserSignShareURL";

//分享
NSString *const kSoapMethodUserSignShare = @"UserSignShare";

//获取用户签到记录
NSString *const kSoapMethodUserSignLog = @"UserSignLog";

//检测是否正在维护中
NSString *const kSoapMethodGetSysMaintainInfo = @"GetSysMaintainInfo";

//错误提示
NSString *const kErrorMsg = @"网络开小差了~";

//获取协议号和订单号
NSString *const KsoapMethodGetCard_OrderInfo = @"GetCard_OrderInfo";

//校验验证码
NSString *const kSoapMethodCheckVerifyCode_NoSubmit = @"CheckVerifyCode_NoSubmit";

NSString *const KLeftViewControllerPush = @"KLeftViewControllerPush"; ///< leftView点击跳转通知

//NSString *const LastUserDic = @"LastUserDic"; ///< 最后一次登录存储的用户信息

NSString *const KSoapMethodUploadHeadImage = @"UpCustImg"; ///< 上传头像接口

NSString *const KSoapMethonGetUserOtherInfo = @"GetUserOtherInfo"; ///< 获取用户其他信息的接口

NSString *const KSoapMethonGetMessageList = @"GetMessageList"; ///< 获取系统消息

NSString *const KSoapMethonUpdateMessage = @"UpdateMessage"; ///< 更新系统消息状态

NSString *const GestureViewAndApnsIsShow = @"GestureViewAndApnsIsShow";///< 标示手势页是否在使用

NSString *const RemoteNotification = @"RemoteNotification";///< 收到推送消息的通知

NSString *const KSoapMethonSendGERedEnvelopes = @"SendGERedEnvelopes";///<推荐好友发红包

NSString *const KSoapMethonGetCustReward = @"GetCustReward";  ///< 获取推荐页面数据

NSString *const KSoapMethonGetSysConfig = @"GetSysConfig";  ///<获取推荐规则数据

NSString *const KSoapMethonUpdatetMessage = @"UpdatetMessage";///<更新系统数据

NSString *const KSoapMethonGetCustRewardList = @"GetCustRewardList";///<好友赚钱详情

NSString *const KSoapMethonGetShareMyFootprint = @"GetShareMyFootprint";///<获取足迹信息

NSString *const kSoapMethodGetLoadingImage = @"GetLoadingImage";///<获取登录图片

NSString *const kSoapMethodProc_GetPeas = @"Proc_GetPeas";///<获取豆子信息

NSString *const KsoapMethodGetShareMyFootprint = @"GetShareMyFootprint";///<获取足迹分享

NSString *const KsoapMethodShareMyFootprintCallBack = @"ShareMyFootprintCallBack";///<我的足迹分享回调

NSString *const KsoapMethodGet_Feedback = @"Get_Feedback"; ///获取反馈信息

NSString *const KsoapMethodGet_DQTDetailM = @"Get_DQTDetailM";///<新定期通投资详情

NSString *const KsoapMethodAddFeedback = @"AddFeedback";///<提交反馈信息

NSString *const KsoapMethodGet_Transaction_Type = @"Get_Transaction_Type"; ///<获取code

NSString *const KsoapMethodGet_Transaction_Log = @"Get_Transaction_Log"; ///<获取交易信息

NSString *const KsoapMethodGet_Invest_List = @"Get_Invest_List"; ///<获取投资列表

NSString *const KsoapMethodGet_HQTDetailM = @"Get_HQTDetailM";///<活期通投资详情

NSString *const KsoapMethodGet_OrderDetailM = @"Get_OrderDetailM";///<活期通投资详情

NSString *const KsoapMethodHQTExitBankCardListNewM = @"HQTExitBankCardListNewM";///<活期通退出银行卡列表

NSString *const KsoapMethodCulcaInterestCashFee = @"CulcaInterestCashFee";///提前退出手续费计算

NSString *const KsoapMethodAdvanceQuitApply = @"AdvanceQuitApply";///<提前退出

NSString *const KsoapMethodGetOrderRepayPut = @"GetOrderRepayPut";///<房贷通回款明细

NSString *const KsoapMethonGetFDTTransferList = @"Get_FDTTransferList";///<获取房贷通列表

NSString *const KsoapMethonGetFDTTransferDetail = @"Get_FDTTransferDetail";///<房贷通详情

NSString *const KsoapMethonInvestTransferOrder = @"InvestTransferOrder";///<流转变现投资

NSString *const KsoapMethodGet_HouseInvestTransferList = @"Get_HouseInvestTransferList";///<承接

NSString *const KsoapMethodGet_HouseTransList = @"Get_HouseTransList";///<转让

NSString *const KsoapMethodGet_HouseTransInfo = @"Get_HouseTransInfo";///<转让详情

NSString *const KsoapMethodGet_HouseInvestTransferInfo = @"Get_HouseInvestTransferInfo";///<承接详情

NSString *const KsoapMethodChangeCash = @"ChangeCash";///<房贷通变现操作

NSString *const KsoapMethodTransferApply = @"TransferApply";///<房贷通申请变现

NSString *const KsoapMethodGet_FDTTransferLog = @"Get_FDTTransferLog";///<单个流房贷通的承接记录

NSString *const KsoapMethodGetGoodSMain = @"GetGoodSMain";///<积分商城

NSString *const KsoapMethodGetMyGoodList = @"GetMyGoodList";///<我的礼品

NSString *const KsoapMethodGetMyAssetInfo = @"GetMyAssetInfo";///<资产详情

NSString *const KsoapMethodGetHomeFirstOrder = @"GetHomeFirstOrder";///<新首页项目接口

NSString *const KsoapMethodGetPlatformData = @"GetPlatformData";///<平台数据接口

NSString *const KsoapMethodGetProductCenter = @"GetProductCenter";///<新项目列表界面

NSString *const KsoapMethodGetFindBannerList = @"GetFindBannerList";///<发现-banner

NSString *const KsoapMethodGetFindRedCount = @"GetFindRedCount";///<发现-红点

NSString *const KsoapMethodEditCustNickName = @"EditCustNickName";///<修改昵称

NSString *const KsoapMethodGetHomeLastInvesrtInfo = @"GetHomeLastInvesrtInfo";///<首页底部模块

NSString *const KsoapMethodGetCustAccountTest = @"GetCustAccountTest";///<体验金

NSString *const KsoapMethodGetHPDRule = @"Get_HPDRule";///<我的福利-规则

NSString *const KsoapMethodUserBindCard = @"UserBindCard";///<绑定银行卡

NSString *const ACTION_BTNACTION = @"btnaction";///<金币按钮操作信息

NSString *const KsoapMethodGetInvestIncome = @"GetInvestIncome";///<服务器计算收益

NSString *const kWebOpenProductListNotification = @"kWebOpenProductListNotification";///<webView打开对应项目列表通知

NSString *const KsoapMethodGetHomeTopInfo = @"GetHomeTopInfo";///<首页头部信息

@implementation HPDStatusCode

+ (id)getInstance
{
    static HPDStatusCode *statusCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        statusCode = [[HPDStatusCode alloc] init];
    });
    return statusCode;
}

- (id)init
{
    if (self = [super init]) {
        _statusCode = @{
                        @"200000" : @"服务器操作异常",
                        @"100001" : @"用户登录超时",
                        @"1000002" : @"用户名或密码错误",
                        @"1000003" : @"用户名不存在",
                        @"1000004" : @"支付密码错误",
                        @"1000005" : @"请先登录",
                        @"1000006" : @"原密码错误",
                        @"1000007" : @"新密码不一致",
                        @"1000008" : @"操作成功",
                        
                        @"1000" : @"不能投自己的标",
                        @"1001" : @"请先进行账户充值",
                        @"1002" : @"账户余额不足",
                        @"1012" : @"该标的状态已变",
                        @"1013" : @"投标失败",
                        @"1014" : @"投标成功",
                        
                        @"99999999" : @"无操作",
                        @"1000009" : @"账号绑定失败",
                        @"100010" : @"短信发送成功",
                        @"100011" : @"手机号码已存在",
                        @"100012" : @"手机验证码错误",
                        @"100013" : @"手机允许注册",
                        @"100014" : @"注册成功",
                        @"100015" : @"实名已认证",
                        @"100016" : @"实名未认证",
                        @"111113" : @"登录成功",
                        @"111124" : @"用户名或密码错误",
                        @"111125" : @"认证成功",
                        @"111126" : @"认证失败请确认身份证号码的正确",
                        @"111127" : @"认证失败该身份证号码已存在",
                        
                        @"111128" : @"身份证后六位与帐号绑定的不匹配",
                        @"111129" : @"实名认证错误",
                        @"111130" : @"银行卡绑定成功",
                        @"111131" : @"银行卡已绑定",
                        @"111132" : @"银行卡未绑定",
                        @"111133" : @"提现申请成功",
                        @"111134" : @"银行编号不能为空",
                        @"111135" : @"市编号不能为空",
                        @"111136" : @"投标时间未到",
                        @"111137" : @"请先绑定手机号",
                        @"111138" : @"短信发送失败",
                        @"111139" : @"身份证号不正确",
                        @"111140" : @"交易密码修改成功",
                        @"111141" : @"交易密码修改失败",
                        @"111142" : @"手机号码不存在",
                        @"111143" : @"密码重置成功",
                        @"111144" : @"手机验证码正确"
                        };
    }
    return self;
}

- (NSString *)messageWithCode:(NSInteger)code
{
    return [_statusCode valueForKey:[NSString stringWithFormat:@"%ld", (long)code]];
}
- (NSString *)messageWithKey:(id)key
{
    if (![[_statusCode allKeys] containsObject:key]) {
        return nil;
    }
    else if ([key isKindOfClass:[NSString class]]) {
        return [_statusCode valueForKey:key];
    }
    else if ([key isKindOfClass:[NSNumber class]]) {
        return [_statusCode valueForKey:[key stringValue]];
    }
    else {
#ifdef DEBUG
        NSLog(@"---> status key error with key => %@ and key.class => %@", key, [key class]);
#endif
    }
    return nil;
}

- (NSString *)messageWithDict:(NSDictionary *)dict
{
    NSString *message = [self messageWithKey:[dict valueForKey:kSoapResponseMsg]];
    if (message) {
        return message;
    }
    else {
        return [dict valueForKey:kSoapResponseMsg];
    }
    return nil;
}


@end
