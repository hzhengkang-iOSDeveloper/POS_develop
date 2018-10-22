//
//  TerminalBindTableViewCell.h
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AgentPosListModel;
NS_ASSUME_NONNULL_BEGIN

@interface TerminalBindTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *productNameL;
@property (nonatomic, strong) UILabel *viceProductNameL;
@property (nonatomic, strong) UILabel *snL;
@property (nonatomic, strong) UILabel *modelL;
@property (nonatomic, strong) AgentPosListModel *model;

@property (nonatomic, strong) UILabel *bindStateL;//在终端查询界面用
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
