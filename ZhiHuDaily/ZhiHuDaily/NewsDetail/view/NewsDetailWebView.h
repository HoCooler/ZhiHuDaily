//
//  NewsDetailWebView.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/25.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailInfo.h"

@interface NewsDetailWebView : UIWebView<UIWebViewDelegate>

@property (nonatomic, strong) NewsDetailInfo *info;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) RACCommand *previousCommand;

- (id)initWithFrame:(CGRect)newFrame header:(UIView *)header;
@end
