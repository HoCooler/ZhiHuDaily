//
//  ThemeViewModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/28.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "ThemeViewModel.h"
#import "ThemeModel.h"

@interface ThemeViewModel()

@property (nonatomic, strong) ThemeModel *model;

@end

@implementation ThemeViewModel

- (RACCommand *)themeSubscribeCommand
{
    @weakify(self)
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self.model themeSubscribe:self.themeID];
    }];
}

- (RACCommand *)themeUnSubscribeCommand
{
    @weakify(self)
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [[self.model themeUnSubscribe:self.themeID] doNext:^(id x) {
            //Error
            ;
        }];
    }];
}

-(ThemeModel *)model
{
    if (!_model) {
        _model = [[ThemeModel alloc] init];
    }
    return _model;
}
@end
