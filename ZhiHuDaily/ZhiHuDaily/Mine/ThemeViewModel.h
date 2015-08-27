//
//  ThemeViewModel.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/28.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeViewModel : NSObject

@property (nonatomic, strong)NSString *themeID;
-(RACCommand *)themeSubscribeCommand;
-(RACCommand *)themeUnSubscribeCommand;

@end
