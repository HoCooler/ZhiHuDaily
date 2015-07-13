//
//  HomePageViewController.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageViewModel.h"
#import "newsListView.h"

@interface HomePageViewController ()

@property (nonatomic, strong) HomePageViewModel *viewModel;
@property (nonatomic, strong) newsListView *listView;
@property (nonatomic, strong) UIView *headView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.viewModel fetchNewsListCommand] execute:nil];
    RAC(self, listView.newsDataSource) = RACObserve(self, viewModel.newsListInfo);
}

- (void)updateViewConstraints
{
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
//        make.edges.equalTo(self);
    }];
    
    [super updateViewConstraints];
}

- (HomePageViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[HomePageViewModel alloc] init];
    }
    return _viewModel;
}

- (newsListView *)listView
{
    if (!_listView) {
        _listView = [[newsListView alloc] init];
        [self.view addSubview:_listView];
    }
    return _listView;
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] init];
        [self.view addSubview:_headView];
    }
    return _headView;
}

@end
