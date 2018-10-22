//
//  SingleShopCarMainCell.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/22.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "SingleShopCarMainCell.h"
#import "SingleShopCarCell.h"
@interface SingleShopCarMainCell ()<UITableViewDelegate,UITableViewDataSource>
//table
@property (nonatomic, strong) UITableView *myTableView;
//headerImage
@property (nonatomic, weak) UIImageView *headerImageV;
//headerTitle
@property (nonatomic, weak) UILabel *headerTitle;
@end


@implementation SingleShopCarMainCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"SingleShopCarMainCell";
    SingleShopCarMainCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SingleShopCarMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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


-(void)initUI
{
    
    self.contentView.backgroundColor = CF6F6F6;

    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.scrollEnabled = NO;
    self.myTableView.tableHeaderView = [self creatHeaderView];
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
- (UIView *)creatHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(32))];
    headerView.backgroundColor = WhiteColor;
    
    UIImageView *headerImageV = [[UIImageView alloc]init];
    headerImageV.image = ImageNamed(@"付临门");
    [headerView addSubview:headerImageV];
    self.headerImageV = headerImageV;
    [_headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(13));
    }];
    
    MJWeakSelf;
    UILabel *headerTitle = [UILabel getLabelWithFont:F13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImageV.mas_right).offset(AD_HEIGHT(6));
        make.top.offset(AD_HEIGHT(11));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"付临门";
    }];
    self.headerTitle = headerTitle;
    
    return headerView;
}


#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleShopCarCell *cell = [SingleShopCarCell cellWithTableView:tableView];
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
@end
