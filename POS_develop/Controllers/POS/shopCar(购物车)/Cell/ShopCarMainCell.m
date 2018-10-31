//
//  ShopCarMainCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/22.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "ShopCarMainCell.h"
#import "ShopCarTableViewCell.h"
#import "ShopCar_PackageModel.h"
@interface ShopCarMainCell ()<UITableViewDataSource,UITableViewDelegate>
{
    NSUInteger _skuCount;//记录sku 数量
}
//table
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UILabel *taoCanNameLabel;
@property (nonatomic, weak) UILabel *discountPriceLabel;//优惠价格
@property (nonatomic, weak) UILabel *totalPriceLabel;//总价
//商品增减数量
@property (nonatomic, weak) UILabel *skuCountLabel;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end
@implementation ShopCarMainCell
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"ShopCarMainCell";
    ShopCarMainCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ShopCarMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        _skuCount = 1;
    }
    return self;
}


-(void)initUI
{
    
    self.contentView.backgroundColor = CF6F6F6;

    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.scrollEnabled = NO;
    self.myTableView.backgroundColor = WhiteColor;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.offset(-AD_HEIGHT(5));
    }];
    
}

#pragma mark ---- header ----
- (UIView *)creatHeader
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(30))];
    headerView.backgroundColor = WhiteColor;
    
    //选中btn
    UIButton *selectedBtn = [UIButton getButtonWithImageName:@"图层5拷贝" titleText:@"" superView:headerView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(12));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(15), AD_HEIGHT(15)));
        
        [btn setImage:ImageNamed(@"图层4拷贝") forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickHeaderSelected:) forControlEvents:UIControlEventTouchUpInside];

        btn.selected = self.posRootViewM.isSelected;
        
    }];
    self.selectedBtn = selectedBtn;
    
    MJWeakSelf;
    //套餐名
    UILabel *taoCanNameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.selectedBtn.mas_right).offset(AD_HEIGHT(11));
        make.centerY.equalTo(weakSelf.selectedBtn.mas_centerY);
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = self.posRootViewM.packageName;
    }];
    self.taoCanNameLabel = taoCanNameLabel;
    
    
    return headerView;
}

#pragma mark ---- footer ----
- (UIView *)creatFooter
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(46))];
    footerView.backgroundColor = WhiteColor;
    
    MJWeakSelf;
    //优惠价格
    UILabel *discountPriceLabel = [UILabel getLabelWithFont:F13 textColor:CF52542 superView:footerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        
        view.text = [NSString stringWithFormat:@"￥%@",self.posRootViewM.packagePrice];
    }];
    self.discountPriceLabel = discountPriceLabel;
    
    //总价
    UILabel *totalPriceLabel = [UILabel getLabelWithFont:F12 textColor:C989898 superView:footerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.discountPriceLabel.mas_right).offset(AD_HEIGHT(27));
        make.centerY.offset(0);
        
        //中划线
        NSString *str = [NSString stringWithFormat:@"￥%@",self.posRootViewM.originPrice];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
        // 赋值
        view.attributedText = attribtStr;
    }];
    self.totalPriceLabel = totalPriceLabel;
    
    //商品增减数量
    UIView *skuCountMainView = [UIView getViewWithColor:WhiteColor superView:footerView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
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
        
        view.text = [NSString stringWithFormat:@"%li",self.posRootViewM.goodCount +1];

        view.textAlignment = NSTextAlignmentCenter;
        
    }];
    self.skuCountLabel = skuCountLabel;
    
    
    return footerView;
}

#pragma mark ---- 减 ----
- (void)clickSubtractbtn
{
    if (self.posRootViewM.goodCount == 0) {
        HUD_TIP(@"数量最少为1");
        return;
    }
    if (self.posRootViewM.goodCount > 0) {
        self.posRootViewM.goodCount --;
    }
    
    self.skuCountLabel.text = [NSString stringWithFormat:@"%li",self.posRootViewM.goodCount+1];
    
    if (self.posRootViewM.isSelected) {
        if (self.CaluteMoneyHandler) {
            self.CaluteMoneyHandler();
        }
    }
}
#pragma mark ---- 加 ----
- (void)clickAddbtn
{
    self.posRootViewM.goodCount ++;
    
    self.skuCountLabel.text = [NSString stringWithFormat:@"%li",self.posRootViewM.goodCount+1];
    
    if (self.posRootViewM.isSelected) {
        if (self.CaluteMoneyHandler) {
            self.CaluteMoneyHandler();
        }
    }
    
}
#pragma mark ---- 点击头部选中 ----
- (void)clickHeaderSelected:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    self.posRootViewM.isSelected = !self.posRootViewM.isSelected;
    if (self.CaluteMoneyHandler) {
        self.CaluteMoneyHandler();
    }
}



#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCarTableViewCell *cell = [ShopCarTableViewCell cellWithTableView:tableView];
    cell.packageM = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AD_HEIGHT(60);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

- (void)setPosRootViewM:(ShopCar_PackageModel *)posRootViewM
{
    if (posRootViewM) {
        _posRootViewM = posRootViewM;
        
        if (self.dataArr.count >0) {
            [self.dataArr removeAllObjects];
        }
        self.myTableView.tableHeaderView = [self creatHeader];
        self.myTableView.tableFooterView =  [self creatFooter];
        [self.dataArr addObjectsFromArray:posRootViewM.packageChargeItemDOList];
        [self.myTableView reloadData];
    }
}
@end
