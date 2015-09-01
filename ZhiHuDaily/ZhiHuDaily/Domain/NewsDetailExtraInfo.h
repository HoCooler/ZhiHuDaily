//
//  NewsDetailExtraInfo.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/9/1.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MTLModel.h"

@interface NewsDetailExtraInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, strong) NSString *voteNumber;
@property (nonatomic, strong) NSString *commentNumber;
@property (nonatomic, assign) BOOL voteStatus;

@end
