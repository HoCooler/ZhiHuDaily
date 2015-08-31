//
//  NewsDetailViewController.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/25.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsDetailWebView.h"
#import "NewsDetailViewModel.h"
#import "NewsDetailHeadView.h"
#import "NewsDetailFootView.h"
#import "UIColor+ZHDAddition.h"

@interface NewsDetailViewController ()

@property (nonatomic, strong) NewsDetailWebView *webView;
@property (nonatomic, strong) NewsDetailHeadView *headView;
@property (nonatomic, strong) NewsDetailFootView *footView;

@property (nonatomic, strong) NewsDetailViewModel *viewModel;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"新闻详情";
    
    _viewModel = [[NewsDetailViewModel alloc] init];
    self.viewModel.newsID = self.newsID;
    
    _headView = [[NewsDetailHeadView alloc] init];
    _headView.backgroundColor = [UIColor grayColor];
    _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    
    _webView = [[NewsDetailWebView alloc] initWithFrame:CGRectZero header:_headView];
    [self.view addSubview:_webView];
    
    _footView = [NewsDetailFootView new];
    [self.view addSubview:_footView];
    
    RACSignal *viewModelSignal = RACObserve(self, viewModel.info);
    RAC(self, webView.info) = viewModelSignal;
    RAC(self, headView.headInfo) = viewModelSignal;

    [self.viewModel.fetchNewsDetailCommand execute:nil];

    [self updateViewConstraints];
}

- (void)updateViewConstraints
{
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.footView.mas_top);
    }];
    
    [self.footView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    [super updateViewConstraints];
}

@end
