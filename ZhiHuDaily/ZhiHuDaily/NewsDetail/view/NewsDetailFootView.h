//
//  NewsDetailFootView.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/30.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsDetailExtraInfo;

@interface NewsDetailFootView : UIView

@property (nonatomic, strong) NewsDetailExtraInfo *extraInfo;
@property (nonatomic, strong) RACCommand *backCommand;
@property (nonatomic, strong) RACCommand *nextCommand;

@end
