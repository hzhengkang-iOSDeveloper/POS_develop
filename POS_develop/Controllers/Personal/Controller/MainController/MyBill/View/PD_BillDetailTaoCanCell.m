//
//  PD_BillDetailTaoCanCell.m
//  POS_develop
//
//  Created by syn on 2018/10/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillDetailTaoCanCell.h"
#import "PD_BillListSkuCell.h"
#import "BillListModel.h"
@interface PD_BillDetailTaoCanCell ()<UITableViewDataSource,UITableViewDelegate>
//table
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, weak) UILabel *taoCanNameLabel;
@property (nonatomic, weak) UILabel *discountPriceLabel;//优惠价格
@property (nonatomic, weak) UILabel *totalPriceLabel;//总价
@property (nonatomic, weak) UILabel *totalCountLabel;//总数
@property (nonatomic, strong) NSMutableArray *dataArr;
@end
@implementation PD_BillDetailTaoCanCell
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"PD_BillDetailTaoCanCell";
    PD_BillDetailTaoCanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PD_BillDetailTaoCanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    self.contentView.backgroundColor = WhiteColor;
    
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
    //套餐名
    UILabel *taoCanNameLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(9));
        
        view.textAlignment = NSTextAlignmentLeft;
        view.text = self.detailDoM.itemName;
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
        
        view.text = [NSString stringWithFormat:@"￥%@",self.detailDoM.discountPrice];
    }];
    self.discountPriceLabel = discountPriceLabel;
    
    //总价
    UILabel *totalPriceLabel = [UILabel getLabelWithFont:F12 textColor:C989898 superView:footerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.discountPriceLabel.mas_right).offset(AD_HEIGHT(27));
        make.centerY.offset(0);
        
        //中划线
        NSString *str = [NSString stringWithFormat:@"￥%@",self.detailDoM.displayPrice];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
        // 赋值
        view.attributedText = attribtStr;
    }];
    self.totalPriceLabel = totalPriceLabel;
    
    //总数
    UILabel *totalCountLabel = [UILabel getLabelWithFont:F15 textColor:C000000 superView:footerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.offset(0);
        
        view.text = [NSString stringWithFormat:@"x%@",self.detailDoM.itemCount];
    }];
    self.totalCountLabel = totalCountLabel;
    
    return footerView;
}

#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PD_BillListSkuCell *cell = [PD_BillListSkuCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.itemListM = self.dataArr[indexPath.row];
    
    
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

- (void)setDetailDoM:(DetailDOModel *)detailDoM
{
    if (detailDoM) {
        _detailDoM = detailDoM;
        
        if (self.dataArr.count >0) {
            [self.dataArr removeAllObjects];
        }
        self.myTableView.tableHeaderView = [self creatHeader];
        self.myTableView.tableFooterView =  [self creatFooter];
        ItemObjModel *itemObjM = [ItemObjModel mj_objectWithKeyValues:self.detailDoM.itemObj];
        [self.dataArr addObjectsFromArray:itemObjM.packageChargeItemDOList];
        [self.myTableView reloadData];
    }
}
@end
