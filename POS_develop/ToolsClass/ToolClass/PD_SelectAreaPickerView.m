//
//  PD_SelectAreaPickerView.m
//  POS_develop
//
//  Created by syn on 2018/9/16.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "PD_SelectAreaPickerView.h"
@interface PD_SelectAreaPickerView ()<UITableViewDelegate,UITableViewDataSource>
//地区选择view
@property (nonatomic, weak) UITableView *areaTableView;


@end
@implementation PD_SelectAreaPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    UITableView *areaTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    areaTableView.delegate = self;
    areaTableView.dataSource = self;
    areaTableView.backgroundColor = WhiteColor;
    areaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:areaTableView];
    self.areaTableView = areaTableView;
    
}

#pragma mark ---- 头视图 ----
//- (UIView *)tableHeaderView
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FITiPhone6(62))];
//    headerView.backgroundColor = WhiteColor;
//
//    UILabel *topLabel = [[UILabel alloc]init];
//    topLabel.text = @"所在地区";
//    topLabel.textColor = C090909;
//    topLabel.font = MainFont(FITiPhone6(13));
//    topLabel.textAlignment = NSTextAlignmentLeft;
//    [headerView addSubview:topLabel];
//    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(FITiPhone6(14));
//        make.top.offset(FITiPhone6(13));
//    }];
//
//
//    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelBtn setTitle:@"取消" forState:normal];
//    [cancelBtn setTitleColor:C989898 forState:normal];
//    cancelBtn.backgroundColor = ClearColor;
//    cancelBtn.titleLabel.font = MainFont(FITiPhone6(13));
//    [cancelBtn addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
//    [headerView addSubview:cancelBtn];
//}
@end
