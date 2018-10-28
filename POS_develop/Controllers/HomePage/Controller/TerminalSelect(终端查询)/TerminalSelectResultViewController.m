//
//  TerminalSelectResultViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/7.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "TerminalSelectResultViewController.h"
#import "TerminalBindTableViewCell.h"
#import "PosListModel.h"
#import "AgentPosListModel.h"
@interface TerminalSelectResultViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *terminalResultTableView;

@end

@implementation TerminalSelectResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"终端查询";
    
    [self createTableView];
    
}


- (void)createTableView {
    _terminalResultTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _terminalResultTableView.backgroundColor = CF6F6F6;
    _terminalResultTableView.delegate = self;
    _terminalResultTableView.dataSource = self;
    _terminalResultTableView.showsVerticalScrollIndicator = NO;
    _terminalResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_terminalResultTableView];
    [_terminalResultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    TerminalBindTableViewCell *cell = [TerminalBindTableViewCell cellWithTableView:tableView];
    PosListModel *model = self.dataArray[indexPath.row];
    cell.productNameL.text = model.posBrandName;
    cell.viceProductNameL.text = model.posTermType;
    cell.snL.text = [NSString stringWithFormat:@"SN:%@", model.posSnNo];
    cell.modelL.text = [NSString stringWithFormat:@"型号%@", model.posTermModel];
    AgentPosListModel *bindModel = self.bindDataArray[indexPath.row];
    if ([bindModel.bindFlag isEqualToString:@"1"]) {
        cell.bindStateL.text = @"已绑定";
        cell.bindStateL.textColor = C989898;
    }else {
        cell.bindStateL.text = @"未绑定";
        cell.bindStateL.textColor = RGB(245, 53, 53);
    }
    cell.bindStateL.hidden = NO;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AD_HEIGHT(62);
}



@end
