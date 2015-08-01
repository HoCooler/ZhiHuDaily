//
//  newsListView.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/11.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListItem.h"

@interface NewsListView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *news; //NSArray of NewsListItem;
@property (nonatomic, strong) NSDate *newsDate;

@property (nonatomic, strong) RACCommand *jumpCommand;

@end
