//
//  POS_ShopCarViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/21.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POS_ShopCarViewController.h"
#import "ShopCarMainCell.h"//套餐cell
#import "SingleShopCarMainCell.h"//单点cell
#import "ShopCarModel.h"
@interface POS_ShopCarViewController () <UITableViewDelegate,UITableViewDataSource>
//bottomView
@property (nonatomic, weak) UIView *bottomView;
//全选
@property (nonatomic, weak) UIButton  *allSelectedBtn;
//结算按钮
@property (nonatomic, weak) UIButton   *jieSuanBtn;
@property (nonatomic, weak) UILabel     *allMoneyLabel;
@property (nonatomic, weak) UILabel     *yunFeiLabel;

@property (nonatomic, strong) UITableView *myTableView;

//数据源
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation POS_ShopCarViewController
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatBottomView];
    [self creatTabelView];
    self.navigationItemTitle = @"购物车";
}

#pragma mark CreatTabelView
- (void)creatTabelView{
    MJWeakSelf;
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.backgroundColor = CF6F6F6;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.equalTo(weakSelf.bottomView.mas_top);
    }];
}

#pragma mark ---- 底部结算View ----
- (void)creatBottomView
{
    UIView *bottomView = [UIView getViewWithColor:WhiteColor superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.height.mas_equalTo(AD_HEIGHT(58));
    }];
    self.bottomView = bottomView;
    
    UIButton *allSelectedBtn = [UIButton getButtonWithImageName:@"图层5拷贝" titleText:@"全选" superView:bottomView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(50), AD_HEIGHT(35)));
        
        [btn setImage:ImageNamed(@"图层4拷贝") forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickAllSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = F12;
        [btn setTitleColor:C000000 forState:normal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    }];
    self.allSelectedBtn = allSelectedBtn;
    
    //结算按钮
    UIButton *jieSuanBtn = [UIButton getButtonWithImageName:@"" titleText:@"结算" superView:bottomView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(88), AD_HEIGHT(31)));
        
        [btn setBackgroundColor:C1E95F9];
        [btn addTarget:self action:@selector(clickJieSuanBtn) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = F12;
        [btn setTitleColor:WhiteColor forState:normal];
    }];
    self.jieSuanBtn = jieSuanBtn;
    
    
    UILabel *allMoneyLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bottomView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.equalTo(self.jieSuanBtn.mas_left).offset(-AD_HEIGHT(13));
        make.top.offset(AD_HEIGHT(18));
        
        NSString *str = @"合计：1000元";
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:str];
        [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0, 3)];
        [attstr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(3, str.length - 3)];
        view.attributedText = attstr;
        
    }];
    self.allMoneyLabel = allMoneyLabel;
    
    UILabel *yunFeiLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView: bottomView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.equalTo(self.jieSuanBtn.mas_left).offset(-AD_HEIGHT(13));
        make.top.equalTo(self.allMoneyLabel.mas_bottom).offset(AD_HEIGHT(9));
        view.textAlignment = NSTextAlignmentLeft;
        
        
        NSString *str = @"运费6元";
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:str];
        [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0, 2)];
        [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(2, str.length - 3)];
        [attstr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(str.length - 1, 1)];
        view.attributedText = attstr;
    }];
    
    UILabel *leftLabel = [UILabel getLabelWithFont:F9 textColor:C989898 superView:bottomView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerY.equalTo(yunFeiLabel.mas_centerY);
        make.right.equalTo(yunFeiLabel.mas_left).offset(-AD_HEIGHT(15));
        
        view.text = @"不含运费";
        view.textAlignment = NSTextAlignmentLeft;
    }];
    
    
}

#pragma mark ---- sectionFooterView ----
//- (UIView *)creatSectionFooterView
//{
//    UIView *footerView = [[UIView alloc]init];
//    footerView.backgroundColor = WhiteColor;
//    
//    
//}
#pragma mark ---- 全选点击 ----
- (void)clickAllSelectedBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

#pragma mark ---- 结算点击 ----
- (void)clickJieSuanBtn
{
    
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

#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section ==0?2:5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ShopCarMainCell *cell = [ShopCarMainCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        SingleShopCarMainCell *cell = [SingleShopCarMainCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //30 headerViewH   46 footerViewH  60rowH   5 space
        return AD_HEIGHT(30)+AD_HEIGHT(46)+2*AD_HEIGHT(60)+AD_HEIGHT(5);
    }
    return AD_HEIGHT(32)+AD_HEIGHT(60)*2+AD_HEIGHT(5);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    POS_ShopDetailViewController *vc = [[POS_ShopDetailViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return section == 0?[self creatHeaderWithText:@"套餐"]:[self creatHeaderWithText:@"单点"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AD_HEIGHT(29);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

@end
