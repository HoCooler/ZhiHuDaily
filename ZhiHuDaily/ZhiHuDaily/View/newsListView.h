//
//  newsListView.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/11.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListInfo.h"

@interface newsListView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NewsListInfo *newsDataSource;

@end
