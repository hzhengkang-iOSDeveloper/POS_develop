//
//  DelegateManagerEditViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "DelegateManagerEditViewController.h"
#import "DelegateManagerEditCell.h"
#import "VipSystemViewController.h"
#import "AgentListModel.h"
@interface DelegateManagerEditViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy) NSString *agentName;
@property (nonatomic, copy) NSString *agentNo;
@property (nonatomic, copy) NSString *sbLevel;
@property (nonatomic, copy) NSString *sbLevelVip;

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
    [self loadAgentUpdateRequest];
    
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
            cell.myImageView.hidden = YES;
            cell.titleLabel.text = @"代理商名称";
            cell.contentTF.text = self.model.agentName;
            cell.contentTF.enabled = NO;
        }
            break;
        case 1:{
            cell.myImageView.hidden = YES;
            cell.titleLabel.text = @"代理商账号";
            cell.contentTF.text = self.model.agentNo;
            cell.contentTF.enabled = NO;
        }
            break;
        case 2:{
            cell.myImageView.hidden = NO;
            cell.vipGradeBtn.hidden = NO;
            [cell.vipGradeBtn setTitle:self.model.sbLevelVip forState:UIControlStateNormal];
            cell.titleLabel.text = @"代理商vip等级";
            cell.contentTF.text = self.model.sbLevel;
            cell.contentTF.placeholder = @"请输入代理商vip等级";
        }
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        VipSystemViewController *vc = [[VipSystemViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(50);
}

#pragma mark ------------------------------------ 接口 ------------------------------------



#pragma mark ---- 保存 ----
- (void)loadAgentUpdateRequest {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    DelegateManagerEditCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/agent/update" params:@{@"sbLevel":cell.contentTF.text, @"id":self.model.ID} cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"code"]integerValue] == 0) {
                HUD_TIP(@"保存成功");
                if (self.popBlock) {
                    self.popBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [GlobalMethod FromUintAPIResult:result withVC:self errorBlcok:^(NSDictionary *dict) {
                    
                }];
            }
            
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end



