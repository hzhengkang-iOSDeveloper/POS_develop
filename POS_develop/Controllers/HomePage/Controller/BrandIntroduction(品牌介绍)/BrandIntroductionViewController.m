//
//  BrandIntroductionViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BrandIntroductionViewController.h"
#import "BrandIntroductionCell.h"
#import "BrandIntroductionModel.h"

@interface BrandIntroductionViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BrandIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"品牌介绍";
    self.dataArray = [NSMutableArray array];
    [self createTableView];
    [self loadPosBrandListRequest];
}
- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.backgroundColor = WhiteColor;
    _myTableView.estimatedRowHeight = 300;//估算高度
    _myTableView.rowHeight = UITableViewAutomaticDimension;
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
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrandIntroductionCell *cell = [BrandIntroductionCell cellWithTableView:tableView];
    BrandIntroductionModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.posBrandName;
    cell.contentLabel.text = model.posBrandDesc;
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:model.posBrandPic]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
  
    
}

#pragma mark ---- 接口 ----
- (void)loadPosBrandListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/posBrand/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSArray *array = result[@"data"][@"rows"];
                    if (array.count > 0) {
                        [self.dataArray addObjectsFromArray:[BrandIntroductionModel mj_objectArrayWithKeyValuesArray:array]];
                        
                        [self.myTableView reloadData];
                    }
                    
                }
                
            }
            
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}

@end
