//
//  WebViewAction.h
//  SCWebViewControllerDemo
//
//  Created by hpjr on 2016/12/6.
//  Copyright © 2016年 sands. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSONKit.h"
//#import "WebViewShareModel.h"
@interface WebViewAction : NSObject

@property (nonatomic, strong) LoginManager* loginMagr;
//@property (nonatomic, strong) WebViewShareModel* shareModel;
@property (nonatomic, strong) UIImageView* qrImageView;

+ (instancetype)getInstance;


/**
 webView交互统一分发

 @param webView 操作的webView
 @param aKey 交互key
 */
- (void)respondVC:(UIViewController*)respondVC actionKey:(NSString*)aKey;

- (void)respondVC:(UIViewController*)respondVC actionDic:(NSDictionary*)aDic;

- (void)toCommunityWebViewController:(UIViewController *)VC;
@end
