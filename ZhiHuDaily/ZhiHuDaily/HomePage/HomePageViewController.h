//
//  HomePageViewController.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/7.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController

@property (nonatomic, strong) NSString *themeID;

- (instancetype)initWithThemeID:(NSString *)themeID;

@end
