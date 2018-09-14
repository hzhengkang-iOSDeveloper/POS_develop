//
//  DirectivePageViewController.h
//  HpCF
//
//  Created by 孙亚男 on 2017/10/11.
//  Copyright © 2017年 孙亚男. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  功能引导控制器
 */
@interface DirectivePageViewController : UIViewController

/**
 *  功能引导页保存在本地，固定，此属性留作接口，以备从服务器取出图片
 */
@property (nonatomic) NSArray *images;

@property (nonatomic, copy) void (^endCallback)(void);

@end
