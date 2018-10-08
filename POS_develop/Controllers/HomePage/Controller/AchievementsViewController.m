//
//  AchievementsViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/9/22.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "AchievementsViewController.h"
#import "AchievementsTopCollectionViewCell.h"
#import "AchievementsBottomCollectionViewCell.h"
#import "TransactionQueryViewController.h"
#import "SeparateQueryViewController.h"
#import "ActivationMoneyViewController.h"
#import "TerminalBindViewController.h"//终端绑定
#import "TerminalSelectViewController.h"//终端查询
#import "TerminalAdminViewController.h"//终端管理
#import "DelegateManagerViewController.h"//代理商管理

@interface AchievementsViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *myTopCollection;
@property (nonatomic, strong) UICollectionView *myBottomCollection;
@property (nonatomic, strong) NSArray *titleTopArr;
@property (nonatomic, strong) NSArray *explainTopArr;
@property (nonatomic, strong) NSArray *titleBottomArr;
@property (nonatomic, strong) NSArray *imageBottomArr;
@end

@implementation AchievementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self createCollectionView];
    _titleTopArr = @[@"日交易量", @"日分润", @"激活数量", @"激活奖励", @"商品数量", @"其他奖励"];
    _explainTopArr = @[@"200.00", @"200.00", @"200.00", @"200.00", @"200.00", @"200.00"];
    _titleBottomArr = @[@"交易查询", @"统计分析", @"分润查询", @"激活返现查询", @"终端绑定", @"终端查询", @"终端管理", @"代理商管理"];
    _imageBottomArr = @[@"交易查询", @"统计分析", @"分润查询", @"激活", @"终端绑定", @"图层17", @"终端管理", @"代理商管理"];

}
- (void)initUI {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(FITiPhone6(15), 0, ScreenWidth, FITiPhone6(43))];
    label.text = @"昨日新增";
    label.textColor = C000000;
    label.font = F15;
    [self.view addSubview:label];
}
#pragma maek --- 创建collectionView
-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _myTopCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, FITiPhone6(43), ScreenWidth, ScreenHeight - FITiPhone6(43)) collectionViewLayout:layout];
    _myTopCollection.backgroundColor = CF6F6F6;
    [self.view addSubview:_myTopCollection];
    
    [_myTopCollection registerClass:[AchievementsTopCollectionViewCell class] forCellWithReuseIdentifier:@"AchievementsTopCollectionViewCell"];
    [_myTopCollection registerClass:[AchievementsBottomCollectionViewCell class] forCellWithReuseIdentifier:@"AchievementsBottomCollectionViewCell"];
    
    _myTopCollection.delegate = self;
    _myTopCollection.dataSource = self;
    
    
}
#pragma mark -- UICollectionView Delegate  DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 6;
    }else {
        return 8;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        AchievementsTopCollectionViewCell *cell = (AchievementsTopCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AchievementsTopCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = WhiteColor;
        cell.titleLabel.text = _titleTopArr[indexPath.row];
        cell.explainLabel.text = _explainTopArr[indexPath.row];
        
        return cell;
    }else {
        AchievementsBottomCollectionViewCell *cell = (AchievementsBottomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AchievementsBottomCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = WhiteColor;
        cell.titleLabel.text = _titleBottomArr[indexPath.row];
        cell.iconImg.image = [UIImage imageNamed:_imageBottomArr[indexPath.row]];
        
        return cell;
    }
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(FITiPhone6(187.25), FITiPhone6(65));
    }else {
        return CGSizeMake(FITiPhone6(93.75), FITiPhone6(106));
    }
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, FITiPhone6(5), 0);
}
//设置每个item垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return FITiPhone6(0.5);
    }else {
        return 0;
    }
}
//设置每个item水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return FITiPhone6(0.5);
    }else {
        return 0;
    }
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    AccountCollectionCell *cell = (AccountCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *msg = cell.titleLabel.text;
    //    FMLog(@"%@",msg);
    if (indexPath.section == 0) {
        
    }else {
        switch (indexPath.row) {
            case 0:{
                TransactionQueryViewController *vc = [[TransactionQueryViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{
                
            }
                break;
            case 2:{
                SeparateQueryViewController *vc = [[SeparateQueryViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:{
                ActivationMoneyViewController *vc = [[ActivationMoneyViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:{
                TerminalBindViewController *vc = [[TerminalBindViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:{
                TerminalSelectViewController *vc = [[TerminalSelectViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 6:{
                TerminalAdminViewController *vc = [[TerminalAdminViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 7:{
                DelegateManagerViewController *vc = [[DelegateManagerViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }
}


@end
