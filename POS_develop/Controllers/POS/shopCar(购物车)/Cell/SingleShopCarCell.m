//
//  SingleShopCarCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/21.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "SingleShopCarCell.h"
#import "ShopCar_ProductModel.h"
@interface SingleShopCarCell ()
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIImageView *myImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *amountLabel;
@property (nonatomic, weak) UILabel *skuCountLabel;
@end
@implementation SingleShopCarCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"SingleShopCarCell";
    SingleShopCarCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SingleShopCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI
{
    self.contentView.backgroundColor = WhiteColor;
    MJWeakSelf;
    
    UIButton *selectedBtn = [UIButton getButtonWithImageName:@"图层5拷贝" titleText:@"" superView:self.contentView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(15), AD_HEIGHT(15)));
        
        [btn setImage:ImageNamed(@"图层4拷贝") forState:UIControlStateSelected];
        
    }];
    self.selectedBtn = selectedBtn;
    
    UIImageView *myImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:myImageView];
    self.myImageView = myImageView;
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.selectedBtn.mas_right).offset(AD_HEIGHT(10));
        make.top.offset(AD_HEIGHT(10));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(50), AD_HEIGHT(43)));
    }];
    
    
    UILabel *titleLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.myImageView.mas_right).offset(AD_HEIGHT(12));
        make.top.offset(AD_HEIGHT(14));
        
        view.textAlignment = NSTextAlignmentLeft;
    }];
    self.titleLabel = titleLabel;
    
    UILabel * amountLabel = [UILabel getLabelWithFont:F13 textColor:RGB(240, 21, 21) superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(AD_HEIGHT(9));
        make.left.equalTo(self.titleLabel.mas_left);
        
    }];
    self.amountLabel = amountLabel;
    
    //商品增减数量
    UIView *skuCountMainView = [UIView getViewWithColor:WhiteColor superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(28));
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
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = CE6E2E2;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.bottom.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
    }];
}


#pragma mark ---- 减 ----
- (void)clickSubtractbtn
{
    
}
#pragma mark ---- 加 ----
- (void)clickAddbtn
{
    
}

- (void)setProductM:(ShopCar_ProductModel *)productM
{
    if (productM) {
        _productM = productM;
        
        self.amountLabel.text = [NSString stringWithFormat:@"￥%@", productM.posPrice];
        [self.myImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://106.14.7.85:9000%@",productM.productImg]]];
        self.titleLabel.text = productM.posBrandName;
    }
}
@end
