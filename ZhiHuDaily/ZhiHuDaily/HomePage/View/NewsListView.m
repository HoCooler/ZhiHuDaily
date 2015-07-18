//
//  newsListView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/11.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsListView.h"
#import "NewsListCell.h"
#import "NewsListItem.h"

static NSString *cellIdentifier = @"newsListCell";

@interface NewsListView()

@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) NSDateFormatter *dateFormat;
@end

@implementation NewsListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.scrollsToTop = YES;
    }
    return self;
}

- (void)setNews:(NSArray *)news
{
    if (_news != news) {
        _news = news;
        [self reloadData];
    }
}

- (void)setNewsDate:(NSDate *)newsDate
{
    if (_newsDate != newsDate) {
        _newsDate = newsDate;
        self.dateLabel.text = [self.dateFormat stringFromDate:newsDate];
    }
}

//- (void)updateConstraints
//{
//    [self.dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(10);
//        make.top.equalTo(self.mas_top).offset(10);
//    }];
//    
//    
//    [super updateConstraints];
//}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (NSDateFormatter *)dateFormat
{
    if (!_dateFormat) {
        _dateFormat = [NSDateFormatter new];
        [_dateFormat setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormat;
}

# pragma UITableView 

//TODO
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ((NewsListCell *)cell).newsItem = self.news[indexPath.row];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.dateFormat stringFromDate:self.newsDate];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   //TODO
}
@end
