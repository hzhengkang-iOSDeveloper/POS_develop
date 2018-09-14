//
//  NotPrjView.h
//  HePanDai2_0
//
//  Created by sands on 16/9/5.
//  Copyright © 2016年 HePanDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotPrjView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

- (void)setImage:(UIImage*)image title:(NSString*)title;
@end
