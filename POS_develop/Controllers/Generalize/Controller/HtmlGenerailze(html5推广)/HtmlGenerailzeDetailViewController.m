//
//  HtmlGenerailzeDetailViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "HtmlGenerailzeDetailViewController.h"
#import "HtmlGenerailzeDetailCell.h"
#import "ShareH5ReaderModel.h"

@interface HtmlGenerailzeDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HtmlGenerailzeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"html5推广";
    self.dataArray = [NSMutableArray array];
    [self createTableView];
    [self loadShareH5ReaderRequest];
}

- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _myTableView.backgroundColor = WhiteColor;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.mj_header = [SLRefreshHeader headerWithRefreshingBlock:^{
        [self loadShareH5ReaderRequest];
    }];
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HtmlGenerailzeDetailCell *cell = [HtmlGenerailzeDetailCell cellWithTableView:tableView];
    ShareH5ReaderModel *model = self.dataArray[indexPath.section];
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(73);
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AD_HEIGHT(98);
    }else {
        return 0.01f;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    return footerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self createHeaderView];
    }else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
        return headerView;
    }
}


- (UIView *)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(98))];
    headerView.backgroundColor = WhiteColor;
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [iconImageView sd_setImageWithURL:URL(self.iconStr)];
    [headerView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(9));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(50), AD_HEIGHT(45)));
    }];
    UILabel *contentLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).offset(AD_HEIGHT(18));
        make.right.offset(AD_HEIGHT(-46));
        make.centerY.equalTo(iconImageView.mas_centerY);
    }];
    contentLabel.numberOfLines = 2;
    contentLabel.text = self.contentStr;
    
    UIView *bgView = [UIView getViewWithColor:CF6F6F6 superView:headerView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(35)));
    }];
    UIImageView *bitImageView = [[UIImageView alloc] init];
    bitImageView.image = [UIImage imageNamed:@"查看过"];
    [headerView addSubview:bitImageView];
    [bitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.top.equalTo(bgView.mas_top).offset(AD_HEIGHT(11));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(15), AD_HEIGHT(15)));
    }];
    UILabel *noteLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(bitImageView.mas_right).offset(AD_HEIGHT(9));
        make.centerY.equalTo(bitImageView.mas_centerY);
    }];
    noteLabel.text = @"这些人查看过";
    return headerView;
    
}


#pragma mark ---- 接口 ----
- (void)loadShareH5ReaderRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/shareH5Reader/list" params:@{@"tbShareH5Id":self.tbShareH5Id} cookie:nil result:^(bool success, id result) {
        [self.myTableView.mj_header endRefreshing];
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSDictionary *array = result[@"data"][@"rows"];
                        self.dataArray = [NSMutableArray arrayWithArray:[ShareH5ReaderModel mj_objectArrayWithKeyValuesArray:array]];
                        
                        [self.myTableView reloadData];
                    }
                    
                }
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}


@end
