//
//  TerminalDistributionViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/4.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalDistributionViewController.h"
#import "TerminalNoDistributionCell.h"
#import "TerminalAlreadyDistributionCell.h"
#import "BrandTableViewCell.h"
#import "PosBrandModel.h"
#import "PosGetModel.h"

@interface TerminalDistributionViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UITableView *brandTableView;
@property (nonatomic, strong) UIView *snBgView;

@property (nonatomic, strong) UIView *headerBgView;

@property (nonatomic, weak) UIButton *selectBtn;
@property (nonatomic, copy) NSString *selectStr;

@property (nonatomic, strong) UITextField *startTF;//sn开始
@property (nonatomic, strong) UITextField *endTF;//SN结束


@property (nonatomic, strong) NSMutableArray *brandDataArray;
@property (nonatomic, strong) NSMutableArray *mainDataArray;



@end

@implementation TerminalDistributionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端分配";
    self.brandDataArray = [NSMutableArray array];
    self.mainDataArray = [NSMutableArray array];
    [self initUI];
    [self createTableView];
    [self createSNView];
    [self loadPosBrandRequest];
}


- (void)initUI {
    self.view.backgroundColor = CF6F6F6;
    self.headerBgView = [[UIView alloc] init];
    self.headerBgView.backgroundColor = WhiteColor;
    [self.view addSubview:self.headerBgView];
    [self.headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(36)));
    }];
    UIButton *brandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [brandBtn setTitle:@"品牌" forState:UIControlStateNormal];
    [brandBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [brandBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:FITiPhone6(5)];
    [brandBtn setImage:[UIImage imageNamed:@"下箭头"] forState:normal];
    [brandBtn setImage:[UIImage imageNamed:@"图层2"] forState:UIControlStateSelected];
    [brandBtn addTarget:self action:@selector(brandClick:) forControlEvents:UIControlEventTouchUpInside];
    brandBtn.titleLabel.font = F13;
    [self.headerBgView addSubview:brandBtn];
    [brandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerBgView).offset(FITiPhone6(60));
        make.top.equalTo(self.headerBgView).offset(FITiPhone6(11));
        make.width.mas_equalTo(AD_HEIGHT(70));
    }];
    UIButton *snBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [snBtn setTitle:@"终端SN号段" forState:UIControlStateNormal];
    [snBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [snBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:FITiPhone6(5)];
    [snBtn setImage:[UIImage imageNamed:@"下箭头"] forState:normal];
    [snBtn setImage:[UIImage imageNamed:@"图层2"] forState:UIControlStateSelected];
    [snBtn addTarget:self action:@selector(snClick:) forControlEvents:UIControlEventTouchUpInside];
    snBtn.titleLabel.font = F13;
    [self.headerBgView addSubview:snBtn];
    [snBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headerBgView).offset(FITiPhone6(-60));
        make.top.equalTo(self.headerBgView).offset(FITiPhone6(11));
        make.width.mas_equalTo(AD_HEIGHT(120));
    }];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.backgroundColor = C1E95F9;
    [selectBtn setTitle:@"分配" forState:UIControlStateNormal];
    [selectBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    selectBtn.layer.cornerRadius = FITiPhone6(3);
    selectBtn.layer.masksToBounds = YES;
    [selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    self.selectBtn = selectBtn;
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(-FITiPhone6(11));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(46)));
    }];
}

- (void)createSNView {
    self.snBgView = [[UIView alloc] init];
    self.snBgView.hidden = YES;
    self.snBgView.backgroundColor = WhiteColor;
    [self.view addSubview:self.snBgView];
    [self.snBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.equalTo(self.headerBgView.mas_bottom).offset(AD_HEIGHT(5));
        make.height.mas_equalTo(AD_HEIGHT(59));
    }];
    UILabel *snLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.snBgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
    }];
    snLabel.text = @"SN";
    self.startTF = [[UITextField alloc] init];
    self.startTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.startTF.placeholder = @"开始时间";
    self.startTF.textAlignment = NSTextAlignmentCenter;
    self.startTF.textColor = C000000;
    self.startTF.font = F13;
    self.startTF.backgroundColor = CF6F6F6;
//    self.startTF.borderStyle = UITextBorderStyleBezel;
    [self.snBgView addSubview:self.startTF];
    [self.startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(snLabel.mas_right).offset(AD_HEIGHT(17));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(142), AD_HEIGHT(29)));
    }];
    UILabel *lineLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:self.snBgView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.startTF.mas_right).offset(AD_HEIGHT(10));
        make.centerY.mas_equalTo(self.snBgView.centerY);
    }];
    lineLabel.text = @"-";
    self.endTF = [[UITextField alloc] init];
    self.endTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.endTF.backgroundColor = CF6F6F6;
    //    self.startTF.placeholder = @"开始时间";
    self.endTF.textAlignment = NSTextAlignmentCenter;
    self.endTF.textColor = C000000;
    self.endTF.font = F13;
    //    self.startTimeTF.borderStyle = UITextBorderStylel;
    [self.snBgView addSubview:self.endTF];
    [self.endTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.snBgView).offset(AD_HEIGHT(-18));
        make.centerY.mas_equalTo(self.snBgView.centerY);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(142), AD_HEIGHT(29)));
    }];
    [self solveBorderWithView:self.startTF];
    [self solveBorderWithView:self.endTF];
}
#pragma mark ---- 优化边框
-(void)solveBorderWithView:(UIView *)view
{
    view.layer.borderColor = [RGB(149, 149, 149) CGColor];
    view.layer.borderWidth = 0.5f;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius  = 5.0f;
}

- (void)createTableView {
    MJWeakSelf;
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mainTableView.backgroundColor = WhiteColor;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_mainTableView];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.equalTo(weakSelf.headerBgView.mas_bottom).offset(AD_HEIGHT(5));
        make.bottom.equalTo(weakSelf.selectBtn.mas_top).offset(-AD_HEIGHT(15));
    }];
    _brandTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _brandTableView.hidden = YES;
    _brandTableView.backgroundColor = CF6F6F6;
    _brandTableView.delegate = self;
    _brandTableView.dataSource = self;
    _brandTableView.showsVerticalScrollIndicator = NO;
    _brandTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_brandTableView];
    [_brandTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.equalTo(weakSelf.headerBgView.mas_bottom);
        make.height.mas_equalTo(AD_HEIGHT(120));
        //要根据接口请求，更新高度
//        [_brandTableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_offset(self.borrowTypeArr.count * FITiPhone6(35));
//        }];
    }];
}

#pragma mark ---- 分配 ----
- (void)selectClick {
//    [SVProgressHUD showInfoWithStatus:@"分配成功"];
//    [SVProgressHUD showWithStatus:@"分配成功"];
    HUD_SUCCESS(@"分配成功");
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ---- 品牌选择 ----
- (void)brandClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.brandTableView.hidden = NO;
    }else {
        self.brandTableView.hidden = YES;
    }
}

- (void)snClick :(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.snBgView.hidden = NO;
    }else {
        self.snBgView.hidden = YES;
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _mainTableView) {
        return 10;
    }else {
        return self.brandDataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mainTableView) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            TerminalNoDistributionCell *cell = [TerminalNoDistributionCell cellWithTableView:tableView];
            cell.brandLabel.text = @"品牌：狐族";
            cell.snLabel.text = @"SN：C090323";
            if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
                cell.selectBtn.selected = YES;
            } else {
                cell.selectBtn.selected = NO;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
            
        }else {
            TerminalAlreadyDistributionCell *cell = [TerminalAlreadyDistributionCell cellWithTableView:tableView];
            cell.brandLabel.text = @"品牌：胡子";
            cell.snLabel.text = @"SN：C090323999";
            cell.bindStateLabel.text = @"已绑定";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else {
        BrandTableViewCell *cell = [BrandTableViewCell cellWithTableView:tableView];
        PosBrandModel *model = self.brandDataArray[indexPath.row];
        cell.backgroundColor = CF6F6F6;
        cell.brandLabel.text = model.posBrandName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _mainTableView) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            TerminalNoDistributionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.selectBtn.selected = !cell.selectBtn.selected;
            if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
                self.selectStr = @"";
            } else {
                self.selectStr = [NSString stringWithFormat:@"%li",indexPath.row];
            }
            
//            [tableView reloadData];
            
        }
    }else {
        BrandTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectBtn.selected = !cell.selectBtn.selected;
        if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
            self.selectStr = @"";
        } else {
            self.selectStr = [NSString stringWithFormat:@"%li",indexPath.row];
        }
        
        
//        [tableView reloadData];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _mainTableView) {
        return AD_HEIGHT(59);
    }else {
        return AD_HEIGHT(40);
    }
}


#pragma mark ---- pos品牌 ----
- (void)loadPosBrandRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/posBrand/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    if (array.count > 0) {
                        [self.brandDataArray addObjectsFromArray:[PosBrandModel mj_objectArrayWithKeyValuesArray:array]];
                        [self.brandTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.mas_offset(self.brandDataArray.count * FITiPhone6(40));
                        }];
                        
                        [self.brandTableView reloadData];
                        
                    }
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
    
}
#pragma mark ---- 终端分配(查询) ----
- (void)loadPosListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/pos/list" params:@{@"userid":@"1", @"posBrandNo":@"", @"startPosSnNo":@"", @"endPosSnNo":@""} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    if (array.count > 0) {
                        
                        [self.mainDataArray addObjectsFromArray:[PosGetModel mj_objectArrayWithKeyValuesArray:array]];
                        
                        
                        [self.mainTableView reloadData];
                        
                    }
                    
                    
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}



@end














