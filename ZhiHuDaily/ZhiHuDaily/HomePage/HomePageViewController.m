//
//  HomePageViewController.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageViewModel.h"
#import "NewsListView.h"
#import "NewsBannerView.h"

@interface HomePageViewController ()

@property (nonatomic, strong) HomePageViewModel *viewModel;
@property (nonatomic, strong) NewsListView *listView;
@property (nonatomic, strong) NewsBannerView *bannerView;
@property (nonatomic, strong) UIView *headView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日要闻";
    self.view.backgroundColor = [UIColor grayColor];
    [[self.viewModel fetchNewsListCommand] execute:nil];
    RAC(self, listView.news) = RACObserve(self, viewModel.newsListInfo.items);
    RACSignal *bannerSignal = RACObserve(self, viewModel.newsListInfo.banners);
    RAC(self, bannerView.banners) = bannerSignal;
    
    [bannerSignal subscribeNext:^(NSArray *banners) {
        if ([banners count]) {
            self.listView.tableHeaderView = self.bannerView;
        } else {
            self.listView.tableHeaderView = nil;
        }
    }];
}

- (void)updateViewConstraints
{
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@40);
    }];

    [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.headView.mas_bottom).offset(10);
    }];
    
//    [self.bannerView mas_updateConstraints:^(MASConstraintMaker *make) {
////        make.left.right.top.equalTo(self.view);
//        make.height.equalTo(@160);
//    }];
    
    [super updateViewConstraints];
}

- (HomePageViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[HomePageViewModel alloc] init];
    }
    return _viewModel;
}

- (NewsListView *)listView
{
    if (!_listView) {
        _listView = [[NewsListView alloc] init];
        [self.view addSubview:_listView];
    }
    return _listView;
}

- (NewsBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[NewsBannerView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
//        [self.view addSubview:_bannerView];
    }
    return _bannerView;
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
