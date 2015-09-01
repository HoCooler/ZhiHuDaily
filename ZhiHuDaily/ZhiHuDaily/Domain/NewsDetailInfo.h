//
//  NewsDetailInfo.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/25.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MTLModel.h"

@interface NewsDetailInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *newsID;
@property (nonatomic, strong) NSString *imageSource;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *shareURL;
@property (nonatomic, strong) NSArray *cssArray;
@property (nonatomic, strong) NSString *body;

@end
