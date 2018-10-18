//
//  HtmlGenerailzeDetailCell.m
//  POS_develop
//
//  Created by sunyn on 2018/10/10.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "HtmlGenerailzeDetailCell.h"
#import "ShareH5ReaderModel.h"
@implementation HtmlGenerailzeDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"HtmlGenerailzeCell";
    HtmlGenerailzeDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HtmlGenerailzeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.iconImageView = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(AD_HEIGHT(15));
        make.size.mas_offset(CGSizeMake(AD_HEIGHT(50), AD_HEIGHT(45)));
    }];
    self.idLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(AD_HEIGHT(15));
        make.top.offset(AD_HEIGHT(14));
        make.height.mas_equalTo(AD_HEIGHT(13));
    }];
    
    self.nickNameLabel = [UILabel getLabelWithFont:F12 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.idLabel.mas_left);
        make.top.equalTo(self.idLabel.mas_bottom).offset(AD_HEIGHT(7));
        make.height.mas_equalTo(AD_HEIGHT(12));
    }];
    
    
    
    self.readTime = [UILabel getLabelWithFont:F10 textColor:C000000 superView:self.contentView masonrySet:^(UILabel *view, MASConstraintMaker *make) {
        make.left.equalTo(self.idLabel.mas_left);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(AD_HEIGHT(7));
        make.height.mas_equalTo(AD_HEIGHT(10));
    }];
    [UIView getViewWithColor:RGB(230, 226, 226) superView:self.contentView masonrySet:^(UIView *view, MASConstraintMaker *make) {
        make.left.offset(AD_HEIGHT(15));
        make.right.offset(0);
        make.height.mas_equalTo(AD_HEIGHT(1));
        make.bottom.offset(0);
    }];
}

- (void)setModel:(ShareH5ReaderModel *)model {
    if (model) {
        _model = model;
        self.idLabel.text = [NSString stringWithFormat:@"ID：%@", model.readerOpenid];
        self.nickNameLabel.text = [NSString stringWithFormat:@"昵称：%@", model.readerNickname];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.readerIcon] placeholderImage:[UIImage imageNamed:@"头像女孩拷贝"]];
        self.readTime.text = [NSString stringWithFormat:@"阅读时间：%@秒", model.readerTime];
        NSMutableAttributedString *idStr = [[NSMutableAttributedString alloc] initWithString:self.idLabel.text];
        // 改变颜色
        [idStr addAttribute:NSForegroundColorAttributeName value:C989898 range:NSMakeRange(3,self.idLabel.text.length-3)];
        [idStr addAttribute:NSFontAttributeName value:
         F10 range:NSMakeRange(3,self.idLabel.text.length-3)];
        
        self.idLabel.attributedText = idStr;
        
        NSMutableAttributedString *nickNameStr = [[NSMutableAttributedString alloc] initWithString:self.nickNameLabel.text];
        // 改变颜色
        [nickNameStr addAttribute:NSForegroundColorAttributeName value:C989898 range:NSMakeRange(3,self.nickNameLabel.text.length-3)];
        [nickNameStr addAttribute:NSFontAttributeName value:
         F10 range:NSMakeRange(3,self.nickNameLabel.text.length-3)];
        
        self.nickNameLabel.attributedText = nickNameStr;
        
        NSMutableAttributedString *readTimeStr = [[NSMutableAttributedString alloc] initWithString:self.readTime.text];
        // 改变颜色
        [readTimeStr addAttribute:NSForegroundColorAttributeName value:C1E95F9 range:NSMakeRange(5,self.readTime.text.length-5)];
        
        
        self.readTime.attributedText = readTimeStr;

    }
}
@end
