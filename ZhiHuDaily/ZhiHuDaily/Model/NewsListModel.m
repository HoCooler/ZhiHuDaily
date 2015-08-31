//
//  NewsListModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsListModel.h"
#import "NewsListInfo.h"
#import "NewsListItem.h"

@interface NewsListModel()

@end

@implementation NewsListModel

- (instancetype)initWithThemeID:(NSString *)themeID
{
    self = [super init];
    if (self) {
        _themeID = themeID;
    }
    return self;
}

- (RACSignal *)fetchNewsList
{
 
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        
//        self.themeID = @"12";
//        NSString *path = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%@", self.themeID];
        
//        NSString *path = @"http://news-at.zhihu.com/api/4/news/latest";

        NSString *path;
        if (!self.themeID || [self.themeID integerValue] == 1) {
            path = @"http://news-at.zhihu.com/api/4/news/latest?client=0";
        } else if ([self.themeID integerValue] > 1 && [self.themeID integerValue] <= 13){
            path = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%@", self.themeID];
        } else {
            NSLog(@"ThemeID has out of rang (1-13)");
            path = nil;
        }
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
            if (!result[@"stories"] && ![result[@"stories"] isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Error : %@", @"The data formate Error");
                return;
            }
            
            NSError *error;
            NewsListInfo *newsInfo = [MTLJSONAdapter modelOfClass:[NewsListInfo class] fromJSONDictionary:result error:&error];
            
            [subscriber sendNext:newsInfo];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error = %@,  %@", error, operation);
            [subscriber sendError:error];
        }];
        
        //TODO
        return [RACDisposable disposableWithBlock:^{
//            [ cancel];
        }];
        
    }] deliverOnMainThread];
}

@end
