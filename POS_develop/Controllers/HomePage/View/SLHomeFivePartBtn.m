
//
//  SLHomeFivePartBtn.m
//  Shopping2.0
//
//  Created by chenpeng on 2018/4/16.
//  Copyright © 2018年 HongHui(Shanghai)Information Technology Service Co.,Ltd. All rights reserved.
//

#import "SLHomeFivePartBtn.h"

@interface SLHomeFivePartBtn ()

@property (nonatomic, weak) UILabel *title;

@property (nonatomic, weak) UIButton *btn;

@end

@implementation SLHomeFivePartBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn = btn;
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UILabel *title = [UILabel new];
        self.title = title;
        title.font = F12;
        title.textColor = C000000;
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        
        MJWeakSelf;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.centerX.offset(0);
            make.size.mas_offset(CGSizeMake(AD_HEIGHT(29), AD_HEIGHT(29)));
//            make.bottom.mas_equalTo(title.mas_top).offset(-AD_HEIGHT(7));
//            make.right.mas_equalTo(weakSelf).offset(-AD_WIDTH(10));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom).offset(AD_HEIGHT(7));
//            make.bottom.mas_equalTo(weakSelf).offset(-AD_HEIGHT(8));
            make.left.right.mas_equalTo(weakSelf);
            make.height.mas_equalTo(AD_HEIGHT(15));
        }];
    }
    return self;
}

- (void)setHoldImage:(UIImage *)holdImage {
    if (holdImage) {
        _holdImage = holdImage;
        [self.btn setImage:holdImage forState:normal];
    }
}

- (void)setName:(NSString *)name {
    if (name) {
        _name = name;
        
        self.title.text = name;
    }
}

- (void)btnClick {
    if (_selfClickEcho) {
        _selfClickEcho();
    }
}





@end
