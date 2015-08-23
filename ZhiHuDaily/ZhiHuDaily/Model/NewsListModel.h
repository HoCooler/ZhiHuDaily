//
//  NewsListModel.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListModel : NSObject

- (instancetype)initWithThemeID:(NSString *)themeID;

- (RACSignal *)fetchNewsList;
@end
