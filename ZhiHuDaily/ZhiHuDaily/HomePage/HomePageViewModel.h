//
//  HomePageViewModel.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsListInfo.h"

@interface HomePageViewModel : NSObject

@property (nonatomic, strong) NSString *themeID;

@property (nonatomic, strong) RACCommand *fetchNewsListCommand;

@property (nonatomic, strong) NewsListInfo *newsListInfo;

-(instancetype)initWithThemeID:(NSString *)themeID;

@end
