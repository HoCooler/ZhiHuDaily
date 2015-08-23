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
#import "NewsDetailViewController.h"
#import "AppDelegate.h"
#import <ECSlidingViewController.h>

@interface HomePageViewController ()

@property (nonatomic, strong) HomePageViewModel *viewModel;
@property (nonatomic, strong) NewsListView *listView;
@property (nonatomic, strong) NewsBannerView *bannerView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *menuButton;

@property (nonatomic, strong) RACCommand *jumpCommand;

@end

@implementation HomePageViewController

- (instancetype)initWithThemeID:(NSString *)themeID
{
    self = [super init];
    if (self) {
        _viewModel = [[HomePageViewModel alloc] initWithThemeID:themeID];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_listView];

    _menuButton = [UIButton new];
    UIImage *buttonImage = [UIImage imageNamed:@"menu_background"];
    [_menuButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    _menuButton.frame = CGRectMake(0, 0, 30, 20);
    [_menuButton addTarget:self action:@selector(anchorRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_menuButton];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"首页";
    _titleLabel.frame = CGRectMake(0, 0, 150, 20);
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithCustomView:_titleLabel];
    
    self.navigationItem.leftBarButtonItems = @[menuButtonItem, titleItem];

    
    [[self.viewModel fetchNewsListCommand] execute:nil];
    RAC(self, listView.news) = RACObserve(self, viewModel.newsListInfo.items);
    self.listView.jumpCommand = self.jumpCommand;
    
    RACSignal *bannerSignal = RACObserve(self, viewModel.newsListInfo.banners);
    RAC(self, bannerView.banners) = bannerSignal;
    self.bannerView.jumpCommand = self.jumpCommand;
    
    [bannerSignal subscribeNext:^(NSArray *banners) {
        if ([banners count]) {
            self.listView.tableHeaderView = self.bannerView;
        } else {
            self.listView.tableHeaderView = nil;
        }
    }];
    
    [self updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.listView deselectRowAtIndexPath:[self.listView indexPathForSelectedRow] animated:YES];
    [super viewWillAppear:animated];
}

- (void)updateViewConstraints
{
    [self.listView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

-(NewsListView *)listView
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

- (RACCommand *)jumpCommand
{
    if (!_jumpCommand) {
        _jumpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *newsID) {
            NewsDetailViewController *detailVC = [[NewsDetailViewController alloc] init];
            detailVC.newsID = newsID;
            [self.navigationController pushViewController:detailVC animated:YES];
            return [RACSignal empty];
        }];
    }
    return _jumpCommand;
}

- (void)anchorRight
{
    ECSlidingViewController *slidingViewController = (ECSlidingViewController *)([UIApplication sharedApplication].keyWindow.rootViewController);

    [slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
