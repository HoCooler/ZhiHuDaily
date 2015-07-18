//
//  newsListInfo.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/8.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsListItem.h"

@interface NewsListInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSDate *newsDate;
@property (nonatomic, strong) NSArray *items; //Array of NewsListItem
@property (nonatomic, strong) NSArray *banners; // NSArray of NewsBannerItem

@end
