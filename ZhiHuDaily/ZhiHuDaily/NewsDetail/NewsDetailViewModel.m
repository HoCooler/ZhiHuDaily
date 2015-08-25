//
//  NewsDetailViewModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/26.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailViewModel.h"
#import "NewsDetailModel.h"

@interface NewsDetailViewModel()

@property (nonatomic, strong) NewsDetailModel *model;

@end

@implementation NewsDetailViewModel

- (RACCommand *)fetchNewsDetailCommand
{
    if (!_fetchNewsDetailCommand) {
        @weakify(self);
        _fetchNewsDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            return [[self.model fetchNewsDetailWithNewsID:self.newsID] doNext:^(NewsDetailInfo *info) {
                self.info = info;
            }];
        }];
    }
    return _fetchNewsDetailCommand;
}

- (NewsDetailModel *)model
{
    if (!_model) {
        _model = [[NewsDetailModel alloc] init];
    }
    return _model;
}
@end
