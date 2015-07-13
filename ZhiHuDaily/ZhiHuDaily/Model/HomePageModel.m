//
//  HomePageModel.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "HomePageModel.h"
#import "NewsListInfo.h"
#import "NewsListItem.h"

@implementation HomePageModel

- (RACSignal *)fetchNewsList
{
 
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSString *path = @"http://news-at.zhihu.com/api/4/story/latest";
        NSString *path = @"http://news-at.zhihu.com/api/4/news/latest";
        
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
