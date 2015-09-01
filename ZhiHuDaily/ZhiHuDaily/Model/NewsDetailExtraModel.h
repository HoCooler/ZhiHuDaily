//
//  NewsDetailExtraModel.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/9/1.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailExtraModel : NSObject

- (RACSignal *)fetchNewsDetailExtraWithNewsID:(NSString *)newsID;

@end
