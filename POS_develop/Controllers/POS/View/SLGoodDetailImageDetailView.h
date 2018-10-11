//
//  SLGoodDetailImageDetailView.h
//  Shopping2.0
//
//  Created by chenpeng on 2017/12/5.
//  Copyright © 2017年 HongHui(Shanghai)Information Technology Service Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLGoodDetailImageDetailViewDelegate <NSObject>

-(void)SLGoodDetailImageDetailViewChangeViewHeight:(CGFloat)offsetHeight;

@end

@interface SLGoodDetailImageDetailView : UIView

@property (nonatomic, copy) NSString *webViewURL;

@property (nonatomic,weak) id<SLGoodDetailImageDetailViewDelegate> delegate;

@end
