//
//  PD_BillDetailViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillDetailViewController.h"
#import "SLOrdersDeteiledLabel.h"
#import "PD_BillDetailTaoCanCell.h"
#import "PD_BillDetailDanDianCell.h"
#import "PD_BillDetailOutLineInfoView.h"//线下支付
#import "PD_BillDetailUnCheckView.h"//待审核
#import "PD_BillDetailOnLineView.h"//线上支付
#import "PD_BillDetailComfirInfoView.h"//确认收货
#import "BillListModel.h"
@interface PD_BillDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *orderDetailTable;
//订单编号
@property (nonatomic, weak) UILabel *orderNoLabel;
//创建时间
@property (nonatomic, weak) UILabel *creatTimeLabel;
//付款时间
@property (nonatomic, weak) UILabel *payTimeLabel;
//发货时间
@property (nonatomic, weak) UILabel *sendTimeLabel;
//模型
@property (nonatomic, strong) BillListModel *billListM;
//套餐数组
@property (nonatomic, strong) NSMutableArray *taoCanArr;
//单点数组
@property (nonatomic, strong) NSMutableArray *danDiArr;
@end

@implementation PD_BillDetailViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CF6F6F6;
    [self creatTableView];
    [self loadOrderGetRequest];
}
- (void)setOrderStatu:(NSString *)orderStatu
{
    if (orderStatu) {
        _orderStatu = orderStatu;
        //订单状态，10:待付款，20:待发货，30:待确认，40：已完成
        if ([orderStatu isEqualToString:@"10"]) {
            self.navigationItemTitle  = @"待付款";
        } else if ([orderStatu isEqualToString:@"20"]) {
            self.navigationItemTitle  = @"待发货";
        } else if ([orderStatu isEqualToString:@"30"]) {
            self.navigationItemTitle  = @"待确认";
        } else if ([orderStatu isEqualToString:@"40"]) {
            self.navigationItemTitle  = @"订单完成";
        }
    }
}
#pragma mark ---- Table ----
- (void)creatTableView
{
    UITableView *orderDetailTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    orderDetailTable.showsVerticalScrollIndicator = NO;
    orderDetailTable.delegate = self;
    orderDetailTable.dataSource = self;
    [self.view addSubview:orderDetailTable];
    self.orderDetailTable = orderDetailTable;
    orderDetailTable.separatorStyle = NO;
    [orderDetailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
    }];
}

#pragma mark ---- TabHeadView ----
- (UIView *)creatTableHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(76))];
    headerView.backgroundColor = WhiteColor;
    AddressDOModel *addressM = [AddressDOModel mj_objectWithKeyValues:self.billListM.addressDO];
    
    //收件人姓名
    UILabel *receiverNameLabel = [UILabel getLabelWithFont:FB13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(29));
        make.top.offset(AD_HEIGHT(13));
        
        view.text = IF_NULL_TO_STRING(addressM.receiverName);
    }];
    
    //收件人手机号
    [UILabel getLabelWithFont:FB13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(receiverNameLabel.mas_right).offset(AD_HEIGHT(8));
        make.top.offset(AD_HEIGHT(14));
        
        view.text = [NSString numberSuitScanf:IF_NULL_TO_STRING(addressM.receiverMp)];
    }];
    
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
    [UILabel getLabelWithFont:F12 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(receiverAddressImageV.mas_right).offset(AD_HEIGHT(3));
        make.top.equalTo(receiverAddressImageV.mas_top);
        
        view.text = [NSString stringWithFormat:@"收货地址：%@%@%@",IF_NULL_TO_STRING(addressM.province),IF_NULL_TO_STRING(addressM.city),IF_NULL_TO_STRING(addressM.county)];
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
    
    
    return headerView;
}

#pragma mark ---- TabFooterView ----
- (UIView *)creatTableFooterView
{
    MJWeakSelf;
    PayDOModel *payDoModel = [PayDOModel mj_objectWithKeyValues:self.billListM.payDO];

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
    
    
    UIView *lineThree = [UIView getViewWithColor:CF6F6F6 superView:footerView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(postPriceLabel.mas_bottom);
    }];
    
    //合计
    SLOrdersDeteiledLabel *totalLabel = [[SLOrdersDeteiledLabel alloc] init];
    totalLabel.title = @"合计";
    totalLabel.titleStrColor = CF52542;
    totalLabel.textStr = [NSString stringWithFormat:@"￥%@",IF_NULL_TO_STRING(self.billListM.orderPrice)];
    [footerView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(lineThree.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(50)));
    }];
    
    
    UIView *otherInfoView = [UIView getViewWithColor:WhiteColor superView:footerView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.top.equalTo(totalLabel.mas_bottom).offset(AD_HEIGHT(5));
        make.left.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(95));
    }];
    
    //订单编号
    UILabel *orderNoLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:otherInfoView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(8));
        view.textAlignment = NSTextAlignmentLeft;
        view.text = [NSString stringWithFormat:@"订单编号：%@",IF_NULL_TO_STRING(self.billListM.orderUuid)];
    }];
    self.orderNoLabel = orderNoLabel;
    
    //右侧复制
    [UIButton getButtonWithImageName:@"" titleText:@"复制"  superView:otherInfoView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.equalTo(weakSelf.orderNoLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(60), AD_HEIGHT(20)));
        
        [btn setTitleColor:C000000 forState:normal];
        btn.titleLabel.font = F10;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn addTarget:self action:@selector(copyOrderNo) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    //创建时间
    UILabel *creatTimeLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:otherInfoView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.orderNoLabel.mas_bottom).offset(AD_HEIGHT(8));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = [NSString stringWithFormat:@"创建时间：%@",IF_NULL_TO_STRING(self.billListM.createtime)];
    }];
    self.creatTimeLabel = creatTimeLabel;
    
    //付款时间
    PayDOModel *payDoM = [PayDOModel mj_objectWithKeyValues:self.billListM.payDO];
    UILabel *payTimeLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:otherInfoView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.creatTimeLabel.mas_bottom).offset(AD_HEIGHT(8));
        view.textAlignment = NSTextAlignmentLeft;
        view.text = [NSString stringWithFormat:@"付款时间：%@",IF_NULL_TO_STRING(payDoM.createtime)];
    }];
    self.payTimeLabel = payTimeLabel;
    
    //发货时间
    UILabel *sendTimeLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:otherInfoView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.payTimeLabel.mas_bottom).offset(AD_HEIGHT(8));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = [NSString stringWithFormat:@"发货时间：%@",IF_NULL_TO_STRING(self.billListM.cosignTime)];
    }];
    self.sendTimeLabel = sendTimeLabel;
    
    //10:待付款，20:待发货，30:待确认，40：已完成
    if ([self.billListM.orderStatus isEqualToString:@"10"]) {
        //支付方式，0:微信，1:支付宝，2:线下转账
        if ([payDoModel.payType isEqualToString:@"2"]) {
            footerView.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(306)+AD_HEIGHT(282)+AD_HEIGHT(2));
            //线下转账
            PD_BillDetailOutLineInfoView *outLineInfoView = [[PD_BillDetailOutLineInfoView alloc]init];
            outLineInfoView.heJiMoneyStr = self.billListM.orderPrice;
            [footerView addSubview:outLineInfoView];
            [outLineInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(otherInfoView.mas_bottom).offset(AD_HEIGHT(2));
                make.left.offset(0);
                make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(282)));
            }];
        } else {
            footerView.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(306)+AD_HEIGHT(214)+AD_HEIGHT(2));
            //线上支付
            PD_BillDetailOnLineView *onLineView = [[PD_BillDetailOnLineView alloc]init];
            [footerView addSubview:onLineView];
            onLineView.heJiMoneyStr = self.billListM.orderPrice;
            [onLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(otherInfoView.mas_bottom).offset(AD_HEIGHT(2));
                make.left.offset(0);
                make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(214)));
            }];

        }
    } else if ([self.billListM.orderStatus isEqualToString:@"20"] || [self.billListM.orderStatus isEqualToString:@"30"] ) {
        //确认收货
        footerView.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(306)+AD_HEIGHT(53)+AD_HEIGHT(5));
        PD_BillDetailComfirInfoView *comfirInfoView = [[PD_BillDetailComfirInfoView alloc]init];
        [footerView addSubview:comfirInfoView];
        [comfirInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(otherInfoView.mas_bottom).offset(AD_HEIGHT(5));
            make.left.offset(0);
            make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(53)));
        }];
    } else if ([self.billListM.orderStatus isEqualToString:@"40"]) {
        footerView.frame = CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(306)+AD_HEIGHT(5));

    }
    
    
    //待审核
//    PD_BillDetailUnCheckView *unCheckView = [[PD_BillDetailUnCheckView alloc]init];
//    [footerView addSubview:unCheckView];
//    [unCheckView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(otherInfoView.mas_bottom).offset(AD_HEIGHT(2));
//        make.left.offset(0);
//        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(196)));
//    }];
    
    
    
    return footerView;
}

#pragma mark -- tableView代理数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.danDiArr.count >0 && self.taoCanArr.count >0) {
        return 2;
    } else {
        return 1;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.danDiArr.count >0 && self.taoCanArr.count >0) {
        return section==0?self.taoCanArr.count:self.danDiArr.count;
    } else if (self.danDiArr.count ==0 && self.taoCanArr.count >0) {
        return self.taoCanArr.count;
    } else if (self.danDiArr.count >0 && self.taoCanArr.count ==0) {
        return self.danDiArr.count;
    } else {
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.danDiArr.count >0 && self.taoCanArr.count >0) {
        if (indexPath.section == 0) {
            PD_BillDetailTaoCanCell *cell = [PD_BillDetailTaoCanCell cellWithTableView:tableView];
            cell.detailDoM = self.taoCanArr[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            PD_BillDetailDanDianCell *cell = [PD_BillDetailDanDianCell cellWithTableView:tableView];
            cell.detailDoM = self.danDiArr[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (self.danDiArr.count ==0 && self.taoCanArr.count >0) {
        PD_BillDetailTaoCanCell *cell = [PD_BillDetailTaoCanCell cellWithTableView:tableView];
        cell.detailDoM = self.taoCanArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (self.danDiArr.count >0 && self.taoCanArr.count ==0) {
        PD_BillDetailDanDianCell *cell = [PD_BillDetailDanDianCell cellWithTableView:tableView];
        cell.detailDoM = self.danDiArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailDOModel *taoCanDetaiM;
    ItemObjModel *taoCanItemObjM;
    if (self.taoCanArr.count >0 ) {
        taoCanDetaiM = self.taoCanArr[indexPath.row];
        taoCanItemObjM = [ItemObjModel mj_objectWithKeyValues:taoCanDetaiM.itemObj];
    }
    
    DetailDOModel *danDianDetaiM;
    ItemObjModel *danDianItemObjM;
    if (self.danDiArr.count >0) {
        danDianDetaiM = self.danDiArr[indexPath.row];
        danDianItemObjM = [ItemObjModel mj_objectWithKeyValues:danDianDetaiM.itemObj];
    }
    
    if (self.danDiArr.count >0 && self.taoCanArr.count >0) {
        return indexPath.section==0?(AD_HEIGHT(30)+AD_HEIGHT(46)+taoCanItemObjM.packageChargeItemDOList.count*AD_HEIGHT(60)+AD_HEIGHT(5)):(AD_HEIGHT(32)+AD_HEIGHT(60)*danDianItemObjM.packageChargeItemDOList.count+AD_HEIGHT(5));
    } else if (self.danDiArr.count ==0 && self.taoCanArr.count >0) {
        return AD_HEIGHT(30)+AD_HEIGHT(46)+taoCanItemObjM.packageChargeItemDOList.count*AD_HEIGHT(60)+AD_HEIGHT(5);
    } else if (self.danDiArr.count >0 && self.taoCanArr.count ==0) {
        return AD_HEIGHT(32)+AD_HEIGHT(60)*danDianItemObjM.packageChargeItemDOList.count+AD_HEIGHT(5);
    } else {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.danDiArr.count >0 && self.taoCanArr.count >0) {
        return section == 0?[self creatHeaderWithText:@"套餐"]:[self creatHeaderWithText:@"单点"];
    } else if (self.danDiArr.count ==0 && self.taoCanArr.count >0) {
        return [self creatHeaderWithText:@"套餐"];
    } else if (self.danDiArr.count >0 && self.taoCanArr.count ==0) {
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
#pragma mark ---- 按钮点击 ----

//复制订单标号
- (void)copyOrderNo
{
    HUD_SUCCESS(@"复制成功");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"203498230482039482";
}

#pragma mark ---- 接口 ----
-(void)loadOrderGetRequest {
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"%@%@",@"api/trans/order/get/",self.myID] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {

                self.billListM = [BillListModel mj_objectWithKeyValues:result[@"data"]];
                self.orderDetailTable.tableHeaderView = [self creatTableHeaderView];
                self.orderDetailTable.tableFooterView = [self creatTableFooterView];
                [self creatCellNewArr];
            }
        }
        NSLog(@"result ------- %@", result);
    }];
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
    
    [self.orderDetailTable reloadData];
}
@end




















