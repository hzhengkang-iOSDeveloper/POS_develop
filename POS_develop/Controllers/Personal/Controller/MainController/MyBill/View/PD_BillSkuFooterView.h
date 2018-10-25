//
//  PD_BillSkuFooterView.h
//  POS_develop
//
//  Created by 胡正康 on 2018/9/20.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillListModel;
NS_ASSUME_NONNULL_BEGIN

@interface PD_BillSkuFooterView : UIView
@property (nonatomic, strong) BillListModel *model;
//数量 价格描述
@property (nonatomic, weak) UILabel *countAndPriceLabel;
@end

NS_ASSUME_NONNULL_END
