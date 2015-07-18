//
//  NewsBannerItem.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/18.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MTLModel.h"

@interface NewsBannerItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *newsID;
@property (nonatomic, strong) NSURL *imageURL;
@end
