//
//  SeparateQuerySearchViewController.m
//  POS_develop
//
//  Created by sunyn on 2018/9/25.
//  Copyright © 2018年 sunyn. All rights reserved.
//

#import "SeparateQuerySearchViewController.h"

@interface SeparateQuerySearchViewController () <UITextFieldDelegate> {
    UIImageView *searchImgV;
    UITextField *searchTF;
}

@end

@implementation SeparateQuerySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self initUI];
}

- (void)initUI {
    UIImageView *searchImageV = [[UIImageView alloc] init];
    searchImageV.backgroundColor = RGB(238, 238, 238);
    searchImageV.layer.cornerRadius = FITiPhone6(16);
    searchImageV.layer.masksToBounds = YES;
    searchImageV.userInteractionEnabled = YES;
    searchImageV.image = [UIImage imageNamed:@"搜索框"];
//    UITapGestureRecognizer *searchTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchTap)];
//    [searchImageV addGestureRecognizer:searchTap];
    [self.view addSubview:searchImageV];
    [searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(FITiPhone6(15));
        make.top.equalTo(self.view).offset(FITiPhone6(13));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(33)));
    }];
    searchImgV = [[UIImageView alloc] init];
    searchImgV.userInteractionEnabled = YES;
    searchImgV.image = [UIImage imageNamed:@"搜索"];
    [searchImageV addSubview:searchImgV];
    [searchImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageV).offset(FITiPhone6(9));
        make.centerY.equalTo(searchImageV.mas_centerY);
        make.size.mas_offset(CGSizeMake(FITiPhone6(16), FITiPhone6(16)));
    }];
    
    searchTF = [[UITextField alloc] init];
    searchTF.delegate = self;
    [self.view addSubview:searchTF];
    [searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageV).offset(FITiPhone6(9));
        make.top.equalTo(self.view).offset(FITiPhone6(13));
        make.size.mas_offset(CGSizeMake(ScreenWidth - FITiPhone6(30), FITiPhone6(33)));

    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    searchImgV.hidden = YES;
    return YES;
}
@end
