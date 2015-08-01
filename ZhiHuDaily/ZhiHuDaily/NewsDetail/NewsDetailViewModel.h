//
//  NewsDetailViewModel.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/26.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailInfo.h"

@interface NewsDetailViewModel : NSObject

@property (nonatomic, strong) NSString *newsID;

@property (nonatomic, strong) NewsDetailInfo *info;
@property (nonatomic, strong) RACCommand *fetchNewsDetailCommand;

@end
