//
//  ImageGeneralizeViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/9.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "ImageGeneralizeViewController.h"
#import "ImageGeneralizeCollectionViewCell.h"

@interface ImageGeneralizeViewController ()  <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *myCollection;
@end

@implementation ImageGeneralizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"推广";
    self.view.backgroundColor = WhiteColor;
    [self createCollectionView];
}

#pragma maek --- 创建collectionView
-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _myCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(AD_HEIGHT(15), 0, ScreenWidth - AD_HEIGHT(30), ScreenHeight) collectionViewLayout:layout];
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
//    cell.titleLabel.text = _titleBottomArr[indexPath.row];
//    cell.iconImg.image = [UIImage imageNamed:_imageBottomArr[indexPath.row]];
    
    return cell;
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ScreenWidth/2 - AD_HEIGHT(30), FITiPhone6(184));
    
    
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, FITiPhone6(5), 0);
//}
//设置每个item垂直间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return FITiPhone6(0);
  
}
//设置每个item水平间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.01f;

}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    AccountCollectionCell *cell = (AccountCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *msg = cell.titleLabel.text;
    //    FMLog(@"%@",msg);
    
    
}



@end
