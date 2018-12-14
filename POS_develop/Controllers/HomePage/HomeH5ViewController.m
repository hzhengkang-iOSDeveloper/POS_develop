//
//  HomeH5ViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/12/14.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "HomeH5ViewController.h"
#import <WebKit/WebKit.h>
@interface HomeH5ViewController ()<WKNavigationDelegate,UIGestureRecognizerDelegate>
//web
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIImageView *shadowImage;
//进度条
@property (nonatomic, weak) UIView *webViewProgress;

@end

@implementation HomeH5ViewController
//获取导航栏下方的shadowImage
- (UIImageView *)getNavigationShadowImage
{
    NSArray *subViews = [self getResultArr:self.navigationController.navigationBar];
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height<1){
            //实践后发现系统的横线高度为0.333
            return  (UIImageView *)view;
        }
    }
    
    return [UIImageView new];
}
- (NSArray *)getResultArr:(UIView *)aView
{
    NSArray *results = [aView subviews];
    for (UIView *eachView in aView.subviews)
    {
        NSArray *subviews = [self getResultArr:eachView];
        if (subviews)
            results = [results arrayByAddingObjectsFromArray:subviews];
    }
    return results;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //去除shadowImage
    self.shadowImage = [self getNavigationShadowImage];
    self.shadowImage.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.shadowImage.hidden = NO;
    //    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
    //        [self backAction];
    //    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatWebView];
    // 加载进度条
    [self setupProgress];
}

- (void)creatWebView
{
    //webView
    self.webView = [[WKWebView alloc]init];
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlLinkStr]]];
    //    [self.webView setOpaque:NO];
    for (UIView *aView in [self.webView subviews]) {
        if ([aView isKindOfClass:[UIScrollView class]]) {
            //右侧的滚动条
            [(UIScrollView *)aView setShowsVerticalScrollIndicator:NO];
            //下侧的滚动条
            [(UIScrollView *)aView setShowsHorizontalScrollIndicator:NO];
        }
    }
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(0);
    }];
    
    // 屏蔽UIWebView长按复制
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
    longPress.delegate = self;
    longPress.minimumPressDuration = 0.4;
    [self.webView addGestureRecognizer:longPress];
}

#pragma mark -- 加载进度条
- (void)setupProgress{
    UIView *webViewProgress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 2)];
    webViewProgress.backgroundColor = [UIColor colorWithHexString:@"#4B8EFF"];
    self.webViewProgress = webViewProgress;
    [self.view addSubview:webViewProgress];
    
    [UIView animateWithDuration:10.0 animations:^{
        webViewProgress.width = kScreenWidth*.8;
    }];
}


#pragma mark - GestureRecognizerDelegate (屏蔽UIWebView长按复制)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    MJWeakSelf;
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.webViewProgress.width = kScreenWidth;
    } completion:^(BOOL finished) {
        weakSelf.webViewProgress.hidden = YES;
    }];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //如果是跳转一个新页面
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
