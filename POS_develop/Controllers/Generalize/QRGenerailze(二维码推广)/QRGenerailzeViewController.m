//
//  QRGenerailzeViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "QRGenerailzeViewController.h"
#import "CopywritingSelectViewController.h"
#import "ImageGeneralizeCollectionViewCell.h"

@interface QRGenerailzeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *myCollection;
@property (nonatomic, copy) NSString *selectStr;

@end

@implementation QRGenerailzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"推广";
    self.view.backgroundColor = WhiteColor;
    self.selectStr = @"";
    [self addStandardRightButtonWithTitle:@"下一步" selector:@selector(nextClick)];
    [self createCollectionView];
}

#pragma mark ---- 下一步 ----
- (void)nextClick {
    CopywritingSelectViewController *vc = [[CopywritingSelectViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma maek --- 创建collectionView
-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _myCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabbarHeight) collectionViewLayout:layout];
    _myCollection.backgroundColor = CF6F6F6;
    [self.view addSubview:_myCollection];
    
    [_myCollection registerClass:[ImageGeneralizeCollectionViewCell class] forCellWithReuseIdentifier:@"ImageGeneralizeCollectionViewCell"];
    
    _myCollection.delegate = self;
    _myCollection.dataSource = self;
    
    
}
#pragma mark -- UICollectionView Delegate  DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 16;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ImageGeneralizeCollectionViewCell *cell = (ImageGeneralizeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageGeneralizeCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = WhiteColor;
    [cell.selectBtn setTitle:@"07月24日 09：11" forState:UIControlStateNormal];
    cell.myImageView.image = [UIImage imageNamed:@"图层7"];
    
    if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        cell.selectBtn.selected = YES;
    } else {
        cell.selectBtn.selected = NO;
    }
    
    return cell;
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ScreenWidth/2 - 0.01, FITiPhone6(184));
    
    
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, FITiPhone6(5), 0);
//}
//设置每个item垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return FITiPhone6(5);
    
}
//设置每个item水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.01f;
    
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageGeneralizeCollectionViewCell * cell = (ImageGeneralizeCollectionViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.selectBtn.selected = !cell.selectBtn.selected;
    if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        self.selectStr = @"";
    } else {
        self.selectStr = [NSString stringWithFormat:@"%li",indexPath.row];
    }
    
    [_myCollection reloadData];
    
}


@end
