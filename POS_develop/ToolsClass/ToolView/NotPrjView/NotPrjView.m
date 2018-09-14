//
//  NotPrjView.m
//  HePanDai2_0
//
//  Created by sands on 16/9/5.
//  Copyright © 2016年 HePanDai. All rights reserved.
//

#import "NotPrjView.h"

@implementation NotPrjView

- (void)setImage:(UIImage*)image title:(NSString*)title{
    self.imageView.image = image;
    self.title.text = title;
    self.title.adjustsFontSizeToFitWidth = YES;
}
-(void)layoutSubviews{
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [AppDelegate storyBoradAutoLay:self];
}
@end
