//
//  CommunityWebViewController.m
//  WebView
//
//  Created by HePanDai on 15/7/8.
//  Copyright (c) 2015年 heramerom. All rights reserved.
//

#import "CommunityWebViewController.h"
#import "PopView.h"
#import "WebViewAction.h"
#import "WYWebProgressLayer.h"
#import "UIView+Frame.h"

@interface CommunityWebViewController ()<UIWebViewDelegate>
{
    UIWebView* _CommunityWebView;
    NSInteger _statusCode;
    WYWebProgressLayer *_progressLayer; ///< 网页加载进度条
}
@end

@implementation CommunityWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self CreateGUI];

}

-(void)CreateGUI
{
    _CommunityWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height-64)];
    _CommunityWebView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[GlobalMethod StrTohtml5With:_CommunityUrl]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    [self.view addSubview:_CommunityWebView];
    [_CommunityWebView loadRequest:request];
    _progressLayer = [WYWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, 42, SCREEN_WIDTH, 2);
    
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
}

#pragma mark JS交互
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSHTTPURLResponse *response = nil;
    
    __unused  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    _statusCode = response.statusCode;
    
    NSString *requestString = [[request URL] absoluteString];//获取请求的绝对路径.
    NSArray *components = [requestString componentsSeparatedByString:@":"];//提交请求时候分割参数的分隔符
    if ([components count] <= 1) {return NO;}
    if ([(NSString *)[components objectAtIndex:0] isEqualToString:@"callapp"]) {
        
        WebViewAction *AC = [WebViewAction getInstance];
        [AC respondVC:self actionKey:requestString];
        
        return NO;
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:nil];
    }
    
    return YES;
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [_progressLayer startLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressLayer finishedLoad];
    NSString *js = [NSString stringWithFormat:@"CheckPageIsHasTitleBarShare();"];
    [webView stringByEvaluatingJavaScriptFromString:js];
    if (_statusCode == 403 | _statusCode == 404) {
        [self performSelector:@selector(back) withObject:nil afterDelay:2.0f];
    }
    
}
- (void)back
{
    self.tabBarController.selectedIndex = 0;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (void)dealloc {
    
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    NSLog(@"i am dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
