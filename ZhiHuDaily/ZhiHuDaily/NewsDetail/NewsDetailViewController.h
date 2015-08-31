//
//  NewsDetailViewController.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/25.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController

@property (nonatomic, strong) NSString *newsID;
@property (nonatomic, strong) NSArray *newsListItems;
@property (nonatomic, assign) NSInteger index;

@end
