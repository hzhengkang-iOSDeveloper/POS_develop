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
#import "ShareTextModel.h"
#import "SGActionView.h"

#import <WXApi.h>

@interface CopywritingSelectViewController () <UITableViewDataSource, UITableViewDelegate> {
    enum WXScene _scene;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy) NSString *pasteStr;//复制的文字，用于转发时
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CopywritingSelectViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItemTitle = @"文案选择";
    MJWeakSelf;
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"分享"] clickHandler:^{
        
        if ([weakSelf.pasteStr isEqualToString:@""] || weakSelf.pasteStr == nil) {
            HUD_TIP(@"请复制文案再分享!");
            return;
        }
        NSArray *arr = @[ @"微信好友",@"朋友圈"];
        NSArray *imageArr = @[[UIImage imageNamed:@"微信"],[UIImage imageNamed:@"朋友圈"]];
        
        [SGActionView showGridMenuWithTitle:@"分享到"
                                 itemTitles:arr
                                     images:imageArr
                             selectedHandle:^(NSInteger index) {
                                 [weakSelf selectedWithIndex:index];
                             }];
        
//        ShareFailViewController *vc = [[ShareFailViewController alloc] init];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    self.dataArray = [NSMutableArray array];
    [self createTableView];
    [self loadShareTextListRequest];
}
- (void)selectedWithIndex:(NSInteger)index
{
    if (index == 1){
        //微信好友
        _scene = WXSceneSession;
        [self sendLinkContent];
    }else if (index == 2){
        //微信朋友圈
        _scene = WXSceneTimeline;
        [self sendLinkContent];
    }
}
#pragma mark -- wxApi method
- (void) sendLinkContent
{
    if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi])
    {
        [UIAlertView showAlertViewWithTitle:@"提示" message:@"您未安装微信客户端" cancelButtonTitle:@"确定" otherButtonTitles:nil onDismiss:^(NSInteger buttonIndex) {
            
        } onCancel:^{
            
        }];
        
        return;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
//    message.title = _shareTitle;
    message.description = self.pasteStr;
    [message setThumbImage:self.shareImgV.image];
    WXWebpageObject *ext = [WXWebpageObject object];
//    ext.webpageUrl = _shareUrl;
    message.mediaObject = ext;
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    [WXApi sendReq:req];
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
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CopywritingSelectCell *cell = [CopywritingSelectCell cellWithTableView:tableView];
    ShareTextModel *model = self.dataArray[indexPath.section];
    cell.contentLabel.text = model.shareContent;
    
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



#pragma mark ---- 接口 ----
- (void)loadShareTextListRequest {
    [[HPDConnect connect] PostNetRequestMethod:@"api/trans/shareText/list" params:nil cookie:nil result:^(bool success, id result) {
        if (success) {
            if ([result[@"data"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"data"][@"rows"] isKindOfClass:[NSArray class]]) {
                    NSDictionary *array = result[@"data"][@"rows"];
                    self.dataArray = [NSMutableArray arrayWithArray:[ShareTextModel mj_objectArrayWithKeyValuesArray:array]];
                    
                    [self.myTableView reloadData];
                }
                
            }
            
        }
        NSLog(@"result ------- %@", result);
    }];
}
@end
