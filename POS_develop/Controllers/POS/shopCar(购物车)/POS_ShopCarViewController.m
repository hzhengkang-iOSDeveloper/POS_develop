//
//  POS_ShopCarViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/21.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "POS_ShopCarViewController.h"
#import "POS_CommitBillViewController.h"//确认订单
#import "ShopCarMainCell.h"//套餐cell
#import "SingleShopCarMainCell.h"//单点cell
#import "ShopCarModel.h"
#import "ShopCar_ProductModel.h"
#import "ShopCar_PackageModel.h"

@interface POS_ShopCarViewController () <UITableViewDelegate,UITableViewDataSource>
//bottomView
@property (nonatomic, weak) UIView *bottomView;
//全选
@property (nonatomic, weak) UIButton  *allSelectedBtn;
//结算按钮
@property (nonatomic, weak) UIButton   *jieSuanBtn;
@property (nonatomic, weak) UILabel     *allMoneyLabel;
@property (nonatomic, weak) UILabel     *yunFeiLabel;

@property (nonatomic, strong) UITableView *myTableView;

//id数组
@property (nonatomic, strong) NSMutableArray *freeTaoCanArr;//免费套餐
@property (nonatomic, strong) NSMutableArray *noFreeTaoCanArr;//收费套餐
@property (nonatomic, strong) NSMutableArray *danDianArr;//产品


@property (nonatomic, strong) NSMutableArray *productArr;//产品
//数据源
@property (nonatomic, strong) NSMutableArray *productDataArr;//产品数据源
@property (nonatomic, strong) NSMutableArray *packAgeArr;//套餐数据源


@property (nonatomic, assign) NSUInteger productArrCount;//记录产品数组循环次数
@property (nonatomic, assign) NSUInteger freePackageArrCount;//记录产品数组循环次数
@property (nonatomic, assign) NSUInteger noFreePackageArrCount;//记录产品数组循环次数

@end

@implementation POS_ShopCarViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    HUD_HIDE;
}
- (NSMutableArray *)freeTaoCanArr
{
    if (!_freeTaoCanArr) {
        _freeTaoCanArr = [NSMutableArray array];
    }
    return _freeTaoCanArr;
}
- (NSMutableArray *)noFreeTaoCanArr
{
    if (!_noFreeTaoCanArr) {
        _noFreeTaoCanArr = [NSMutableArray array];
    }
    return _noFreeTaoCanArr;
}
- (NSMutableArray *)danDianArr
{
    if (!_danDianArr) {
        _danDianArr = [NSMutableArray array];
    }
    return _danDianArr;
}
- (NSMutableArray *)productDataArr
{
    if (!_productDataArr) {
        _productDataArr = [NSMutableArray array];
    }
    return _productDataArr;
}
- (NSMutableArray *)productArr
{
    if (!_productArr) {
        _productArr = [NSMutableArray array];
    }
    return _productArr;
}
- (NSMutableArray *)packAgeArr
{
    if (!_packAgeArr) {
        _packAgeArr = [NSMutableArray array];
    }
    return _packAgeArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatBottomView];
    [self creatTabelView];
    self.navigationItemTitle = @"购物车";
    self.productArrCount = 0;
    self.freePackageArrCount =0;
    self.noFreePackageArrCount = 0;
    
    [self getShopCarRequest];
}

#pragma mark CreatTabelView
- (void)creatTabelView{
    MJWeakSelf;
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.backgroundColor = CF6F6F6;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.equalTo(weakSelf.bottomView.mas_top);
    }];
}

#pragma mark ---- 底部结算View ----
- (void)creatBottomView
{
    UIView *bottomView = [UIView getViewWithColor:WhiteColor superView:self.view masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
        make.height.mas_equalTo(AD_HEIGHT(58));
    }];
    self.bottomView = bottomView;
    
    UIButton *allSelectedBtn = [UIButton getButtonWithImageName:@"图层5拷贝" titleText:@"全选" superView:bottomView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(50), AD_HEIGHT(35)));
        
        [btn setImage:ImageNamed(@"图层4拷贝") forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickAllSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = F12;
        [btn setTitleColor:C000000 forState:normal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    }];
    self.allSelectedBtn = allSelectedBtn;
    
    //结算按钮
    UIButton *jieSuanBtn = [UIButton getButtonWithImageName:@"" titleText:@"结算" superView:bottomView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.offset(-AD_HEIGHT(15));
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(88), AD_HEIGHT(31)));
        
        [btn setBackgroundColor:C1E95F9];
        [btn addTarget:self action:@selector(clickJieSuanBtn) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = F12;
        [btn setTitleColor:WhiteColor forState:normal];
    }];
    self.jieSuanBtn = jieSuanBtn;
    
    
    UILabel *allMoneyLabel = [UILabel getLabelWithFont:F13 textColor:C000000 superView:bottomView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.equalTo(self.jieSuanBtn.mas_left).offset(-AD_HEIGHT(13));
        make.top.offset(AD_HEIGHT(18));
        
        NSString *str = @"合计：0元";
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:str];
        [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0, 3)];
        [attstr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(3, str.length - 3)];
        view.attributedText = attstr;
        
    }];
    self.allMoneyLabel = allMoneyLabel;
    
    UILabel *yunFeiLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView: bottomView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.right.equalTo(self.jieSuanBtn.mas_left).offset(-AD_HEIGHT(13));
        make.top.equalTo(self.allMoneyLabel.mas_bottom).offset(AD_HEIGHT(9));
        view.textAlignment = NSTextAlignmentLeft;
        
        
        NSString *str = @"运费0元";
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:str];
        [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0, 2)];
        [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(2, str.length - 3)];
        [attstr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(str.length - 1, 1)];
        view.attributedText = attstr;
    }];
    self.yunFeiLabel = yunFeiLabel;
    
    [UILabel getLabelWithFont:F9 textColor:C989898 superView:bottomView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.centerY.equalTo(yunFeiLabel.mas_centerY);
        make.right.equalTo(yunFeiLabel.mas_left).offset(-AD_HEIGHT(15));
        
        view.text = @"不含运费";
        view.textAlignment = NSTextAlignmentLeft;
    }];
    
    
}
#pragma mark ---- 全选点击 ----
- (void)clickAllSelectedBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //将数据源中所有isSelected设置为yes
        [self changeData:YES];
    } else {
        //将数据源中所有isSelected设置为NO
        [self changeData:NO];
    }
    
    //刷新数据源
    [self.myTableView reloadData];
    
    //计算底部金额
    [self getTaoCanPriceRequest];
}

- (void)changeData:(BOOL)isSelect
{
    //将数据源中所有isSelected设置为yes
    [self.productDataArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr enumerateObjectsUsingBlock:^(ShopCar_ProductModel *  _Nonnull productM, NSUInteger idx, BOOL * _Nonnull stop) {
            productM.isSelected = isSelect;
        }];
    }];
    
    [self.packAgeArr enumerateObjectsUsingBlock:^(ShopCar_PackageModel*  _Nonnull packM, NSUInteger idx, BOOL * _Nonnull stop) {
        packM.isSelected = isSelect;
    }];
}

#pragma mark ---- 结算点击 ----
- (void)clickJieSuanBtn
{
    //遍历套餐数组
     NSString *pkgPrdIds = [NSString string];
     NSString *pkgPrdTypes= [NSString string];
     NSString *counts= [NSString string];
    __block NSMutableArray *pkgPrdIdsArr = [NSMutableArray array];
    __block NSMutableArray *pkgPrdTypesArr = [NSMutableArray array];
    __block NSMutableArray *countsArr = [NSMutableArray array];
    [self.packAgeArr enumerateObjectsUsingBlock:^(ShopCar_PackageModel *  _Nonnull packageM, NSUInteger idx, BOOL * _Nonnull stop) {
        if (packageM.isSelected) {
            [pkgPrdIdsArr addObject:packageM.ID];
            [pkgPrdTypesArr addObject:packageM.pkgPrdType];
            [countsArr addObject:[NSString stringWithFormat:@"%lu",packageM.goodCount+1]];
        }
    }];
    
    //遍历产品数组
    [self.productDataArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull productA, NSUInteger idx, BOOL * _Nonnull stop) {
        [productA enumerateObjectsUsingBlock:^(ShopCar_ProductModel *  _Nonnull productM, NSUInteger idx, BOOL * _Nonnull stop) {
            if (productM.isSelected) {
                [pkgPrdIdsArr addObject:productM.ID];
                [pkgPrdTypesArr addObject:@"0"];
                [countsArr addObject:[NSString stringWithFormat:@"%lu",productM.goodCount+1]];
                
            }
        }];
    }];
    
    
    if (pkgPrdIdsArr.count == 0) {
        HUD_TIP(@"请选择商品后再结算");
        return;
    }
    
    pkgPrdIds = [pkgPrdIdsArr componentsJoinedByString:@","];
    pkgPrdTypes = [pkgPrdTypesArr componentsJoinedByString:@","];
    counts = [countsArr componentsJoinedByString:@","];
    
   //提交订单接口
    [self saveOrderRequestWithPkgPrdIds:pkgPrdIds withPkgPrdTypes:pkgPrdTypes withCounts:counts];
}


#pragma mark ---- header ----
- (UIView *)creatHeaderWithText:(NSString *)text
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = CF6F6F6;
    
    [UILabel getLabelWithFont:F13 textColor:C000000 superView:headerView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.centerY.offset(0);
        
        view.text = text;
    }];
    
    return headerView;
}

#pragma mark -- tableView代理数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.productDataArr.count >0 && self.packAgeArr.count >0) {
        return section==0?self.packAgeArr.count:self.productArr.count;
    } else if (self.productDataArr.count ==0 && self.packAgeArr.count >0) {
        return self.packAgeArr.count;
    } else if (self.productDataArr.count >0 && self.packAgeArr.count ==0) {
        return self.productDataArr.count;
    } else {
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.productDataArr.count >0 && self.packAgeArr.count >0) {
        return 2;
    } else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.productDataArr.count >indexPath.row && self.packAgeArr.count >indexPath.row) {
        if (indexPath.section == 0) {
            ShopCarMainCell *cell = [ShopCarMainCell cellWithTableView:tableView];
            cell.CaluteMoneyHandler = ^{
                //计算金额
                [self getTaoCanPriceRequest];
            };
            cell.posRootViewM = self.packAgeArr[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            SingleShopCarMainCell *cell = [SingleShopCarMainCell cellWithTableView:tableView];
            cell.clickCaluteMoney = ^{
                //计算金额
                [self getTaoCanPriceRequest];
            };
            cell.dataArr = self.productDataArr[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (self.productDataArr.count ==0 && self.packAgeArr.count >indexPath.row) {
        ShopCarMainCell *cell = [ShopCarMainCell cellWithTableView:tableView];
        cell.CaluteMoneyHandler = ^{
            //计算金额
            [self getTaoCanPriceRequest];
        };
        cell.posRootViewM = self.packAgeArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (self.productDataArr.count >indexPath.row && self.packAgeArr.count ==0) {
        SingleShopCarMainCell *cell = [SingleShopCarMainCell cellWithTableView:tableView];
        cell.clickCaluteMoney = ^{
            //计算金额
            [self getTaoCanPriceRequest];
        };
        cell.dataArr = self.productDataArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCar_PackageModel *taoCanDetaiM;
    if (self.packAgeArr.count >indexPath.row ) {
        taoCanDetaiM = self.packAgeArr[indexPath.row];
    }
    NSArray *tmpProductArr;
    if (self.productDataArr.count  >indexPath.row) {
        tmpProductArr = [NSArray arrayWithArray:self.productDataArr[indexPath.row]];
    }
    if (self.productDataArr.count >indexPath.row && self.packAgeArr.count >indexPath.row) {
        return indexPath.section==0?(AD_HEIGHT(30)+AD_HEIGHT(46)+taoCanDetaiM.packageChargeItemDOList.count*AD_HEIGHT(60)+AD_HEIGHT(5)):(AD_HEIGHT(32)+AD_HEIGHT(60)*tmpProductArr.count+AD_HEIGHT(5));
    } else if (self.productDataArr.count ==0 && self.packAgeArr.count >indexPath.row) {
        return AD_HEIGHT(30)+AD_HEIGHT(46)+taoCanDetaiM.packageChargeItemDOList.count*AD_HEIGHT(60)+AD_HEIGHT(5);
    } else if (self.productDataArr.count >indexPath.row && self.packAgeArr.count ==0) {
        return AD_HEIGHT(32)+AD_HEIGHT(60)*tmpProductArr.count+AD_HEIGHT(5);
    } else {
        return 0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.productDataArr.count >0 && self.packAgeArr.count >0) {
        return section == 0?[self creatHeaderWithText:@"套餐"]:[self creatHeaderWithText:@"单点"];
    } else if (self.productDataArr.count ==0 && self.packAgeArr.count >0) {
        return [self creatHeaderWithText:@"套餐"];
    } else if (self.productDataArr.count >0 && self.packAgeArr.count ==0) {
        return [self creatHeaderWithText:@"单点"];
    } else {
        return [UIView new];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AD_HEIGHT(29);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}

//MARK:----------------------------------------接口
#pragma mark ---- 计算底部金额 ----
- (void)getTaoCanPriceRequest
{
    
    //遍历套餐数组
     NSString *pkgPrdIds = [NSString string];
     NSString *pkgPrdTypes= [NSString string];
     NSString *counts= [NSString string];
    
    __block NSMutableArray *pkgPrdIdsArr = [NSMutableArray array];
    __block NSMutableArray *pkgPrdTypesArr = [NSMutableArray array];
    __block NSMutableArray *countsArr = [NSMutableArray array];

    [self.packAgeArr enumerateObjectsUsingBlock:^(ShopCar_PackageModel *  _Nonnull packageM, NSUInteger idx, BOOL * _Nonnull stop) {
        if (packageM.isSelected) {
            [pkgPrdIdsArr addObject:packageM.ID];
            [pkgPrdTypesArr addObject:packageM.pkgPrdType];
            [countsArr addObject:[NSString stringWithFormat:@"%lu",packageM.goodCount+1]];
        }
    }];
    
    //遍历产品数组
    [self.productDataArr enumerateObjectsUsingBlock:^(NSArray * _Nonnull productA, NSUInteger idx, BOOL * _Nonnull stop) {
        [productA enumerateObjectsUsingBlock:^(ShopCar_ProductModel *  _Nonnull productM, NSUInteger idx, BOOL * _Nonnull stop) {
            if (productM.isSelected) {
                [pkgPrdIdsArr addObject:productM.ID];
                [pkgPrdTypesArr addObject:@"0"];
                [countsArr addObject:[NSString stringWithFormat:@"%lu",productM.goodCount+1]];

            }
        }];
    }];
    
    if (pkgPrdIdsArr.count == 0||pkgPrdTypesArr.count == 0||countsArr.count == 0) {
        self.allMoneyLabel.attributedText = [self setMoneyStr:@"合计：0元"];
        self.yunFeiLabel.attributedText = [self setDeliveryPriceStr:@"运费0元"];
    } else {
        HUD_NOBGSHOW;
        pkgPrdIds = [pkgPrdIdsArr componentsJoinedByString:@","];
        pkgPrdTypes = [pkgPrdTypesArr componentsJoinedByString:@","];
        counts = [countsArr componentsJoinedByString:@","];

        NSDictionary *dict = @{
                               @"userid":USER_ID_POS,
                               @"pkgPrdIds":IF_NULL_TO_STRING(pkgPrdIds),
                               @"pkgPrdTypes":IF_NULL_TO_STRING(pkgPrdTypes),
                               @"counts":IF_NULL_TO_STRING(counts),
                               @"operation":@"1"
                               };
        [[HPDConnect connect] PostNetRequestMethod:@"api/trans/cart/calculate" params:dict cookie:nil result:^(bool success, id result) {
            HUD_HIDE;
            if (success) {
                if ([result[@"code"]integerValue] == 0) {
                    if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                        self.allMoneyLabel.attributedText = [self setMoneyStr:[NSString stringWithFormat:@"合计：%@元",result[@"data"][@"totalPrice"]]];
                        self.yunFeiLabel.attributedText = [self setDeliveryPriceStr:[NSString stringWithFormat:@"运费%@元",result[@"data"][@"deliveryPrice"]]];
                        
                    }
                }else{
                    [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                        
                    }];
                }
                
                
            }
            NSLog(@"result ------- %@", result);
        }];
    }
    
}
//设置富文本金额
- (NSMutableAttributedString *)setMoneyStr:(NSString *)str
{
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:str];
    [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0, 3)];
    [attstr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(3, str.length - 3)];
    return attstr;
}
//设置富文本运费
- (NSMutableAttributedString *)setDeliveryPriceStr:(NSString *)str
{
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc]initWithString:str];
    [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(0, 2)];
    [attstr addAttribute:NSForegroundColorAttributeName value:C000000 range:NSMakeRange(2, str.length - 3)];
    [attstr addAttribute:NSForegroundColorAttributeName value:CF52542 range:NSMakeRange(str.length - 1, 1)];
    return attstr;
}
#pragma mark ---- 查询购物车获取对应id ----
- (void)getShopCarRequest
{
    HUD_NOBGSHOWTOUCH;
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/cart/list" params:@{@"userid":USER_ID_POS} cookie:nil result:^(bool success, id result) {
        if (success) {
            
            if ([result[@"code"]integerValue] == 0) {
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = result[@"data"][@"rows"];
                        if (arr.count == 0) {
                            HUD_HIDE;
                        }
                        NSArray *tmpArr = [NSArray arrayWithArray:[ShopCarModel mj_objectArrayWithKeyValuesArray:arr]];
                        [self fenleiWithId:tmpArr];
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

#pragma mark ---- 将id分类 ----
- (void)fenleiWithId:(NSArray *)idArr
{
    [idArr enumerateObjectsUsingBlock:^(ShopCarModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.pkgPrdType isEqualToString:@"0"]) {
            //产品
            [self.danDianArr addObject:obj.ID];
        } else if ([obj.pkgPrdType isEqualToString:@"1"]) {
            //收费套餐
            [self.noFreeTaoCanArr addObject:obj.pkgPrdId];
        } else if ([obj.pkgPrdType isEqualToString:@"2"]) {
            //免费套餐
            [self.freeTaoCanArr addObject:obj.pkgPrdId];
        }
    }];
    
    
    //根据id获取产品详情
    [self.danDianArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self getProductDetailRequest:obj];
    }];
    
    //根据id获取收费套餐详情
    [self.noFreeTaoCanArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self getNoFreePackageDetailRequest:obj];
    }];
    
    //根据id获取免费套餐详情
    [self.freeTaoCanArr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self getFreePackageDetailRequest:obj];
    }];
}

#pragma mark ---- 获取产品详情 ----
- (void)getProductDetailRequest:(NSString *)productId
{
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"api/trans/product/get/%@",productId] params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                [self.productArr addObject:[ShopCar_ProductModel mj_objectWithKeyValues:result[@"data"]]];
                self.productArrCount ++;

                if (self.productArrCount == self.danDianArr.count) {
                    [self getProductDataArr];//获取单点产品数据源
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

#pragma mark ---- 获取单点产品数据源 ----
- (void)getProductDataArr
{
    
    for (int i = 0; i < self.productArr.count; i ++) {
        
        ShopCar_ProductModel *productM1 = self.productArr[i];
        NSString *string = productM1.posBrandName;
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [tempArray addObject:productM1];
        
        for (int j = i+1; j < self.productArr.count; j ++) {
            
            ShopCar_ProductModel *productM2 = self.productArr[i];
            NSString *jstring = productM2.posBrandName;
            
            if([string isEqualToString:jstring]){
                
                [tempArray addObject:productM1];
                
                [self.productArr removeObjectAtIndex:j];
                j -= 1;
                
            }
            
        }
        
        [self.productDataArr addObject:tempArray];
        
    }
    
    HUD_HIDE;
    [self.myTableView reloadData];
    
}


#pragma mark ---- 获取收费套餐详情 ----
- (void)getNoFreePackageDetailRequest:(NSString *)productId
{
    
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"api/trans/packageCharge/get/%@",productId] params:nil cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                ShopCar_PackageModel *model = [ShopCar_PackageModel mj_objectWithKeyValues:result[@"data"]];
                model.pkgPrdType = @"1";
                [self.packAgeArr addObject:model];
                self.noFreePackageArrCount ++;
                if (self.noFreePackageArrCount == self.noFreeTaoCanArr.count) {
                    //刷新数据源
                    [self.myTableView reloadData];

                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

#pragma mark ---- 获取套餐详情 ----
- (void)getFreePackageDetailRequest:(NSString *)productId
{
    [[HPDConnect connect] PostNetRequestMethod:[NSString stringWithFormat:@"api/trans/packageFree/get/%@",productId] params:nil cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                ShopCar_PackageModel *model = [ShopCar_PackageModel mj_objectWithKeyValues:result[@"data"]];
                model.pkgPrdType = @"2";
                [self.packAgeArr addObject:model];
                self.freePackageArrCount ++;
                if (self.freePackageArrCount == self.freeTaoCanArr.count) {
                    //刷新数据源
                    [self.myTableView reloadData];
                    
                }
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}


#pragma mark ---- 提交订单 ----
- (void)saveOrderRequestWithPkgPrdIds:(NSString *)pkgPrdIds  withPkgPrdTypes:(NSString *)pkgPrdTypes withCounts:(NSString *)counts
{
    NSDictionary *dict = @{
                           @"userid":USER_ID_POS,
                           @"pkgPrdIds":IF_NULL_TO_STRING(pkgPrdIds),
                           @"pkgPrdTypes":IF_NULL_TO_STRING(pkgPrdTypes),
                           @"counts":IF_NULL_TO_STRING(counts),
                           @"operation":@"1"
                           };
    HUD_NOBGSHOW;
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/order/save" params:dict cookie:nil result:^(bool success, id result) {
        HUD_HIDE;
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                POS_CommitBillViewController *vc = [[POS_CommitBillViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.orderId = [NSString stringWithFormat:@"%@",result[@"data"]];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
