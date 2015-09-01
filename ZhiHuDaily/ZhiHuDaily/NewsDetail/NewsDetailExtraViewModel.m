//
//  NewsDetailExtraViewModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/9/1.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailExtraViewModel.h"
#import "NewsDetailExtraModel.h"

@interface NewsDetailExtraViewModel()

@property (nonatomic, strong) NewsDetailExtraModel *model;

@end

@implementation NewsDetailExtraViewModel

-(RACCommand *)fetchNewsDetailExtraCommand
{
    if (!_fetchNewsDetailExtraCommand) {
        @weakify(self)
        return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            return [[[self.model fetchNewsDetailExtraWithNewsID:self.newsID] doNext:^(NewsDetailExtraInfo *extraInfo) {
                self.extraInfo = extraInfo;
            }] catch:^RACSignal *(NSError *error) {
                NSLog(@"Error = %@", error);
                return [RACSignal empty];
            }];
        }];
    }
    return _fetchNewsDetailExtraCommand;
}

-(NewsDetailExtraModel *)model
{
    if (!_model) {
        _model = [[NewsDetailExtraModel alloc] init];
    }
    return _model;
}

@end
