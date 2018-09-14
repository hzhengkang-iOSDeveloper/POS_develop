//
//  ActivityView.h
//  HePanDai2_0
//
//  Created by 合盘贷 on 16/2/25.
//  Copyright © 2016年 HePanDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView
+ (ActivityView *)instancView;
@property (weak, nonatomic) IBOutlet UIWebView *MyActivityWebView;
@end
