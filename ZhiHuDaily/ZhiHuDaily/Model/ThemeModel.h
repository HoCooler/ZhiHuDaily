//
//  ThemeModel.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/28.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeModel : NSObject

-(RACSignal *)themeSubscribe: (NSString *)themeID;

-(RACSignal *)themeUnSubscribe: (NSString *)themeID;

@end
