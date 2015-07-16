//
//  newsListItem.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListItem : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *imagesURL; //NSArray of NSURL;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *newsID;
@property (nonatomic, assign) BOOL isMultiPic;

@end
