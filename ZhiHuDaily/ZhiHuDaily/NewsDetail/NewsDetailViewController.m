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
#import "NewsListItem.h"
#import "TKAlertCenter.h"

@interface NewsDetailViewController ()

@property (nonatomic, strong) NewsDetailWebView *webView;
@property (nonatomic, strong) NewsDetailHeadView *headView;
@property (nonatomic, strong) NewsDetailFootView *footView;

@property (nonatomic, strong) NewsDetailViewModel *viewModel;

@property (nonatomic, strong) RACCommand *backCommand;
@property (nonatomic, strong) RACCommand *nextCommand;
@property (nonatomic, strong) RACCommand *previousCommand;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"新闻详情";
    
    _newsID = ((NewsListItem *)self.newsListItems[self.index]).newsID;
    
    _viewModel = [[NewsDetailViewModel alloc] init];
    
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
    RAC(self, viewModel.newsID) = RACObserve(self, newsID);
    self.footView.backCommand = self.backCommand;
    self.footView.nextCommand = self.nextCommand;
    self.webView.previousCommand = self.previousCommand;

    [self refresh];
    
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

-(void)refresh
{
    [self.viewModel.fetchNewsDetailCommand execute:nil];
}

- (RACCommand *)backCommand
{
    if (!_backCommand) {
        @weakify(self)
        _backCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
            return [RACSignal empty];
        }];
    }
    return _backCommand;
}

-(RACCommand *)nextCommand
{
    if (!_nextCommand) {
        @weakify(self)
        _nextCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if ((self.index + 1)< self.newsListItems.count) {
                self.index = self.index + 1;
            } else {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"已经是最后一篇了"];
            }
            return [RACSignal empty];
        }];
    }
    return _nextCommand;
}

-(RACCommand *)previousCommand
{
    if (!_previousCommand) {
        @weakify(self)
        _previousCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if (self.index > 0) {
                self.index = self.index - 1;
            } else {
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"已经是第一篇了"];
            }
            return [RACSignal empty];
        }];
    }
    return _previousCommand;
}

-(void)setIndex:(NSInteger)index
{
    if (_index != index) {
        _index = index;
        self.newsID = ((NewsListItem *)self.newsListItems[self.index]).newsID;
        [self refresh];
    }
}

@end
