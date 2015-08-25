//
//  NewsBannerView.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/16.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsBannerItem.h"

@interface NewsBannerView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *banners; // NSArray of NewsBannerItem

@property (nonatomic, strong) RACCommand *jumpCommand;

@end
