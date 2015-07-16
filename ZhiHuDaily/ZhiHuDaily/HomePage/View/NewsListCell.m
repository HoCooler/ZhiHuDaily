//
//  newsListCell.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/11.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsListCell.h"

@interface NewsListCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImageView *multiPicFlagImageView;
@end

@implementation NewsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
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
    
    [self.multiPicFlagImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.headImageView);
        make.height.equalTo(@15);
        make.width.equalTo(@25);
    }];
    
    [super updateConstraints];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        [self addSubview:_headImageView];
    }
    return _headImageView;
}

- (UIImageView *)multiPicFlagImageView
{
    if (!_multiPicFlagImageView) {
        _multiPicFlagImageView = [UIImageView new];
        UILabel *multiPicLabel = [[UILabel alloc] init];
        multiPicLabel.text = @"多图";
        multiPicLabel.textAlignment = NSTextAlignmentRight;
        multiPicLabel.font = [UIFont systemFontOfSize:8];
        multiPicLabel.textColor = [UIColor whiteColor];
        [_multiPicFlagImageView addSubview:multiPicLabel];
        [multiPicLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_multiPicFlagImageView);
        }];
        _multiPicFlagImageView.backgroundColor = [UIColor colorWithRed:0x33 green:0x33 blue:0x33 alpha:0.2];
        [self addSubview:_multiPicFlagImageView];
    }
    return _multiPicFlagImageView;
}

- (void)setNewsItem:(NewsListItem *)newsItem
{
    if (_newsItem != newsItem) {
        _newsItem = newsItem;
        self.titleLabel.text = newsItem.title;
        if ([newsItem.imagesURL count]) {
            [self.headImageView sd_setImageWithURL:newsItem.imagesURL[0]];
        }
        self.multiPicFlagImageView.hidden = newsItem.isMultiPic;
    }
}

@end
