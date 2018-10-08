//
//  BrandIntroductionViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "BrandIntroductionViewController.h"
#import "BrandIntroductionCell.h"

@interface BrandIntroductionViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation BrandIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItemTitle = @"品牌介绍";
    [self createTableView];
}
- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.backgroundColor = WhiteColor;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrandIntroductionCell *cell = [BrandIntroductionCell cellWithTableView:tableView];
    cell.titleLabel.text = @"创业包（刷999）";
    cell.contentLabel.text = @"看我阿his单号if八九那打开那肯定是阿斯蒂芬卡打开啊看到你就发报价的比较安静爸妈把对面吧唧吧唧安静的骄傲没收到吗帮忙多少年， ，是的，啊你看电视那分开好的机会嘉宾都发麻打慢点吗打快点加咖啡就打款哈记得将被没收没法卡看到好看呐，发啊";
    

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BrandIntroductionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    return [cell getCellHeight];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
