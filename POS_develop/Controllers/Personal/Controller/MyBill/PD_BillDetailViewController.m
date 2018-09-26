//
//  PD_BillDetailViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillDetailViewController.h"
#import "SLOrdersDeteiledLabel.h"
#import "PD_BillDetailHeaderView.h"
#import "PD_BillDetailFooterView.h"
#import "PD_BillListSkuCell.h"

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
@end

@implementation PD_BillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"订单完成";
    self.view.backgroundColor = CF6F6F6;
    [self creatTableView];
}

#pragma mark ---- Table ----
- (void)creatTableView
{
    UITableView *orderDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    orderDetailTable.delegate = self;
    orderDetailTable.dataSource = self;
    [self.view addSubview:orderDetailTable];
    self.orderDetailTable = orderDetailTable;
    orderDetailTable.separatorStyle = NO;
    orderDetailTable.tableHeaderView = [self creatTableHeaderView];
    orderDetailTable.tableFooterView = [self creatTableFooterView];
}

#pragma mark ---- TabHeadView ----
- (UIView *)creatTableHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(76))];
    headerView.backgroundColor = WhiteColor;
    
    
    //收件人姓名
    UILabel *receiverNameLabel = [UILabel getLabelWithFont:FB13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(29));
        make.top.offset(AD_HEIGHT(13));
        
        view.text = @"梅长苏";
    }];
    
    //收件人手机号
    UILabel *receiverPhoneLabel = [UILabel getLabelWithFont:FB13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(receiverNameLabel.mas_right).offset(AD_HEIGHT(8));
        make.top.offset(AD_HEIGHT(14));
        
        view.text = @"189****2371";
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
    UILabel *receiverAddressLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(receiverAddressImageV.mas_right).offset(AD_HEIGHT(3));
        make.top.equalTo(receiverAddressImageV.mas_top);
        
        view.text = @"收货地址：上海市黄浦区北京东688号北西楼15F";
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
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(500))];
    footerView.backgroundColor = CF6F6F6;
    
    //商品总价
    SLOrdersDeteiledLabel *goodTotalPriceLabel = [[SLOrdersDeteiledLabel alloc] init];
    goodTotalPriceLabel.title = @"商品总价";
    goodTotalPriceLabel.textStr = @"￥1500";
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
    discountPriceLabel.textStr = @"-￥200";
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
    postPriceLabel.textStr = @"￥50";
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
    totalLabel.textStr = @"￥1500";
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
        view.text = @"订单编号：203498230482039482";
    }];
    self.orderNoLabel = orderNoLabel;
    
    //右侧复制
    UIButton *copyBtn = [UIButton getButtonWithImageName:@"" titleText:@"复制"  superView:otherInfoView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
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
        view.text = @"创建时间：2014-07-12 12:23:22";
    }];
    self.creatTimeLabel = creatTimeLabel;
    
    //付款时间
    UILabel *payTimeLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:otherInfoView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.creatTimeLabel.mas_bottom).offset(AD_HEIGHT(8));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"付款时间：2014-07-12 12:23:22";
    }];
    self.payTimeLabel = payTimeLabel;
    
    //发货时间
    UILabel *sendTimeLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:otherInfoView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(weakSelf.payTimeLabel.mas_bottom).offset(AD_HEIGHT(8));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"发货时间：2014-07-12 12:23:22";
    }];
    self.sendTimeLabel = sendTimeLabel;
    
    return footerView;
}

#pragma mark -- tableView代理数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    SLLog(@"%lu",(unsigned long)[[self.orderModelArr[section] items] count]);
    return section==0?2:1;
    //    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PD_BillListSkuCell *cell = [PD_BillListSkuCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(94);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    PD_BillDetailHeaderView *headerView = [[PD_BillDetailHeaderView alloc] init];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AD_HEIGHT(55);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section==0?AD_HEIGHT(37):0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        PD_BillDetailFooterView * footerView = [[PD_BillDetailFooterView alloc]init];
        return footerView;
    } else {
        return  [UIView new];
    }
}


#pragma mark ---- 按钮点击 ----

//复制订单标号
- (void)copyOrderNo
{
    
//    PD_ShowToast(@"复制成功", 1);
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"203498230482039482";
}
@end
