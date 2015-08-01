//
//  HomePageViewModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "HomePageViewModel.h"
#import "NewsListModel.h"

@interface HomePageViewModel()
@property (nonatomic, strong) NewsListModel *homePageModel;
@end

@implementation HomePageViewModel

- (RACCommand *)fetchNewsListCommand
{
    if (!_fetchNewsListCommand) {
        @weakify(self);
        _fetchNewsListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
           return [[self.homePageModel fetchNewsList] doNext:^(NewsListInfo * newsListInfo) {
                self.newsListInfo = newsListInfo;
            }];
        }];
    }
    return _fetchNewsListCommand;
}

- (NewsListModel *)homePageModel
{
    if (!_homePageModel) {
        _homePageModel = [[NewsListModel alloc] init];
    }
    return _homePageModel;
}
@end
