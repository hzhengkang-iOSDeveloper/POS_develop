//
//  UITableView+BackgroundImageView.m
//  SuperCardWallet
//
//  Created by zhaoyi-PC on 2017/4/19.
//  Copyright © 2017年 赵诣. All rights reserved.
//

#import "UITableView+BackgroundImageView.h"

@implementation UITableView (BackgroundImageView)

- (void)tableViewSetBackgroundImageViewWithImageName:(NSString *)imgName title:(NSString *)title DataCount:(NSInteger)count{
    if (count == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor clearColor];
        self.backgroundView = view;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FITiPhone6(200), FITiPhone6(200))];
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.center = CGPointMake(view.width / 2.0, view.height / 2.0 - Fit(150));
        img.image = [UIImage imageNamed:imgName];
        [view addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame) + FITiPhone6(10), self.width, FITiPhone6(33))];
        label.text = [title isEqualToString:@""] ? @"没有数据" : title;
        label.font = MainFont(FITiPhone6(24));
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = ShallowTextColor;
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
    } else {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = ClearColor;;
        self.backgroundView = view;
    }
}


@end
