//
//  DelegateManagerEditViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "DelegateManagerEditViewController.h"
#import "DelegateManagerEditCell.h"

@interface DelegateManagerEditViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation DelegateManagerEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItemTitle = @"代理商管理";

    [self addStandardRightButtonWithTitle:@"保存" selector:@selector(saveBtnClick)];
    [self createTableView];
    
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
#pragma mark ---- 保存 ----
- (void)saveBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DelegateManagerEditCell *cell = [DelegateManagerEditCell cellWithTableView:tableView];

    switch (indexPath.row) {
        case 0:{
            cell.titleLabel.text = @"代理商名称";
            cell.contentTF.placeholder = @"请输入代理商名称";
        }
            break;
        case 1:{
            cell.titleLabel.text = @"代理商账号";
            cell.contentTF.placeholder = @"请输入代理商账号";
        }
            break;
        case 2:{
            cell.titleLabel.text = @"代理商vip等级";
            cell.contentTF.placeholder = @"请输入代理商vip等级";
        }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(50);
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
