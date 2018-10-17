//
//  HtmlGenerailzeViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "HtmlGenerailzeViewController.h"
#import "HtmlGenerailzeCell.h"
#import "HtmlGenerailzeDetailViewController.h"
#import "CopywritingSelectViewController.h"
#import "ShareH5ListModel.h"

@interface HtmlGenerailzeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy) NSString *selectStr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HtmlGenerailzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"html5推广";
    self.dataArray = [NSMutableArray array];
    [self addStandardRightButtonWithTitle:@"下一步" selector:@selector(nextClick)];
    self.selectStr = @"";
    [self createTableView];
    [self loadShareH5ListRequest];
}
#pragma mark ---- 下一步 ----
- (void)nextClick {
    CopywritingSelectViewController *vc = [[CopywritingSelectViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.backgroundColor = WhiteColor;
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
    HtmlGenerailzeCell *cell = [HtmlGenerailzeCell cellWithTableView:tableView];
    ShareH5ListModel *model = self.dataArray[indexPath.row];
    cell.contentLabel.text = model.shareContent;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.sharePic]];
    __weak typeof(cell) weakCell = cell;
    
    cell.seeDetailBlock = ^{
        HtmlGenerailzeDetailViewController *vc = [[HtmlGenerailzeDetailViewController alloc] init];
        vc.contentStr = weakCell.contentLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        cell.selectBtn.selected = YES;
    } else {
        cell.selectBtn.selected = NO;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HtmlGenerailzeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.selected = !cell.selectBtn.selected;
    if ([self.selectStr isEqualToString:[NSString stringWithFormat:@"%li",indexPath.row]]) {
        self.selectStr = @"";
    } else {
        self.selectStr = [NSString stringWithFormat:@"%li",indexPath.row];
    }
    
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(71);
}


#pragma mark ---- 接口 ----
- (void)loadShareH5ListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"shareH5/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSDictionary *array = result[@"data"][@"rows"];
                    self.dataArray = [NSMutableArray arrayWithArray:[ShareH5ListModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.myTableView reloadData];
                }
                
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
