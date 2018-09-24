//
//  TransactionQueryMainView.h
//  POS_develop
//
//  Created by syn on 2018/9/24.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionQueryMainView : UIView
//@property (strong, nonatomic) IBOutlet UIView *mView;//要进行关联的UIView
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (nonatomic, copy) void(^brandSelectBlock)(void);
@end
