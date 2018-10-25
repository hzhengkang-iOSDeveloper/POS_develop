//
//  SLPopupShowView.m
//  Shopping2.0
//
//  Created by soolife_mac_2 on 2017/5/4.
//  Copyright © 2017年 HongHui(Shanghai)Information Technology Service Co.,Ltd. All rights reserved.
//

#import "SLPopupShowView.h"

typedef void(^buttonClickBlock)(int);

@interface SLPopupShowView ()

@property (nonatomic, strong) UIButton  *bgView;

@property (nonatomic, strong) UIView *containerView;
//标题label
@property (nonatomic, strong) UILabel *headingLab;

//x按钮
@property (nonatomic, strong) UIButton *closeBtn;

//内容label
@property (nonatomic, strong) UILabel *titleLab;

//左边按钮
@property (nonatomic, strong) UIButton *leftButton;

//右边按钮
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) buttonClickBlock buttonClick;

//分割横线
@property (nonatomic, strong) UIView *lineView;

//分割竖线
@property (nonatomic, strong) UIView *cutView;

@end

@implementation SLPopupShowView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(SLPopupShowView *)createPopupShowViewWithContentText:(NSString *)titleText buttons:(NSArray *)buttons buttonClick:(void (^)(int))btnClick {
    SLPopupShowView *popupView = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    popupView.titleLab.text = titleText;
    if (buttons.count==1) {
        [popupView.leftButton setTitle:buttons.firstObject forState:UIControlStateNormal];
        [popupView.leftButton setTitleColor:C_LightRed_EB3349 forState:UIControlStateNormal];
        [popupView.rightButton setTitle:@"" forState:UIControlStateNormal];
    } else if (buttons.count==2) {
        [popupView.leftButton setTitle:buttons.firstObject forState:UIControlStateNormal];
        [popupView.rightButton setTitle:buttons.lastObject forState:UIControlStateNormal];
    }
    popupView.buttonClick = btnClick;
    [popupView showView];
    return popupView;
}

+(SLPopupShowView *)createPopupShowViewWithHeadingText:(NSString *)headingText ContentText:(NSString *)titleText knowBtnTitle:(NSString *)btnTitle IsShowCloseBtn:(BOOL)isShowCloseBtn IsShowKnowBtn:(BOOL)isShowKnowBtn buttonClick:(void(^)(int index))btnClick {
    SLPopupShowView *popupView = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    popupView.headingLab.hidden = NO;
    popupView.headingLab.text = headingText;
    popupView.titleLab.text = titleText;
    popupView.closeBtn.hidden = !isShowCloseBtn;
    if (isShowKnowBtn) {
        popupView.leftButton.hidden = NO;
        popupView.rightButton.hidden = NO;
        [popupView.leftButton setTitle:btnTitle forState:UIControlStateNormal];
        popupView.leftButton.titleLabel.font = F14;
        popupView.leftButton.backgroundColor = C_LightRed_EB3349;
        [popupView.leftButton setTitleColor:WhiteColor forState:UIControlStateNormal];
        [popupView.rightButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        popupView.leftButton.hidden = YES;
        popupView.rightButton.hidden = YES;
    }
    popupView.cutView.hidden = YES;
    popupView.lineView.hidden = YES;
    popupView.buttonClick = btnClick;
    [popupView showView];
    return popupView;
}


- (void)setupUI{
    //背景
    self.bgView = [[UIButton alloc] initWithFrame:self.bounds];
    self.bgView.backgroundColor = RGBA(0, 0, 0, 0);
    [self addSubview:self.bgView];
    [self.bgView addTarget:self action:@selector(bgViewClick) forControlEvents:UIControlEventTouchUpInside];
    //容器
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = WhiteColor;
    self.containerView.layer.cornerRadius = 3.0f;
    self.containerView.layer.masksToBounds = YES;
    [self.bgView addSubview:self.containerView];
    
    //标题
    self.headingLab = [[UILabel alloc] init];
    self.headingLab.hidden = YES;
    self.headingLab.font = FB19;
    self.headingLab.textAlignment = NSTextAlignmentCenter;
    self.headingLab.textColor = C000000;
    [self.containerView addSubview:self.headingLab];
    
    //x按钮
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.hidden = YES;
    [self.closeBtn setBackgroundImage:ImageNamed(@"life_delete") forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.closeBtn];
    
    //内容label
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = F16;
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = C000000;
    self.titleLab.numberOfLines = 0;
    [self.containerView addSubview:self.titleLab];
    //左边按钮
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.titleLabel.font = F19;
    [self.leftButton setTitleColor:C000000 forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.leftButton];
    //右边按钮
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.titleLabel.font = self.leftButton.titleLabel.font;
    [self.rightButton setTitleColor:C_LightRed_EB3349 forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.rightButton];
    //分割横线
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = CF6F6F6;
    [self.containerView addSubview:self.lineView];
    //分割竖线
    self.cutView = [[UIView alloc]init];
    self.cutView.backgroundColor = CF6F6F6;
    [self.containerView addSubview:self.cutView];
}

-(void)removeView {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.backgroundColor = RGBA(0, 0, 0, 0);
        self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
        self.titleLab.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)showView {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.backgroundColor = RGBA(0, 0, 0, 0.6);
    }];
    self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
    self.titleLab.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        self.titleLab.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished) {
        self.containerView.transform = CGAffineTransformIdentity;
        self.titleLab.transform = CGAffineTransformIdentity;
    }];
}

-(void)bgViewClick {
    //[self removeView];
}

//左边按钮点击
-(void)leftButtonClick {
    [self removeView];
    if (_buttonClick) {
        _buttonClick(0);
    }
}

//右边按钮点击
-(void)rightButtonClick {
    [self removeView];
    if (_buttonClick) {
        _buttonClick(1);
    }
}

- (void)layoutSubviews {
    
    NSDictionary *attr = @{NSFontAttributeName:F16};
    CGSize maxSize = [self.titleLab.text boundingRectWithSize:CGSizeMake(AD_WIDTH(266), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    CGSize size = CGSizeMake(AD_WIDTH(266), maxSize.height+AD_HEIGHT(2));
    CGFloat labelHeight;
    if (size.height<25) {
        labelHeight = 35;
    } else {
        labelHeight = size.height;
    }
    CGFloat headingHeight;
    
    if (self.headingLab.text != nil) {
        headingHeight = AD_HEIGHT(55);
    } else {
        headingHeight = AD_HEIGHT(10);
    }
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.left.mas_equalTo(self.bgView.mas_left).offset(AD_WIDTH(27.5));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-AD_WIDTH(27.5));
        make.height.mas_equalTo(@(AD_HEIGHT(65)+labelHeight+headingHeight));
    }];
    
    [self.headingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).offset(AD_WIDTH(35));
        make.right.mas_equalTo(self.containerView.mas_right).offset(-AD_WIDTH(35));
        make.top.mas_equalTo(self.containerView.mas_top).offset(AD_HEIGHT(20));
        make.height.equalTo(@AD_HEIGHT(20));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView.mas_top).offset(AD_HEIGHT(20));
        make.right.mas_equalTo(self.containerView.mas_right).offset(-AD_WIDTH(20));
        make.height.width.equalTo(@AD_WIDTH(15));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).offset(AD_WIDTH(27));
        make.right.mas_equalTo(self.containerView.mas_right).offset(-AD_WIDTH(27));
        make.top.mas_equalTo(self.containerView.mas_top).offset(headingHeight);
        make.height.equalTo(@(labelHeight));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).offset(AD_WIDTH(27));
        make.right.mas_equalTo(self.containerView.mas_right).offset(-AD_WIDTH(27));
        make.top.mas_equalTo(self.containerView.mas_top).offset(labelHeight+headingHeight+AD_HEIGHT(10));
        make.height.equalTo(@(0.5));
    }];
    
    [self.cutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).offset((ScreenWidth-2*AD_WIDTH(27.5))/2);
        make.top.mas_equalTo(self.containerView.mas_top).offset(labelHeight+headingHeight+AD_HEIGHT(10));
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(AD_HEIGHT(45)));
    }];
    
    NSString *rightText = [self.rightButton titleForState:UIControlStateNormal];
    if ([rightText isKindOfClass:[NSString class]] && rightText.length>0) {
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.containerView.mas_bottom);
            make.left.mas_equalTo(self.containerView.mas_left);
            make.width.mas_equalTo(self.containerView.mas_width).multipliedBy(0.5);
            make.height.equalTo(@(AD_HEIGHT(55)));
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.containerView.mas_bottom);
            make.right.mas_equalTo(self.containerView.mas_right);
            make.width.mas_equalTo(self.containerView.mas_width).multipliedBy(0.5);
            make.height.equalTo(@(AD_HEIGHT(55)));
        }];
    } else {
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.containerView.mas_bottom);
            make.left.mas_equalTo(self.containerView.mas_left);
            make.width.mas_equalTo(self.containerView.mas_width);
            make.height.equalTo(@(AD_HEIGHT(55)));
        }];
        self.rightButton.hidden = YES;
        self.cutView.hidden = YES;
    }
    
    [super layoutSubviews];
}


@end
