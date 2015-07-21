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
@property (nonatomic, strong) UIView *mainView;
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
//            [self.bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(self.view);
//                make.height.equalTo(@160);
//            }];
            self.listView.tableHeaderView = self.bannerView;
//            [self.listView setTableHeaderView:self.bannerView];
        } else {
            self.listView.tableHeaderView = nil;
        }
    }];
   /* [[bannerSignal filter:^BOOL(NSArray *banners) {
        return [banners count];
    }] subscribeNext:^(id x) {
        [self.bannerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
//            make.top.equalTo(self.headView.mas_bottom).offset(10);
            make.height.equalTo(@160);
        }];
//        
//                [self.listView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    make.edges.equalTo(self.view);
//                }];
//
                [self.listView setTableHeaderView:self.bannerView];

//        [self.listView reloadData];
//        [self.listView beginUpdates];
//        [self.listView setTableHeaderView:self.bannerView];
//        [self.listView endUpdates];
//
////        [self.listView mas_remakeConstraints:^(MASConstraintMaker *make) {
////            make.right.equalTo(self.view).offset(-10);
////            make.bottom.equalTo(self.view);
////            make.top.equalTo(self.headView.mas_bottom).offset(10);
////            make.left.equalTo(self.view.mas_left).offset(10);
////        }];

//        [super updateViewConstraints];
    }];*/
}

- (void)updateViewConstraints
{
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
//    [self.bannerView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
////        make.top.equalTo(self.headView.mas_bottom).offset(10);
//        make.height.equalTo(@0);
//    }];
//    
//    [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view).offset(-10);
//        make.bottom.equalTo(self.view);
//        make.top.equalTo(self.headView.mas_bottom).offset(10);
//        make.left.equalTo(self.view.mas_left).offset(10);
//    }];
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headView.mas_bottom).offset(10);
    }];
    
//    [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.top.equalTo(self.headView.mas_bottom).offset(10);
//    }];
    
    [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainView);
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

- (NewsListView *)listView
{
    if (!_listView) {
        _listView = [[NewsListView alloc] init];
        [self.mainView addSubview:_listView];
    }
    return _listView;
}

- (NewsBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[NewsBannerView alloc] initWithFrame:CGRectZero];
        [self.mainView addSubview:_bannerView];
        
//        [_bannerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.view);
//            make.height.equalTo(@200);
//        }];

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

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [UIView new];
        [self.view addSubview:_mainView];
    }
    return _mainView;
}
@end
