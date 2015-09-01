//
//  NewsDetailExtraModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/9/1.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailExtraModel.h"
#import "NewsDetailExtraInfo.h"

@implementation NewsDetailExtraModel

- (RACSignal *)fetchNewsDetailExtraWithNewsID:(NSString *)newsID
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSString *prefix = @"http://news-at.zhihu.com/api/4/story-extra/";
        NSString *path = [NSString stringWithFormat:@"%@%@", prefix, newsID];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
            
            if (!result && ![result isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Error :  The data formate Error");
                return;
            }
            
            NSError *error;
            NewsDetailExtraInfo *newsExtraInfo = [MTLJSONAdapter modelOfClass:[NewsDetailExtraInfo class] fromJSONDictionary:result error:&error];
            
            [subscriber sendNext:newsExtraInfo];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error = %@,  %@", error, operation);
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            ;
        }];
    }] deliverOnMainThread];
}

@end
