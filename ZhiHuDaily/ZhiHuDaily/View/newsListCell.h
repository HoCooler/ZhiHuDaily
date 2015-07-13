//
//  newsListCell.h
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/11.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListItem.h"

@interface newsListCell : UITableViewCell

//@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NewsListItem *newsItem;

@end
