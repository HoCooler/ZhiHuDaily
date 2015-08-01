//
//  newsListCell.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/11.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListItem.h"

@interface NewsListCell : UITableViewCell

@property (nonatomic, strong) NewsListItem *newsItem;

- (void)didSelectCell;

@end
