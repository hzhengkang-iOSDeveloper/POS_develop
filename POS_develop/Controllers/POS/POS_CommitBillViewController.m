//
//  POS_CommitBillViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/12.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POS_CommitBillViewController.h"
#import "SLOrdersDeteiledLabel.h"
#import "PD_BillDetailTaoCanCell.h"
#import "PD_BillDetailDanDianCell.h"
#import "POS_CommfirBillOutLinePayView.h"//线下支付
#import "POS_CommfirBillOnLinePayView.h"//线上支付
#import "MyAddressViewController.h"//我的地址
#import "BillListModel.h"
#import "MyAddressViewModel.h"
#import "BuySuccessViewController.h"
@interface POS_CommitBillViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *orderDetailTable;
//模型
@property (nonatomic, strong) BillListModel *billListM;
//套餐数组
@property (nonatomic, strong) NSMutableArray *taoCanArr;
//单点数据源
@property (nonatomic, strong) NSMutableArray *productArr;
//单点数组
@property (nonatomic, strong) NSMutableArray *danDiArr;
//默认地址标志
@property (nonatomic, weak) UILabel *moRenAddressLabel;
@end

@implementation POS_CommitBillViewController
- (NSMutableArray *)taoCanArr
{
    if (!_taoCanArr) {
        _taoCanArr = [NSMutableArray array];
    }
    return _taoCanArr;
}
- (NSMutableArray *)danDiArr
{
    if (!_danDiArr) {
        _danDiArr = [NSMutableArray array];
    }
    return _danDiArr;
}
- (NSMutableArray *)productArr
{
    if (!_productArr) {
        _productArr = [NSMutableArray array];
    }
    return _productArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"确认订单";
    self.view.backgroundColor = CF6F6F6;
    [self creatTableView];
    [self loadOrderGetRequest];
}

#pragma mark ---- Table ----
- (void)creatTableView
{
    UITableView *orderDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-navH) style:UITableViewStyleGrouped];
    orderDetailTable.showsVerticalScrollIndicator = NO;
    orderDetailTable.delegate = self;
    orderDetailTable.dataSource = self;
    [self.view addSubview:orderDetailTable];
    self.orderDetailTable = orderDetailTable;
    orderDetailTable.separatorStyle = NO;
//    orderDetailTable.tableHeaderView = [self creatTableHeaderView];
//    orderDetailTable.tableFooterView = [self creatTableFooterView];
}
#pragma mark ---- TabHeadView ----
- (UIView *)creatTableHeaderViewWith:(AddressDOModel *)addressM
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(80))];
    headerView.backgroundColor = WhiteColor;
    headerView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *headerGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAddressBtn)];
    [headerView addGestureRecognizer:headerGest];
    
    if (addressM == nil || !addressM) {
        [UILabel getLabelWithFont:F15 textColor:CF70F0F superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
            make.left.offset(AD_HEIGHT(15));
            make.centerY.offset(0);
            
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"请选择收货地址";
        }];
        
        
        
    } else {
  
    
    //收件人姓名
    UILabel *receiverNameLabel = [UILabel getLabelWithFont:FB13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(29));
        make.top.offset(AD_HEIGHT(13));
        
        view.text = IF_NULL_TO_STRING(addressM.receiverName);
    }];
    
    //收件人手机号
    UILabel *receiverPhoneLabel = [UILabel getLabelWithFont:FB13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(receiverNameLabel.mas_right).offset(AD_HEIGHT(8));
        make.top.offset(AD_HEIGHT(14));
        
        view.text = [NSString numberSuitScanf:IF_NULL_TO_STRING(addressM.receiverMp)];
    }];
    
    //默认地址标志
    UILabel *moRenAddressLabel  = [UILabel getLabelWithFont:F9 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(receiverPhoneLabel.mas_right).offset(AD_HEIGHT(25));
        make.centerY.equalTo(receiverPhoneLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(24), AD_HEIGHT(12)));
        
        view.text = @"默认";
        view.textAlignment = NSTextAlignmentCenter;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view.backgroundColor = RGB(238, 238, 238);
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = C000000.CGColor;
    }];
    self.moRenAddressLabel = moRenAddressLabel;
    if ([addressM.deleteflag isEqualToString:@"0"]) {
        moRenAddressLabel.hidden = NO;
    } else {
        moRenAddressLabel.hidden = YES;
    }
    

    
    //收货地址图片
    UIImageView *receiverAddressImageV = [UIImageView new];
    receiverAddressImageV.contentMode = UIViewContentModeScaleAspectFit;
    receiverAddressImageV.image = ImageNamed(@"地图");
    [headerView addSubview:receiverAddressImageV];
    [receiverAddressImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(receiverNameLabel.mas_bottom).offset(AD_HEIGHT(8));
        make.left.offset(AD_HEIGHT(16));
    }];
    
    
    //收货地址
    UILabel *receiverAddressLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(receiverAddressImageV.mas_right).offset(AD_HEIGHT(3));
        make.top.equalTo(receiverAddressImageV.mas_top);
        
        view.text = [NSString stringWithFormat:@"收货地址：%@%@%@%@",IF_NULL_TO_STRING(addressM.province),IF_NULL_TO_STRING(addressM.city),IF_NULL_TO_STRING(addressM.county),IF_NULL_TO_STRING(addressM.receiverAddr)];
    }];
    
    //地址分割
    UIImageView *receiverBottomImageV = [UIImageView new];
    receiverBottomImageV.contentMode = UIViewContentModeScaleAspectFit;
    receiverBottomImageV.image = ImageNamed(@"addressLine");
    [headerView addSubview:receiverBottomImageV];
    [receiverBottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(15)));
    }];
    
    }
    
    //右侧箭头
    UIImageView *rightImageV = [[UIImageView alloc]init];
    rightImageV.contentMode = UIViewContentModeScaleAspectFit;
    rightImageV.image = ImageNamed(@"图层2拷贝2");
    [headerView addSubview:rightImageV];
    [rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(16));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(8), AD_HEIGHT(16)));
    }];
    return headerView;
}

#pragma mark ---- TabFooterView ----
- (UIView *)creatTableFooterView
{
//    MJWeakSelf;
    
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = CF6F6F6;
    
    //商品总价
    SLOrdersDeteiledLabel *goodTotalPriceLabel = [[SLOrdersDeteiledLabel alloc] init];
    goodTotalPriceLabel.title = @"商品总价";
    goodTotalPriceLabel.textStr = [NSString stringWithFormat:@"￥%@",IF_NULL_TO_STRING(self.billListM.displayPrice)];
    [footerView addSubview:goodTotalPriceLabel];
    [goodTotalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(50)));
    }];
    
    UIView *lineOne = [UIView getViewWithColor:CF6F6F6 superView:footerView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(goodTotalPriceLabel.mas_bottom);
    }];
    
    //优惠金额
    SLOrdersDeteiledLabel *discountPriceLabel = [[SLOrdersDeteiledLabel alloc] init];
    discountPriceLabel.title = @"优惠金额";
    if ([self.billListM.discountPrice integerValue] == 0) {
        discountPriceLabel.textStr = @"0";
    } else {
        
    }
    discountPriceLabel.textStr = [NSString stringWithFormat:@"-￥%@",IF_NULL_TO_STRING(self.billListM.discountPrice)];
    [footerView addSubview:discountPriceLabel];
    [discountPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(lineOne.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(50)));
    }];
    
    UIView *lineTwo = [UIView getViewWithColor:CF6F6F6 superView:footerView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(discountPriceLabel.mas_bottom);
    }];
    
    //邮费
    SLOrdersDeteiledLabel *postPriceLabel = [[SLOrdersDeteiledLabel alloc] init];
    postPriceLabel.title = @"邮费";
    postPriceLabel.textStr = [NSString stringWithFormat:@"￥%@",IF_NULL_TO_STRING(self.billListM.deliveryPrice)];
    [footerView addSubview:postPriceLabel];
    [postPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(lineTwo.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(50)));
    }];
        
    //0.微信 1支付宝  2线下支付
    //支付方式，0:微信，1:支付宝，2:线下转账
    NSString *astring01 = defaultObject(IF_NULL_TO_STRING(self.billListM.orderPrice), @"0");
    NSString *astring02 = @"1000";
    NSNumber * nums01 = @([astring01 integerValue]);
    NSNumber * nums02 = @([astring02 integerValue]);
    NSComparisonResult r = [nums01 compare:nums02];
    if (r == NSOrderedAscending) {
        footerView.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(153)+AD_HEIGHT(205)+AD_HEIGHT(5));
        //线上支付
        POS_CommfirBillOnLinePayView *onLineView = [[POS_CommfirBillOnLinePayView alloc]init];
        onLineView.totalStr = [NSString stringWithFormat:@"￥%@",IF_NULL_TO_STRING(self.billListM.displayPrice)];
        [footerView addSubview:onLineView];
        MJWeakSelf;
        onLineView.payHandler = ^(NSUInteger payType) {
            [weakSelf payRequest:payType];
        };
        [onLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(postPriceLabel.mas_bottom).offset(AD_HEIGHT(5));
            make.left.offset(0);
            make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(205)));
        }];
    }else if(r == NSOrderedDescending || r == NSOrderedSame) {
        footerView.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(153)+AD_HEIGHT(160)+AD_HEIGHT(5));
        //线下转账
        POS_CommfirBillOutLinePayView *outLineInfoView = [[POS_CommfirBillOutLinePayView alloc]init];
        outLineInfoView.moneyCount = [NSString stringWithFormat:@"￥%@",IF_NULL_TO_STRING(self.billListM.displayPrice)];
        [footerView addSubview:outLineInfoView];
        [outLineInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(postPriceLabel.mas_bottom).offset(AD_HEIGHT(5));
            make.left.offset(0);
            make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(160)));
        }];
        
    }
    
    
    
    
    return footerView;
}

#pragma mark ---- 进入地址详情 ----
- (void)clickAddressBtn
{
    MyAddressViewController *vc = [[MyAddressViewController alloc]init];
    vc.isSelecteAddress = YES;
    vc.hidesBottomBarWhenPushed = YES;
    vc.selectAddressHandler = ^(MyAddressViewModel *addressM) {
        AddressDOModel *addressDoM = [[AddressDOModel alloc]init];
        addressDoM.receiverName = addressM.receiverName;
        addressDoM.receiverMp = addressM.receiverMp;
        addressDoM.deleteflag =addressM.defaultFlag;
        addressDoM.province = addressM.province;
        addressDoM.city = addressM.city;
        addressDoM.county = addressM.county;
        addressDoM.receiverAddr = addressM.receiverAddr;
        self.orderDetailTable.tableHeaderView = [self creatTableHeaderViewWith:addressDoM];

    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- tableView代理数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.productArr.count >0 && self.taoCanArr.count >0) {
        return 2;
    } else {
        return 1;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.productArr.count >0 && self.taoCanArr.count >0) {
        return section==0?self.taoCanArr.count:self.productArr.count;
    } else if (self.productArr.count ==0 && self.taoCanArr.count >0) {
        return self.taoCanArr.count;
    } else if (self.productArr.count >0 && self.taoCanArr.count ==0) {
        return self.productArr.count;
    } else {
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.productArr.count >0 && self.taoCanArr.count >0) {
        if (indexPath.section == 0) {
            PD_BillDetailTaoCanCell *cell = [PD_BillDetailTaoCanCell cellWithTableView:tableView];
            cell.detailDoM = self.taoCanArr[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            PD_BillDetailDanDianCell *cell = [PD_BillDetailDanDianCell cellWithTableView:tableView];
            cell.productArr = [NSMutableArray arrayWithArray:self.productArr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (self.productArr.count ==0 && self.taoCanArr.count >0) {
        PD_BillDetailTaoCanCell *cell = [PD_BillDetailTaoCanCell cellWithTableView:tableView];
        cell.detailDoM = self.taoCanArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (self.productArr.count >0 && self.taoCanArr.count ==0) {
        PD_BillDetailDanDianCell *cell = [PD_BillDetailDanDianCell cellWithTableView:tableView];
        cell.productArr = [NSMutableArray arrayWithArray:self.productArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailDOModel *taoCanDetaiM;
    ItemObjModel *taoCanItemObjM;
    if (self.taoCanArr.count >indexPath.row ) {
        taoCanDetaiM = self.taoCanArr[indexPath.row];
        taoCanItemObjM = [ItemObjModel mj_objectWithKeyValues:taoCanDetaiM.itemObj];
    }
    
    NSArray *productTmpArr = [NSArray array];
    if (self.productArr.count >indexPath.row) {
        productTmpArr = self.productArr[indexPath.row];
    }
    
    if (self.productArr.count >0 && self.taoCanArr.count >0) {
        return indexPath.section==0?(AD_HEIGHT(30)+AD_HEIGHT(46)+taoCanItemObjM.packageChargeItemDOList.count*AD_HEIGHT(60)+AD_HEIGHT(5)):(AD_HEIGHT(32)+AD_HEIGHT(60)*productTmpArr.count+AD_HEIGHT(5));
    } else if (self.productArr.count ==0 && self.taoCanArr.count >0) {
        return AD_HEIGHT(30)+AD_HEIGHT(46)+taoCanItemObjM.packageChargeItemDOList.count*AD_HEIGHT(60)+AD_HEIGHT(5);
    } else if (self.productArr.count >0 && self.taoCanArr.count ==0) {
        return AD_HEIGHT(32)+AD_HEIGHT(60)*productTmpArr.count+AD_HEIGHT(5);
    } else {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.productArr.count >0 && self.taoCanArr.count >0) {
        return section == 0?[self creatHeaderWithText:@"套餐"]:[self creatHeaderWithText:@"单点"];
    } else if (self.productArr.count ==0 && self.taoCanArr.count >0) {
        return [self creatHeaderWithText:@"套餐"];
    } else if (self.productArr.count >0 && self.taoCanArr.count ==0) {
        return [self creatHeaderWithText:@"单点"];
    } else {
        return [UIView new];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AD_HEIGHT(29);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return  [UIView new];
}

#pragma mark ---- header ----
- (UIView *)creatHeaderWithText:(NSString *)text
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = CF6F6F6;
    
    [UILabel getLabelWithFont:F13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        
        view.text = text;
    }];
    
    return headerView;
}

#pragma mark ---- 接口 ----
-(void)loadOrderGetRequest {
    HUD_SHOW;
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"%@%@",@"api/trans/order/get/",self.orderId] params:nil cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    
                    self.billListM = [BillListModel mj_objectWithKeyValues:result[@"data"]];
                    AddressDOModel *addressM = [AddressDOModel mj_objectWithKeyValues:self.billListM.addressDO];
                    self.orderDetailTable.tableHeaderView = [self creatTableHeaderViewWith:addressM];
                    self.orderDetailTable.tableFooterView = [self creatTableFooterView];
                    [self creatCellNewArr];
                }
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}


#pragma mark ---- 获取单点产品数据源 ----
- (void)getProductDataArr
{
    
    for (int i = 0; i < self.danDiArr.count; i ++) {
        
        DetailDOModel *detailM = self.danDiArr[i];
        ItemObjModel *productM1 = [ItemObjModel mj_objectWithKeyValues:detailM.itemObj];
        NSString *string = productM1.posBrandName;
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [tempArray addObject:detailM];
        
        for (int j = i+1; j < self.danDiArr.count; j ++) {
            
            DetailDOModel *detailM1 = self.danDiArr[i];
            ItemObjModel *productM2 = [ItemObjModel mj_objectWithKeyValues:detailM1.itemObj];
            NSString *jstring = productM2.posBrandName;
            
            if([string isEqualToString:jstring]){
                
                [tempArray addObject:detailM1];
                
                [self.danDiArr removeObjectAtIndex:j];
                j -= 1;
                
            }
            
        }
        
        [self.productArr addObject:tempArray];
        
    }
    
    
    
}

#pragma mark ---- 创建Cell数组 ----
- (void)creatCellNewArr
{
    NSArray *bilListArr = [NSArray arrayWithArray:self.billListM.detailDOList];
    [bilListArr enumerateObjectsUsingBlock:^(DetailDOModel  *_Nonnull detailM, NSUInteger idx, BOOL * _Nonnull stop) {
        //0:产品，1：套餐
        if ([detailM.itemType isEqualToString:@"0"]) {
            [self.danDiArr addObject:detailM];
        } else if ([detailM.itemType isEqualToString:@"1"]) {
            [self.taoCanArr addObject:detailM];
        }
    }];
    
    //获取产品数据源
    [self getProductDataArr];
    [self.orderDetailTable reloadData];
}

#pragma mark ---- 线上支付相关 ----
- (void)payRequest:(NSUInteger)payType
{
    AddressDOModel *addressM = [AddressDOModel mj_objectWithKeyValues:self.billListM.addressDO];
    if (addressM == nil || !addressM) {
        HUD_TIP(@"选择收货地址后才可支付！");
        return;
    }
    NSDictionary *bodyDic = @{@"payType":s_Integer(payType),
                              @"tbOrderId":IF_NULL_TO_STRING(self.orderId)
                              };
    if (payType == 0) {
        //微信
        HUD_NOBGSHOW;
        [[HPDConnect connect] PostNetRequestMethod:@"api/trans/orderPay/getPayUuid" params:bodyDic cookie:nil result:^(bool success, id result) {
            if (success) {
                if ([result[@"code"]integerValue] == 0) {
                    NSString *Member_IdStr  = result[@"code"];
                    int  Member_Id = [Member_IdStr intValue];
                NSDictionary *wxPayDict = @{
                                            @"isAppMode":@1,
                                            @"orderPayId":@(Member_Id)
                                            };
                [self creatWxPay:wxPayDict];
                }else{
                    [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                        
                    }];
                }
            }
            NSLog(@"result ------- %@", result);
        }];
    }else if (payType == 1) {
        //支付宝
        HUD_NOBGSHOW;
        [[HPDConnect connect] PostNetRequestMethod:@"api/trans/orderPay/getPayUuid" params:bodyDic cookie:nil result:^(bool success, id result) {
            if (success) {
                if ([result[@"code"]integerValue] == 0) {
                    NSString *Member_IdStr  = result[@"code"];
                    int  Member_Id = [Member_IdStr intValue];
                NSDictionary *wxPayDict = @{
                                            @"isAppMode":@1,
                                            @"orderPayId":@(Member_Id)
                                            };
                [self creatAliPay:wxPayDict];
                }else{
                    [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                        
                    }];
                }
            }
            NSLog(@"result ------- %@", result);
        }];
    }
}


#pragma mark ---- 微信pay ----
- (void)creatWxPay:(NSDictionary *)param
{
    [[HPDConnect connect]GetNetRequestMethod:@"payment/weixi/pay" params:param cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *payResult = [NSDictionary dictionaryWithDictionary:result[@"data"]];
                    NSString *link = [NSString stringWithFormat:@"weixin://app/%@/pay/?nonceStr=%@&package=Sign%%3DWXPay&partnerId=%@&prepayId=%@&timeStamp=%@&sign=%@&signType=SHA1",payResult[@"appid"],payResult[@"nonce_str"],payResult[@"partnerid"],payResult[@"prepay_id"],payResult[@"timestamp"],payResult[@"sign"]];
                    [OpenShare WeixinPay:link Success:^(NSDictionary *message) {
                        //支付成功页面
                        HUD_SUCCESS(@"支付成功");
                        BuySuccessViewController *vc = [[BuySuccessViewController alloc]init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    } Fail:^(NSDictionary *message, NSError *error) {
                        HUD_ERROR(@"支付失败,请重新支付")
                        
                    }];
                }
                
            }
        }
    }];
}

#pragma mark ---- ali支付 ----
- (void)creatAliPay:(NSDictionary *)param
{
    //
    [[HPDConnect connect]KKGetNetRequestMethod:@"payment/alipay/pay" params:param cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                NSDictionary *linkDict = @{@"requestType":@"SafePay",@"fromAppUrlScheme":@"backApp",@"dataString":[NSString stringWithFormat:@"%@",result[@"data"]]};
                NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:linkDict options:NSJSONWritingPrettyPrinted error:nil];
                NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                CF_EXPORT
                CFStringRef CFURLCreateStringByAddingPercentEscapes(CFAllocatorRef allocator, CFStringRef originalString, CFStringRef charactersToLeaveUnescaped, CFStringRef legalURLCharactersToBeEscaped, CFStringEncoding encoding);
                NSString *linkURL = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
                                                                                                          (CFStringRef)jsonStr, nil,(CFStringRef)@"!*'();:@&=+$,/ %#[]", kCFStringEncodingUTF8));
                NSString *LINK = [NSString stringWithFormat:@"alipay://alipayclient/?%@",linkURL];
                
                [OpenShare AliPay:LINK Success:^(NSDictionary *message) {
                    //支付成功页面
                    HUD_SUCCESS(@"支付成功");
                    BuySuccessViewController *vc = [[BuySuccessViewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                } Fail:^(NSDictionary *message, NSError *error) {
                    HUD_ERROR(@"支付失败,请重新支付")
                }];
            }
            
        }
    }];
}

@end
