//
//  CopywritingSelectCell.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "CopywritingSelectCell.h"

@implementation CopywritingSelectCell
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"CopywritingSelectCell";
    CopywritingSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CopywritingSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI{
    self.contentLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(AD_HEIGHT(-15));
        make.top.offset(AD_HEIGHT(5));
        make.bottom.offset(AD_HEIGHT(-20));
    }];
    self.contentLabel.numberOfLines = 0;
    self.textdcopyBtn = [UIButton getButtonWithImageName:@"" titleText:@"复制" superView:self.contentView masonrySet:^(UIButton * _Nonnull btn, MASConstraintMaker * _Nonnull make) {
        make.right.offset(AD_HEIGHT(-15));
        make.bottom.offset(AD_HEIGHT(-5));

    }];
    
    [self.textdcopyBtn setTitleColor:C000000 forState:UIControlStateNormal];
    self.textdcopyBtn.titleLabel.font = F10;
    
    [self.textdcopyBtn addTarget:self action:@selector(textCopyClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)textCopyClick {
    if (self.copyClick) {
        self.copyClick();
    }
    
    
}
@end
