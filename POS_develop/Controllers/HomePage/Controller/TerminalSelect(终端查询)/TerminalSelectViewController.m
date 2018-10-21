//
//  TerminalSelectViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalSelectViewController.h"
#import "TerminalSelectMainView.h"
#import "TerminalSelectResultViewController.h"
#import "PosBrandModel.h"
#import "PosTermTypeListModel.h"
#import "PosTermModelListModel.h"

@interface TerminalSelectViewController ()
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSMutableArray *brandDataArray;
@property (nonatomic, strong) NSMutableArray *termTypeDataArray;
@property (nonatomic, strong) NSMutableArray *termModelDataArray;
@property (nonatomic, strong) TerminalSelectMainView *mainView;
@end

@implementation TerminalSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端查询";
    self.brandDataArray = [NSMutableArray array];
    self.termTypeDataArray = [NSMutableArray array];
    self.termModelDataArray = [NSMutableArray array];
    self.view.backgroundColor = CF6F6F6;
    [self initUI];
    [self loadPosBrandRequest];
}


- (void)initUI {
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-navH)];
    mainScrollView.backgroundColor = CF6F6F6;
    [self.view addSubview:mainScrollView];
    
    
    TerminalSelectMainView *mainView = [[[NSBundle mainBundle] loadNibNamed:@"TerminalSelectMainView" owner:self options:nil] lastObject];
    self.mainView = mainView;
    __weak typeof(mainView) wkmainView = mainView;
    mainView.brandBlock = ^(NSString * _Nonnull selectedStr) {//机器品牌
        wkmainView.brandNameLabel.text = selectedStr;
    };
    mainView.typeBlock = ^(NSString * _Nonnull selectedStr){//机器类型
        wkmainView.typeNameLabel.text = selectedStr;
    };
    mainView.modelBlock = ^(NSString * _Nonnull selectedStr){//机器型号
        wkmainView.modelNameLabel.text = selectedStr;
    };
    mainView.isActivationBlock = ^(NSString * _Nonnull selectedStr){//是否激活
        wkmainView.isActivationNameLabel.text = selectedStr;
    };
    mainView.frame = CGRectMake(0, 0, ScreenWidth, 520);
    mainView.backgroundColor = WhiteColor;
    [mainScrollView addSubview:mainView];

    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(AD_HEIGHT(15), CGRectGetMaxY(mainView.frame)+AD_HEIGHT(23), ScreenWidth-AD_HEIGHT(30), AD_HEIGHT(46));
    [selectBtn setTitle:@"查询" forState:normal];
    [selectBtn setTitleColor:WhiteColor forState:normal];
    selectBtn.titleLabel.font = F15;
    [selectBtn setBackgroundColor:C1E95F9];
    selectBtn.layer.masksToBounds = YES;
    selectBtn.layer.cornerRadius = 3.f;
    [selectBtn addTarget:self action:@selector(clickSelectBtn) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:selectBtn];
    self.selectBtn = selectBtn;
    
    mainScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(self.selectBtn.frame)+AD_HEIGHT(20));
}

#pragma mark ---- 查询 ----
- (void)clickSelectBtn {
    [self loadPosListRequest];
   
}


#pragma mark ------------------------------------ 接口 ------------------------------------

#pragma mark ---- pos品牌 ----
- (void)loadPosBrandRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/posBrand/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
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
                        self.mainView.posBrandNameArr = [tempArray mutableCopy];
                        
                    }
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/posTermType/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    if (array.count > 0) {
                        [self.termTypeDataArray addObjectsFromArray:[PosTermTypeListModel mj_objectArrayWithKeyValuesArray:array]];
                        NSMutableArray *tempArray = [NSMutableArray array];
                        for (int i = 0; i < self.termTypeDataArray.count; i++) {
                            PosTermTypeListModel *model = self.termTypeDataArray[i];
                            [tempArray addObject:model.posTermTypeName];
                        }
                        self.mainView.posTermTypeNameArr = [tempArray mutableCopy];

                    }
                }

            }


        }
        NSLog(@"result ------- %@", result);
    }];
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/posTermModel/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    if (array.count > 0) {
                        [self.termModelDataArray addObjectsFromArray:[PosTermModelListModel mj_objectArrayWithKeyValuesArray:array]];
                        NSMutableArray *tempArray = [NSMutableArray array];
                        for (int i = 0; i < self.termModelDataArray.count; i++) {
                            PosTermModelListModel *model = self.termModelDataArray[i];
                            [tempArray addObject:model.posModelName];
                        }
                        self.mainView.posTermModelNameArr = [tempArray mutableCopy];
                        
                    }
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}


#pragma mark ---- 终端查询 ----
- (void)loadPosListRequest {
    NSString *activationType;
    if ([self.mainView.isActivationNameLabel.text isEqualToString:@"是"]) {
        activationType = @"1";
    }else if ([self.mainView.isActivationNameLabel.text isEqualToString:@"否"]) {
        activationType = @"0";
    }else {
        activationType = @"3";
    }
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/pos/list" params:@{@"userid":@"1", @"posBrandName":self.mainView.brandNameLabel.text, @"posTermType":self.mainView.typeNameLabel.text, @"posTermModel":self.mainView.modelNameLabel.text, @"agentName":self.mainView.delegateNameTF.text, @"agentNo":self.mainView.platformAccountTF.text, @"startPosSnNo":self.mainView.snStartTF.text, @"endPosSnNo":self.mainView.snEndTF.text, @"activationType":activationType, @"startTime":self.mainView.activationStartTF.text, @"endTime":self.mainView.activationEndTF.text} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
//                    if (array.count > 0) {
//                        [self.brandDataArray addObjectsFromArray:[PosBrandModel mj_objectArrayWithKeyValuesArray:array]];
//                        NSMutableArray *tempArray = [NSMutableArray array];
//                        for (int i = 0; i < self.brandDataArray.count; i++) {
//                            PosBrandModel *model = self.brandDataArray[i];
//                            [tempArray addObject:model.posBrandName];
//                        }
//                        self.mainView.posBrandNameArr = [tempArray mutableCopy];
//
//                    }
                    
                    
                    
                    TerminalSelectResultViewController *vc = [[TerminalSelectResultViewController alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
    
}
@end























