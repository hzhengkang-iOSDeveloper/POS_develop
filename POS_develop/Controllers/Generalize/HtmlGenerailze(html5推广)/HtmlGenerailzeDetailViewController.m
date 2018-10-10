//
//  HtmlGenerailzeDetailViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "HtmlGenerailzeDetailViewController.h"
#import "HtmlGenerailzeDetailCell.h"

@interface HtmlGenerailzeDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation HtmlGenerailzeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"html5推广";
    [self createTableView];
}

- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _myTableView.backgroundColor = WhiteColor;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HtmlGenerailzeDetailCell *cell = [HtmlGenerailzeDetailCell cellWithTableView:tableView];
    cell.idLabel.text = @"ID:123123";
    cell.nickNameLabel.text = @"昵称:胡子";
    cell.readTime.text = @"阅读时间:17秒";
    NSMutableAttributedString *idStr = [[NSMutableAttributedString alloc] initWithString:cell.idLabel.text];
    // 改变颜色
    [idStr addAttribute:NSForegroundColorAttributeName value:C989898 range:NSMakeRange(3,cell.idLabel.text.length-3)];
    [idStr addAttribute:NSFontAttributeName value:
     F10 range:NSMakeRange(3,cell.idLabel.text.length-3)];
    
    cell.idLabel.attributedText = idStr;
    
    NSMutableAttributedString *nickNameStr = [[NSMutableAttributedString alloc] initWithString:cell.nickNameLabel.text];
    // 改变颜色
    [nickNameStr addAttribute:NSForegroundColorAttributeName value:C989898 range:NSMakeRange(3,cell.nickNameLabel.text.length-3)];
    [nickNameStr addAttribute:NSFontAttributeName value:
     F10 range:NSMakeRange(3,cell.nickNameLabel.text.length-3)];
    
    cell.nickNameLabel.attributedText = nickNameStr;
    
    NSMutableAttributedString *readTimeStr = [[NSMutableAttributedString alloc] initWithString:cell.readTime.text];
    // 改变颜色
    [readTimeStr addAttribute:NSForegroundColorAttributeName value:C1E95F9 range:NSMakeRange(5,cell.readTime.text.length-5)];

    
    cell.readTime.attributedText = readTimeStr;

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
    iconImageView.image = [UIImage imageNamed:@"图层7"];
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
@end
