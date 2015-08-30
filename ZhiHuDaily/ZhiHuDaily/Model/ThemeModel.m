//
//  ThemeModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/28.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "ThemeModel.h"

@implementation ThemeModel

- (RACSignal *)themeSubscribe:(NSString *)themeID
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (themeID.length) {
            NSString *path = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%@/subscribe", themeID];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"theme_id"] = themeID;
            [manager POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error = %@,  %@", error, operation);
                [subscriber sendError:error];
            }];
        }
        
        return [RACDisposable disposableWithBlock:^{
            ;
        }];
    }] deliverOnMainThread];
}

- (RACSignal *)themeUnSubscribe:(NSString *)themeID
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (themeID.length) {
            NSString *path = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%@/unsubscribe", themeID];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"theme_id"] = themeID;
            [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error = %@,  %@", error, operation);
                [subscriber sendError:error];
            }];
        }
        return [RACDisposable disposableWithBlock:^{
            ;
        }];
    }] deliverOnMainThread];
}

@end
