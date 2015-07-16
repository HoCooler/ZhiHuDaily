//
//  newsListItem.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsListItem.h"

@implementation NewsListItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@keypath(NewsListItem.new, title) : @"title",
              @keypath(NewsListItem.new, newsID) : @"id",
              @keypath(NewsListItem.new, imagesURL) : @"images",
              @keypath(NewsListItem.new, isMultiPic) : @"multipic"
             };
}

+ (NSValueTransformer *)imageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)newsIDJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%f", [number floatValue]];
    }];
}
@end
