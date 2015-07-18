//
//  NewsBannerItem.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/18.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsBannerItem.h"

@implementation NewsBannerItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
   return @{@keypath(NewsBannerItem.new, title) : @"title",
       @keypath(NewsBannerItem.new, newsID) :@"id",
       @keypath(NewsBannerItem.new, imageURL) :@"image"
       };
}

+ (NSValueTransformer *)imageURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
