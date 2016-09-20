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

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) RACCommand *jumpCommand;

@end

@implementation HomePageViewController

- (instancetype)initWithThemeID:(NSString *)themeID
{
    self = [super init];
    if (self) {
        _themeID = themeID;
        _viewModel = [[HomePageViewModel alloc] initWithThemeID:themeID];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [NSThread sleepForTimeInterval:2.0];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_listView];

    _menuButton = [UIButton new];
    _menuButton.backgroundColor = [UIColor clearColor];
    UIImage *buttonImage = [UIImage imageNamed:@"Home_Icon"];
    [_menuButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    _menuButton.frame = CGRectMake(0, 0, 30, 20);
    [_menuButton addTarget:self action:@selector(anchorRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_menuButton];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"首页";
    _titleLabel.frame = CGRectMake(0, 0, 150, 20);
    _titleLabel.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithCustomView:_titleLabel];
    
    self.navigationItem.leftBarButtonItems = @[menuButtonItem, titleItem];
    
    _refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
    [self.listView addSubview:self.refreshControl];

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
    
    [[self.viewModel fetchNewsListCommand] execute:nil];

    [self updateViewConstraints];
}

-(UIImage *)imageWithColor:(UIColor *)color path:(UIBezierPath *)path
{
    CGRect rect = CGRectMake(0, 0, 3, 3);
    if (path) {
        rect = path.bounds;
    }
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    if (path) {
        [path fill];
    } else {
        CGContextFillRect(context, rect);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
    }
    return _bannerView;
}

- (RACCommand *)jumpCommand
{
    if (!_jumpCommand) {
        @weakify(self)
        _jumpCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *newsID) {
            @strongify(self)
            NewsDetailViewController *detailVC = [[NewsDetailViewController alloc] init];
            detailVC.newsID = newsID;
            detailVC.newsListItems = self.viewModel.newsListInfo.items;
//            detailVC.index = [index integerValue];
            [self.navigationController pushViewController:detailVC animated:YES];
            return [RACSignal empty];
        }];
    }
    return _jumpCommand;
}

- (void)refresh
{
    [[self.viewModel fetchNewsListCommand] execute:nil];
    if (self.refreshControl.isRefreshing) {
        [self.refreshControl endRefreshing];
    }
}

- (void)setThemeID:(NSString *)themeID
{
    if (_themeID != themeID) {
        _themeID = themeID;
        self.viewModel.themeID = themeID;
        [self refresh];
    }
}

#pragma mark ======= ECSlidingViewController Delegate =============

- (void)anchorRight
{
    ECSlidingViewController *slidingViewController = (ECSlidingViewController *)([UIApplication sharedApplication].keyWindow.rootViewController);

    [slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
