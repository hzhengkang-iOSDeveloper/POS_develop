//
//  CopywritingSelectViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "CopywritingSelectViewController.h"
#import "CopywritingSelectCell.h"
#import "ShareSuccessViewController.h"
#import "ShareFailViewController.h"
@interface CopywritingSelectViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy) NSString *pasteStr;//复制的文字，用于转发时
@end

@implementation CopywritingSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"文案选择";
    MJWeakSelf;
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"分享"] clickHandler:^{
        ShareFailViewController *vc = [[ShareFailViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    [self createTableView];
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
    
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CopywritingSelectCell *cell = [CopywritingSelectCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.contentLabel.text = @"卡接口是你打开那等你家厚度uayduyaioa";
    }else if (indexPath.section == 2) {
        cell.contentLabel.text = @"ahsdjahkdnandkidj爱好的四海的回忆啊好看大砍刀卡的复活爱的还是覅和爱的很舒服ad俺的沙发阿ahsdjahkdnandkidj爱好的四海的回忆啊好看大砍刀卡的复活爱的还是覅和爱的很舒服ad俺的沙发阿道夫ad啊ahsdjahkdnandkidj爱好的四海的回忆啊好看大砍刀卡的复活爱的还是覅和爱的很舒服ad俺的沙发阿道夫ad啊ahsdjahkdnandkidj爱好的四海的回忆啊好看大砍刀卡的复活爱的还是覅和爱的很舒服ad俺的沙发阿道夫ad啊ahsdjahkdnandkidj爱好的四海的回忆啊好看大砍刀卡的复活爱的还是覅和爱的很舒服ad俺的沙发阿道夫ad啊ahsdjahkdnandkidj爱好的四海的回忆啊好看大砍刀卡的复活爱的还是覅和爱的很舒服ad俺的沙发阿道夫ad啊道夫ad啊";
    }else {
        cell.contentLabel.text = @"ahsdjahkdnandki夫ad啊ahsdjahkdnandkidj爱好的四海的回忆啊好看大砍刀卡的复活爱的还是覅和爱的很舒服ad俺的沙发阿道夫ad啊ahsdjahkdnandkidj爱好的四海的回忆啊好";
    }
    __weak typeof(cell)weakCell = cell;
    cell.copyClick = ^{
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = weakCell.contentLabel.text;
        self.pasteStr = pasteboard.string;
    };

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MessageListViewController *vc = [[MessageListViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return AD_HEIGHT(60);
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return AD_HEIGHT(5);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AD_HEIGHT(5))];
    footerView.backgroundColor = RGB(242, 242, 246);
    return footerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    return headerView;
}
@end
