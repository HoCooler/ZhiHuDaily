//
//  newListInfo.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/8.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsListInfo.h"
#import "NewsListItem.h"
#import "NewsBannerView.h"

@implementation NewsListInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@keypath(NewsListInfo.new, newsDate): @"date",
              @keypath(NewsListInfo.new, items): @"stories",
              @keypath(NewsListInfo.new, banners) : @"top_stories"
    };
}

+ (NSValueTransformer *)bannersJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSArray *banners) {
        return [[[banners rac_sequence] map:^id(NSDictionary *value) {
            return [MTLJSONAdapter modelOfClass:[NewsBannerItem class] fromJSONDictionary:value error:nil];
        }] array];
    }];
}

+ (NSValueTransformer *)newsDateJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSNumber *num) {
        if ([num longLongValue] > 0) {
            return [NSDate dateWithTimeIntervalSince1970:[num doubleValue]];
        }
        return nil;
    }];
}

+ (NSValueTransformer *)itemsJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSArray *items) {
        return [[[items rac_sequence] map:^id(NSDictionary *value) {
            return [MTLJSONAdapter modelOfClass:[NewsListItem class] fromJSONDictionary:value error:nil];
        }] array];
    }];
}

@end
