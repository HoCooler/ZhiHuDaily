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

@interface NewsDetailViewController ()

@property (nonatomic, strong) NewsDetailWebView *webView;
@property (nonatomic, strong) UIView *actionView;
@property (nonatomic, strong) NewsDetailHeadView *headView;
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
    _webView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_webView];
    
    RAC(self, webView.info) = RACObserve(self, viewModel.info);
    RAC(self, headView.headInfo) = RACObserve(self, viewModel.info);

    [self.viewModel.fetchNewsDetailCommand execute:nil];

    [self updateViewConstraints];
}

- (void)updateViewConstraints
{
    [self.actionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@0);
    }];
    
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.actionView.mas_bottom);
    }];
    
    [super updateViewConstraints];
}

- (UIView *)actionView
{
    if (!_actionView) {
        _actionView = [[UIView alloc] init];
        _actionView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_actionView];
    }
    return _actionView;
}

@end
