//
//  NewsDetailExtraInfo.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/9/1.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailExtraInfo.h"

@implementation NewsDetailExtraInfo

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@keypath(NewsDetailExtraInfo.new, voteNumber) : @"popularity",
              @keypath(NewsDetailExtraInfo.new, commentNumber) : @"comments",
//              @keypath(NewsDetailExtraInfo.new, voteStatus) : @"vote_status",
//              @keypath(NewsDetailExtraInfo.new, isFavorite) : @"favorite"
              };
}

+(NSValueTransformer *)voteNumberJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSNumber *value) {
        return [value stringValue];
    }];
}

+(NSValueTransformer *)commentNumberJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^id(NSNumber *value) {
        return [value stringValue];
    }];
}
@end
