//
//  MineViewController.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/8.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MineViewController.h"
#import "MenuTableView.h"

@interface MineViewController ()
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) MenuTableView *listView;
@end

@implementation MineViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.navigationController.navigationBarHidden = YES;

        self.view.backgroundColor = [UIColor clearColor];
        self.view.layer.borderWidth     = 1;
//        self.view.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
        self.view.layer.borderColor     = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
        self.edgesForExtendedLayout     = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft; // don't go under the top view
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _headView = [UIView new];
    _headView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_headView];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@150);
        make.left.right.top.equalTo(self.view);
    }];
    
    _listView = [[MenuTableView alloc] init];
    [self.view addSubview:_listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headView.mas_bottom);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
