//
//  NewsBannerView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/16.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsBannerView.h"

@interface NewsBannerView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation NewsBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setContentSize:CGSizeMake(self.frame.size.width, 0)];
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;

        _imageView = [UIImageView new];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_imageView];
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 3;
        [self addSubview:_titleLabel];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.imageView.mas_bottom).offset(-20);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
        }];
        
        _pageControl = [UIPageControl new];
        [self addSubview:_pageControl];
        [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.height.equalTo(@12);
            make.bottom.equalTo(self.titleLabel.mas_bottom).offset(5);
        }];
        
    }
    return self;
}

- (void)updateSize
{
    NSInteger number = [self.banners count];

    if (number > 0) {
//        [self setContentSize:CGSizeMake(self.frame.size.width * number, 160)];
    } else {
//        [self setContentSize:CGSizeMake(self.frame.size.width, 0)];
    }
}

- (void)setBanners:(NSArray *)banners
{
    if (_banners != banners) {
        _banners = banners;
        [self updateSize];
        self.pageControl.numberOfPages = [self.banners count];
        NewsBannerItem *banner = self.banners[self.currentIndex];
        [self.imageView sd_setImageWithURL:banner.imageURL];
        self.titleLabel.text = banner.title;
    }
}
@end
