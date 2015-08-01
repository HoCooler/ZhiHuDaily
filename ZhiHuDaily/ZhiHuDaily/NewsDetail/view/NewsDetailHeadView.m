//
//  NewsDetailHeadView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/1.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailHeadView.h"

@interface NewsDetailHeadView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@end

@implementation NewsDetailHeadView

- (void)updateConstraints
{
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-20);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
    }];
    
    [self.sourceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel.mas_right);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    [super updateConstraints];
}

- (void)setHeadInfo:(NewsDetailInfo *)headInfo
{
    if (_headInfo != headInfo) {
        _headInfo = headInfo;
        if (headInfo.imageURL && headInfo.imageURL.absoluteString.length) {
            [self.imageView sd_setImageWithURL:headInfo.imageURL];
        }
        self.titleLabel.text = headInfo.title;
        self.sourceLabel.text = headInfo.imageSource;
    }
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.layer.cornerRadius = 2.0f;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)sourceLabel
{
    if (!_sourceLabel) {
        _sourceLabel = [UILabel new];
        _sourceLabel.font = [UIFont systemFontOfSize:10];
        _sourceLabel.textColor = [UIColor whiteColor];
        _sourceLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:_sourceLabel];
    }
    return _sourceLabel;
}
@end
