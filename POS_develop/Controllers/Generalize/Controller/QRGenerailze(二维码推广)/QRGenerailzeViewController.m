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
#import "SharePicListModel.h"

@interface QRGenerailzeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *myCollection;
@property (nonatomic, copy) NSString *selectStr;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation QRGenerailzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"推广";
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = WhiteColor;
    self.selectStr = @"";
    [self addStandardRightButtonWithTitle:@"下一步" selector:@selector(nextClick)];
    [self createCollectionView];
    [self loadShareQrcoeListRequest];
}

#pragma mark ---- 下一步 ----
- (void)nextClick {
    if ([self.selectStr isEqualToString:@""]) {
        HUD_TIP(@"请选择");
        return;
    }
    NSIndexPath *path=[NSIndexPath indexPathForRow:[self.selectStr integerValue] inSection:0];
    SharePicListModel *model = self.dataArray[path.row];

    ImageGeneralizeCollectionViewCell *cell = (ImageGeneralizeCollectionViewCell *)[_myCollection cellForItemAtIndexPath:path];
    CopywritingSelectViewController *vc = [[CopywritingSelectViewController alloc] init];
    vc.shareImgV =  cell.myImageView;
    vc.shareTitle = model.shareTitle;
    vc.isPic = YES;
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
    
    return self.dataArray.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ImageGeneralizeCollectionViewCell *cell = (ImageGeneralizeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageGeneralizeCollectionViewCell" forIndexPath:indexPath];
    SharePicListModel *model = self.dataArray[indexPath.row];
    cell.backgroundColor = WhiteColor;
    [cell.selectBtn setTitle:[model.createtime substringToIndex:16] forState:UIControlStateNormal];
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:model.sharePic]];
    
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


#pragma mark ---- 接口 ----
- (void)loadShareQrcoeListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/shareQrcoe/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                
                if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                        NSDictionary *array = result[@"data"][@"rows"];
                        self.dataArray = [NSMutableArray arrayWithArray:[SharePicListModel mj_objectArrayWithKeyValuesArray:array]];
                        
                        [self.myCollection reloadData];
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
