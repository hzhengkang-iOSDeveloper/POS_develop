//
//  TransactionQueryViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "TransactionQueryViewController.h"
#import "DatePickerView.h"
#import "TransactionQueryMainView.h"
#import "TransactionListViewController.h"
#import "PosBrandModel.h"
#import "TransactionListModel.h"

@interface TransactionQueryViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UIButton *agentBtn;
@property (nonatomic, strong) UIButton *personBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) TransactionQueryMainView *mainVie;
@property (nonatomic, strong) DatePickerView *datePickView;
@property (nonatomic, strong) NSMutableArray *brandDataArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isSelectDate;
@property (nonatomic, assign) BOOL isSelectAgentOrPerson;
@end

@implementation TransactionQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"交易查询";
    self.view.backgroundColor = CF6F6F6;
    self.brandDataArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    [self initUI];
    [self loadPosBrandRequest];
    
    
    self.isSelectDate = NO;
    self.isSelectAgentOrPerson = NO;
    
}
- (void)initUI {
    MJWeakSelf;
    
    DatePickerView *datePickView = [[DatePickerView alloc] init];
    self.datePickView = datePickView;
    datePickView.clcikDateSelected = ^(BOOL isSelected) {
        weakSelf.isSelectDate = YES;
    };
    datePickView.backVcChangeBtn = ^{
        [weakSelf.selectBtn setBackgroundColor:C1E95F9];
        weakSelf.selectBtn.userInteractionEnabled = YES;
    };
    [self.view addSubview:datePickView];
    [datePickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_offset(CGSizeMake(ScreenWidth, AD_HEIGHT(50)));
    }];
    TransactionQueryMainView *mainVie = [[[NSBundle mainBundle] loadNibNamed:@"TransactionQueryMainView" owner:self options:nil] lastObject];
    self.mainVie = mainVie;
    __weak typeof(mainVie) weakMainVie = mainVie;
    mainVie.brandBlock = ^(NSString *selectedStr) {
        weakMainVie.brandLabel.text = selectedStr;
    };
    [self.view addSubview:mainVie];
    [mainVie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(datePickView.mas_bottom);
        make.left.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(ScreenWidth, 258.5));
    }];

    self.agentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.agentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.agentBtn setTitle:@"代理商" forState:UIControlStateNormal];
    [self.agentBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [self.agentBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:FITiPhone6(13)];
    [self.agentBtn setImage:[UIImage imageNamed:@"勾选"] forState:normal];
    [self.agentBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [self.agentBtn addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
    self.agentBtn.titleLabel.font = F12;
//    self.agentBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.agentBtn];
    [self.agentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(AD_HEIGHT(100));
        make.left.equalTo(self.view).offset(AD_HEIGHT(15));
        make.top.equalTo(mainVie.mas_bottom).offset(AD_HEIGHT(22));
        make.height.mas_offset(AD_HEIGHT(25));
    }];
    
    self.personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.personBtn setTitle:@"个人" forState:UIControlStateNormal];
    [self.personBtn setTitleColor:C000000 forState:UIControlStateNormal];
    [self.personBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:FITiPhone6(13)];
    [self.personBtn setImage:[UIImage imageNamed:@"勾选"] forState:normal];
    [self.personBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [self.personBtn addTarget:self action:@selector(personClick:) forControlEvents:UIControlEventTouchUpInside];
    self.personBtn.titleLabel.font = F12;
//    self.personBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.personBtn];
    [self.personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(AD_HEIGHT(100));
        make.right.equalTo(self.view).offset(AD_HEIGHT(-100));
        make.top.equalTo(mainVie.mas_bottom).offset(AD_HEIGHT(22));
        make.height.mas_offset(AD_HEIGHT(25));
    }];
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.backgroundColor = CC9C9C9;
    self.selectBtn.userInteractionEnabled = NO;
    [self.selectBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.selectBtn.layer.cornerRadius = FITiPhone6(3);
    self.selectBtn.layer.masksToBounds = YES;
    [self.selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectBtn];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.personBtn.mas_bottom).offset(FITiPhone6(40));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(45)));
    }];
    
}

- (void)agentClick:(UIButton *)sender {
    if (!_agentBtn.selected)
    {
        _agentBtn.selected = YES;
        _personBtn.selected = NO;
    }
    
    
    [self changeSelectBtn];
    

}
- (void)personClick:(UIButton *)sender {
    if (!_personBtn.selected)
    {
        _personBtn.selected = YES;
        _agentBtn.selected = NO;
    }
    [self changeSelectBtn];
}

#pragma mark ---- 按钮显示逻辑 ----
- (void)changeSelectBtn
{
    if (!self.isSelectDate) {
        self.datePickView.agentOrPersonIsSelected = YES;
    } else {
        [self.selectBtn setBackgroundColor:C1E95F9];
        self.selectBtn.userInteractionEnabled = YES;
    }
}
#pragma mark ---- 查询 ----
- (void)selectClick {
    [self loadTransactionListRequest];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark ------------------------------------ 接口 ------------------------------------

#pragma mark ---- pos品牌 ----
- (void)loadPosBrandRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/posBrand/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSArray *array = result[@"data"][@"rows"];
                        if (array.count > 0) {
                            [self.brandDataArray addObjectsFromArray:[PosBrandModel mj_objectArrayWithKeyValuesArray:array]];
                            NSMutableArray *tempArray = [NSMutableArray array];
                            for (int i = 0; i < self.brandDataArray.count; i++) {
                                PosBrandModel *model = self.brandDataArray[i];
                                [tempArray addObject:model.posBrandName];
                            }
                            self.mainVie.posBrandNameArr = [tempArray mutableCopy];
                            
                        }
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
#pragma mark ---- 交易查询 ----
- (void)loadTransactionListRequest {
    LoginManager *manager = [LoginManager getInstance];

    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/transaction/list" params:@{@"userid":IF_NULL_TO_STRING([[UserInformation getUserinfoWithKey:UserDict] objectForKey:USERID]), @"startTime":defaultObject(self.datePickView.datePickerStrA, @""), @"endTime":defaultObject(self.datePickView.datePickerStrB, @""), @"agentName":defaultObject(self.mainVie.name.text, @""), @"agentNo":defaultObject(self.mainVie.account.text, @""), @"posSnNo":defaultObject(self.mainVie.number.text, @""), @"posBrandNo":defaultObject(self.mainVie.brandLabel.text, @""), @"agentType":_agentBtn.selected?@"1":@"0"} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    if (self.dataArray.count > 0) {
                        [self.dataArray removeAllObjects];
                    }
                    [self.dataArray addObjectsFromArray:[TransactionListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    TransactionListViewController *vc = [[TransactionListViewController alloc] init];
                    
//                    vc.dataArray = [NSMutableArray array];
                    vc.dataArray = [self.dataArray mutableCopy];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end

















