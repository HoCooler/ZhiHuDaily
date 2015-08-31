//
//  NewsDetailModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/26.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailModel.h"
#import "NewsDetailInfo.h"

@implementation NewsDetailModel

- (RACSignal *)fetchNewsDetailWithNewsID:(NSString *)newsID
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSString *prefix = @"http://news-at.zhihu.com/api/4/story/";
        NSString *path = [NSString stringWithFormat:@"%@%@", prefix, newsID];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
            
            if (!result && ![result isKindOfClass:[NSDictionary class]]) {
                NSLog(@"Error :  The data formate Error");
                return;
            }
            
            NSError *error;
            NewsDetailInfo *newsInfo = [MTLJSONAdapter modelOfClass:[NewsDetailInfo class] fromJSONDictionary:result error:&error];
            
            [subscriber sendNext:newsInfo];
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
