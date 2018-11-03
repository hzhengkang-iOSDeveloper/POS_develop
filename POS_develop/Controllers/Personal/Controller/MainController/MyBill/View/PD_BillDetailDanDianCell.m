//
//  PD_BillDetailDanDianCell.m
//  POS_develop
//
//  Created by syn on 2018/10/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_BillDetailDanDianCell.h"
#import "PD_BillDetailSkuCell.h"
#import "BillListModel.h"
@interface PD_BillDetailDanDianCell ()<UITableViewDelegate,UITableViewDataSource>
//table
@property (nonatomic, strong) UITableView *myTableView;

//headerImage
@property (nonatomic, weak) UIImageView *headerImageV;
//headerTitle
@property (nonatomic, weak) UILabel *headerTitle;

@property (nonatomic, strong) NSMutableArray *dataArr;
@end
@implementation PD_BillDetailDanDianCell
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"PD_BillDetailDanDianCell";
    PD_BillDetailDanDianCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[PD_BillDetailDanDianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
- (UIView *)creatHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(32))];
    headerView.backgroundColor = WhiteColor;
    
    UIImageView *headerImageV = [[UIImageView alloc]init];
    DetailDOModel *detailM  = [self.dataArr firstObject];

    [headerImageV sd_setImageWithURL:[NSURL URLWithString:detailM.itemPic]];
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
        ItemObjModel *itemObjM = [ItemObjModel mj_objectWithKeyValues:detailM.itemObj];
        view.text = itemObjM.posBrandName;
    }];
    self.headerTitle = headerTitle;
    
    return headerView;
}


#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PD_BillDetailSkuCell *cell = [PD_BillDetailSkuCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detaiM = self.dataArr[indexPath.row];
    
    
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

//- (void)setDetailDoM:(DetailDOModel *)detailDoM
//{
//    if (detailDoM) {
//        _detailDoM = detailDoM;
//        
//        if (self.dataArr.count >0) {
//            [self.dataArr removeAllObjects];
//        }
//        self.myTableView.tableHeaderView = [self creatHeaderView];
//        ItemObjModel *itemObjM = [ItemObjModel mj_objectWithKeyValues:self.detailDoM.itemObj];
//        [self.dataArr addObjectsFromArray:itemObjM.packageChargeItemDOList];
//        [self.myTableView reloadData];
//    }
//}

- (void)setProductArr:(NSMutableArray *)productArr
{
    if (productArr) {
        _productArr = productArr;
        
        if (self.dataArr.count >0) {
            [self.dataArr removeAllObjects];
        }
        self.myTableView.tableHeaderView = [self creatHeaderView];
        [self.dataArr addObjectsFromArray:productArr];
        [self.myTableView reloadData];
    }
}
@end
