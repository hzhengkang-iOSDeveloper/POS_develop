//
//  ActivationMoneySearchViewController.m
//  POS_develop
//
//  Created by 胡正康 on 2018/10/1.
//  Copyright © 2018 sunyn. All rights reserved.
//

#import "ActivationMoneySearchViewController.h"
#import "ActivationMoneyCell.h"
@interface ActivationMoneySearchViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    UIImageView *searchImgV;
    UITextField *searchTF;
}
@property (nonatomic, strong) UITableView *searchTableView;


@end

@implementation ActivationMoneySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self initUI];
    [self createTableView];
    
}
- (void)createTableView {
    _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, FITiPhone6(46), ScreenWidth, ScreenHeight - TabbarHeight - FITiPhone6(46)) style:UITableViewStylePlain];
    _searchTableView.backgroundColor = WhiteColor;
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.showsVerticalScrollIndicator = NO;
    _searchTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_searchTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivationMoneyCell *cell = [ActivationMoneyCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FITiPhone6(87);
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
