//
//  NewsDetailExtraViewModel.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/9/1.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailExtraInfo.h"

@interface NewsDetailExtraViewModel : NSObject

@property (nonatomic, strong) NSString *newsID;
@property (nonatomic, strong) NewsDetailExtraInfo *extraInfo;
@property (nonatomic, strong) RACCommand *fetchNewsDetailExtraCommand;

@end
