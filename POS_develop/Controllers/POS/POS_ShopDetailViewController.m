//
//  POS_ShopDetailViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/11.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POS_ShopDetailViewController.h"
#import "POS_ShopDetailInfoView.h"
#import "POS_ShopRecommendCell.h"
@interface POS_ShopDetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSUInteger _skuCount;//记录sku 数量
}
@property (nonatomic, strong) UIScrollView *mainScrollView;
//bottomView
//价格
@property (nonatomic, weak) UILabel *goodPriceLabel;
//商品增减数量
@property (nonatomic, weak) UILabel *skuCountLabel;
//商品信息View
@property (nonatomic, weak) POS_ShopDetailInfoView *shopDetailInfoView;
//推荐商品
@property (nonatomic, weak) UITableView *recommendGoodTableView;
@end

@implementation POS_ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor  = WhiteColor;
    _skuCount = 1;
    // 解决iOS11 automaticallyAdjustsScrollViewInsets 失效 (scrollview 的 20 偏移量)
    if (@available(iOS 11.0, *)) self.mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [self creatGoodInfoView];
    [self creatBottomView];
}
//MARK: ------------------------------------------------------ 视图层 ------------------------------------------------------
#pragma mark ---- 主控件(UIScrollView) ----
- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-AD_HEIGHT(54))];
        _mainScrollView.delegate = self;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.backgroundColor = CF6F6F6;
        [self.view addSubview:_mainScrollView];
        
    }
    return _mainScrollView;
}
#pragma mark ---- 商品信息View ----
- (void)creatGoodInfoView
{
    POS_ShopDetailInfoView *shopDetailInfoView = [[POS_ShopDetailInfoView alloc]init];
    [self.mainScrollView addSubview:shopDetailInfoView];
    self.shopDetailInfoView  = shopDetailInfoView;
    [_shopDetailInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.mas_equalTo(ScreenWidth);
    }];
    
    //推荐商品
    MJWeakSelf;
    UITableView *recommendGoodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    recommendGoodTableView.delegate = self;
    recommendGoodTableView.dataSource = self;
    recommendGoodTableView.separatorStyle = NO;
    [self.mainScrollView addSubview:recommendGoodTableView];
    self.recommendGoodTableView = recommendGoodTableView;
    [_recommendGoodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.shopDetailInfoView.mas_bottom).offset(AD_HEIGHT(5));
        make.left.equalTo(weakSelf.view).offset(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(AD_HEIGHT(28)+AD_HEIGHT(89)*2);
    }];
}


- (void)creatBottomView
{
    MJWeakSelf;
    UIView *bottomView = [UIView getViewWithColor:WhiteColor superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottomLayoutGuideTop).offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(54)));
    }];
    
    //加入购物车
    UIButton *addCarBtn = [UIButton getButtonWithImageName:@"购物车" titleText:@"加入购物车" superView:bottomView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(96), AD_HEIGHT(32)));
        
        [btn setTitleColor:WhiteColor forState:normal];
        btn.titleLabel.font = F12;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -7)];
        btn.backgroundColor = C1E95F9;
        [btn addTarget:self action:@selector(addShopCar) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    
    //商品增减数量
    UIView *skuCountMainView = [UIView getViewWithColor:WhiteColor superView:bottomView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.right.equalTo(addCarBtn.mas_left).offset(-AD_HEIGHT(52));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(100), AD_HEIGHT(26)));
        
        view.layer.borderWidth =1;
        view.layer.borderColor = CF6F6F6.CGColor;
        
    }];
    
    //减
    UIButton *subtractBtn = [UIButton getButtonWithImageName:@"" titleText:@"一" superView:skuCountMainView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.top.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(29), AD_HEIGHT(26)));
        
        [btn setTitleColor:RGB(134, 134, 134) forState:normal];
        btn.titleLabel.font = F10;
        [btn addTarget:self action:@selector(clickSubtractbtn) forControlEvents:UIControlEventTouchUpInside];
    }];
    UIView *leftLineView = [UIView getViewWithColor:CF6F6F6 superView:skuCountMainView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.equalTo(subtractBtn.mas_right);
        make.top.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(1), AD_HEIGHT(26)));
        
    }];
    
    //加
    UIButton *addBtn = [UIButton getButtonWithImageName:@"" titleText:@"+" superView:skuCountMainView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.top.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(29), AD_HEIGHT(26)));
        
        [btn setTitleColor:RGB(134, 134, 134) forState:normal];
        btn.titleLabel.font = F16;
        [btn addTarget:self action:@selector(clickAddbtn) forControlEvents:UIControlEventTouchUpInside];
    }];
    UIView *rightLineView = [UIView getViewWithColor:CF6F6F6 superView:skuCountMainView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.right.equalTo(addBtn.mas_left);
        make.top.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(1), AD_HEIGHT(26)));
    }];
    
    UILabel *skuCountLabel = [UILabel getLabelWithFont:FB15 textColor:C000000  superView:skuCountMainView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(leftLineView.mas_right).offset(0);
        make.right.equalTo(rightLineView.mas_left).offset(0);
        make.height.mas_equalTo(AD_HEIGHT(26));
        make.top.offset(0);
        
        view.text  = @"1";
        view.textAlignment = NSTextAlignmentCenter;
        
    }];
    self.skuCountLabel = skuCountLabel;
    
    
    //价格
    UILabel *goodPriceLabel = [UILabel getLabelWithFont:F13 textColor:CF52542 superView:bottomView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        make.right.equalTo(skuCountMainView.mas_left);
        make.height.mas_equalTo(AD_HEIGHT(13));
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"￥6023";
    }];
    self.goodPriceLabel = goodPriceLabel;
}

#pragma mark ---- 加入购物车 ----
- (void)addShopCar
{
    
}
#pragma mark ---- 减 ----
- (void)clickSubtractbtn
{
    if (_skuCount == 1) {
        HUD_TIP(@"数量最少为1");
        return;
    }
    if (_skuCount > 1) {
        _skuCount --;
    }
    
    self.skuCountLabel.text = [NSString stringWithFormat:@"%li",_skuCount];
}
#pragma mark ---- 加 ----
- (void)clickAddbtn
{
    if (_skuCount == 10) {
        HUD_TIP(@"数量已超上限");
        return;
    }
    if (_skuCount <10) {
        _skuCount ++;
    }
    self.skuCountLabel.text = [NSString stringWithFormat:@"%li",_skuCount];
    
}


#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    POS_ShopRecommendCell *cell = [POS_ShopRecommendCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(89);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = WhiteColor;
    
    UIImageView *imagV = [[UIImageView alloc]init];
    imagV.image = ImageNamed(@"推荐套餐");
    [headerView addSubview:imagV];
    [imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.bottom.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(18), AD_HEIGHT(17)));
    }];
    
    [UILabel getLabelWithFont:F12 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(imagV.mas_right).offset(AD_HEIGHT(9));
        make.centerY.equalTo(imagV.mas_centerY);
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"推荐套餐";
    }];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AD_HEIGHT(28);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

@end
