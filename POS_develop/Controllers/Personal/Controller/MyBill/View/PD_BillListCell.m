//
//  PD_BillListCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/19.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillListCell.h"
#import "PD_BillListSkuCell.h"
@interface PD_BillListCell ()<UITableViewDelegate,UITableViewDataSource>
//状态view
@property (nonatomic, weak) UIView *billStatusView;
//日期
@property (nonatomic, weak) UILabel *dateLabel;
//订单状态
@property (nonatomic, weak) UILabel *billStatusLabel;


//sku List
@property (nonatomic, weak) UITableView *skuListTable;


//底部view
@property (nonatomic, weak) UIView *bottomView;
//免费
@property (nonatomic, weak) UILabel *isFreeLabel;
//数量 价格描述
@property (nonatomic, weak) UILabel *countAndPriceLabel;
//右边按钮
@property (nonatomic, weak) UIButton *rightBtn;
//左侧按钮
@property (nonatomic, weak) UIButton *leftBtn;
@end

@implementation PD_BillListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"PD_BillListCell";
    PD_BillListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PD_BillListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.contentView.backgroundColor = CF6F6F6;
    
    MJWeakSelf;
    //状态view
    UIView *billStatusView = [UIView new];
    billStatusView.backgroundColor = WhiteColor;
    [self.contentView addSubview:billStatusView];
    self.billStatusView  = billStatusView;
    [_billStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(36)));
    }];
    
   //日期
    UILabel *dateLabel = [UILabel new];
    dateLabel.textColor = C000000;
    dateLabel.font = F13;
    dateLabel.textAlignment = NSTextAlignmentLeft;
    [self.billStatusView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(AD_HEIGHT(16));
    }];
    
    
    //订单状态
    UILabel *billStatusLabel = [UILabel new];
    billStatusLabel.textColor = C000000;
    billStatusLabel.font = F13;
    billStatusLabel.textAlignment = NSTextAlignmentRight;
    [self.billStatusView addSubview:billStatusLabel];
    self.billStatusLabel = billStatusLabel;
    [_billStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-AD_HEIGHT(16));
    }];
    
    //line
    UIView *lineView = [UIView new];
    lineView.backgroundColor = CE6E2E2;
    [self.billStatusView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.height.mas_equalTo(1);
        make.bottom.offset(0);
    }];
    
    
    //tableView
    UITableView *billListTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    billListTable.backgroundColor = CF6F6F6;
    billListTable.delegate = self;
    billListTable.dataSource = self;
    billListTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:billStatusView];
    self.skuListTable = billListTable;
    [_skuListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(weakSelf.billStatusView.mas_bottom);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(AD_HEIGHT(94));
    }];
    
    //bottomView
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = WhiteColor;
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(weakSelf.skuListTable.mas_bottom);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(100)));
    }];
    
    
    //免费
    UILabel *isFreeLabel = [UILabel new];
    isFreeLabel.text = @"免费";
    isFreeLabel.textColor = CF52542;
    isFreeLabel.font = F13;
    isFreeLabel.textAlignment = NSTextAlignmentLeft;
    [self.bottomView addSubview:isFreeLabel];
    self.isFreeLabel = isFreeLabel;
    [_isFreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(14));
    }];
    
    //数量 价格描述
    UILabel *countAndPriceLabel = [UILabel new];
    countAndPriceLabel.font = F12;
    countAndPriceLabel.textAlignment = NSTextAlignmentRight;
    [self.bottomView addSubview:countAndPriceLabel];
    self.countAndPriceLabel = countAndPriceLabel;
    [_countAndPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(16));
        make.top.offset(AD_HEIGHT(14));
    }];
    NSString *priceStr = @"共2件 应付总额：￥184.20";
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:priceStr];
    [attriStr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0, 9)];
    [attriStr addAttribute:NSForegroundColorAttributeName value:CF60303 range:NSMakeRange(9, priceStr.length-9)];
    
    
    //右边按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"确认收货" forState:normal];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = AD_HEIGHT(11);
    [rightBtn setTitleColor:WhiteColor forState:normal];
    [rightBtn setBackgroundColor:CFF0000];
    rightBtn.titleLabel.font = F13;
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:rightBtn];
    self.rightBtn = rightBtn;
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.top.equalTo(weakSelf.countAndPriceLabel.mas_bottom).offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(21)));
    }];
    
    //左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"查看物流" forState:normal];
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.cornerRadius = AD_HEIGHT(11);
    leftBtn.layer.borderColor = C989898.CGColor;
    leftBtn.layer.borderWidth = 1.f;
    [leftBtn setTitleColor:C000000 forState:normal];
    [leftBtn setBackgroundColor:WhiteColor];
    leftBtn.titleLabel.font = F13;
    [leftBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:leftBtn];
    self.leftBtn = leftBtn;
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.rightBtn.mas_left).offset(-AD_HEIGHT(10));
        make.top.equalTo(weakSelf.rightBtn.mas_top);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(70), AD_HEIGHT(21)));
    }];
    
}

#pragma mark ---- 按钮点击 ----
- (void)rightBtnClick
{
    
}

- (void)leftBtnClick
{
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PD_BillListSkuCell *cell = [PD_BillListSkuCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(94);
}
@end
