//
//  SLGoodDetailImageDetailView.m
//  Shopping2.0
//
//  Created by chenpeng on 2017/12/5.
//  Copyright © 2017年 HongHui(Shanghai)Information Technology Service Co.,Ltd. All rights reserved.
//

#import "SLGoodDetailImageDetailView.h"
#import <WebKit/WebKit.h>

@interface SLGoodDetailImageDetailView ()<WKNavigationDelegate>

@property (nonatomic, weak) WKWebView *webView;

@end

@implementation SLGoodDetailImageDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        
        
        WKWebView *webView = [WKWebView new];
        webView.scrollView.bounces = NO;
        webView.scrollView.scrollEnabled = NO;
        webView.navigationDelegate = self;
        webView.backgroundColor = WhiteColor;
        //使网页透明
        [webView setOpaque:NO];
        [self addSubview: webView];
        self.webView = webView;

        
        MJWeakSelf;
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf);
            make.bottom.left.right.mas_equalTo(weakSelf);
        }];
    }
    return self;
}


- (void)setWebViewURL:(NSString *)webViewURL {
    if (webViewURL) {
        _webViewURL = webViewURL;
        if ([webViewURL isKindOfClass:[NSString class]] && webViewURL.length>0) {
            NSString *detailsURLStr = [webViewURL stringByReplacingOccurrencesOfString:@"<img" withString:@"<img style='display: block; max-width: 100%;'"];
            NSString *baseURL = [NSString stringWithFormat:@"<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/><meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;\" name=\"viewport\" /><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"><meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\"><link rel=\"stylesheet\" type=\"text/css\" /><style type=\"text/css\"> .color{color:#576b95;}</style></head><body style='margin:0;padding:0;'><div id=\"content\">%@</div>",detailsURLStr];
            [self.webView loadHTMLString:baseURL baseURL:nil];
        }
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.getElementById('content').offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        CGFloat documentHeight = [result floatValue]+70;
        if ([self.delegate respondsToSelector:@selector(SLGoodDetailImageDetailViewChangeViewHeight:)]) {
            [self.delegate SLGoodDetailImageDetailViewChangeViewHeight:documentHeight];
        }
    }];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id _Nullable x, NSError * _Nullable error) {
    }];
}



@end
