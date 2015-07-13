//
//  newsListCell.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/11.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "newsListCell.h"

@interface newsListCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@end

@implementation newsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self updateConstraints];
    }
    return self;
}

- (void) updateConstraints
{
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        //        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 5));
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];

    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self.headImageView.mas_top);
        make.bottom.lessThanOrEqualTo(self.headImageView.mas_bottom);
        make.right.equalTo(self.headImageView.mas_left).offset(-10);
    }];
    
    [super updateConstraints];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
    }
    return _headImageView;
}

- (void)setNewsItem:(NewsListItem *)newsItem
{
    if (_newsItem != newsItem) {
        _newsItem = newsItem;
        self.titleLabel.text = newsItem.title;
        if ([newsItem.imagesURL count]) {
            [self.headImageView sd_setImageWithURL:newsItem.imagesURL[0]];
        }
    }
}

@end
