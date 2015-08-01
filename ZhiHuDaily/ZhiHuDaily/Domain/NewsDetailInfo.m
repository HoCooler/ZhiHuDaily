//
//  NewsDetailInfo.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/25.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailInfo.h"

@implementation NewsDetailInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@keypath(NewsDetailInfo.new, newsID) : @"id",
              @keypath(NewsDetailInfo.new, title) : @"title",
              @keypath(NewsDetailInfo.new, body) : @"body",
              @keypath(NewsDetailInfo.new, imageSource) : @"image_source",
              @keypath(NewsDetailInfo.new, shareURL) : @"share_url",
              @keypath(NewsDetailInfo.new, cssArray) : @"css",
              @keypath(NewsDetailInfo.new, imageURL) : @"image"
              };
}

+ (NSValueTransformer *)imageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)shareURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
