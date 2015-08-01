//
//  NewsDetailModel.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/26.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject

- (RACSignal *)fetchNewsDetailWithNewsID:(NSString *)newsID;

@end
