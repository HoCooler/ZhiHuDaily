//
//  NewsBannerView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/16.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsBannerView.h"

@interface NewsBannerView()

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageViewArray;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation NewsBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        [self setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    }
    return self;
}

- (void)updateConstraints
{
    if (self.banners.count > 0) {
        [self.imageViewArray[0] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height);
            make.left.top.equalTo(self);
            make.width.equalTo(@(SCREEN_WIDTH));
        }];
        
        [self.titlesArray[0] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.left.equalTo(self.mas_left).offset(15);
            make.right.equalTo(((UIImageView *)self.imageViewArray[0]).mas_left).offset(-10);
            make.centerX.equalTo(((UIImageView *)self.imageViewArray[0]).mas_centerX);
        }];
    }
    
    for (NSInteger i = 1; i < self.banners.count; ++i) {
        [self.imageViewArray[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.left.equalTo(((UIImageView *)self.imageViewArray[i-1]).mas_right);
            make.top.equalTo(self);
        }];
        
        [self.titlesArray[i] mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-15);
            make.left.equalTo(((UIImageView *)self.imageViewArray[i]).mas_left).offset(15);
            make.right.equalTo(((UIImageView *)self.imageViewArray[i]).mas_right).offset(-10);
            make.centerX.equalTo(((UIImageView *)self.imageViewArray[i]).mas_centerX);
        }];
    }
    
    [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@7);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [super updateConstraints];
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)setBanners:(NSArray *)banners
{
    if (_banners != banners) {
        _banners = banners;
        NSInteger number = [self.banners count];
        if (number > 0) {
            [self setContentSize:CGSizeMake(self.frame.size.width * number, self.frame.size.height)];
        } else {
            [self setContentSize:CGSizeMake(self.frame.size.width, 0)];
        }
        
        self.pageControl.numberOfPages = number;

        for (UIImageView *imageView in self.imageViewArray) {
            [imageView removeFromSuperview];
        }
        
        for (UILabel *titleLabel in self.titlesArray) {
            [titleLabel removeFromSuperview];
        }
        
        NSMutableArray *imageViews = [NSMutableArray new];
        NSMutableArray *titles = [NSMutableArray new];
        for (NSInteger i = 0; i < number; ++i) {
            UIImageView *imageView = [UIImageView new];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            [imageViews addObject:imageView];
            [imageView sd_setImageWithURL:((NewsBannerItem *)banners[i]).imageURL];
            [self addSubview:imageView];
            
            UILabel *title = [UILabel new];
            title.numberOfLines = 3;
            title.text = ((NewsBannerItem *)banners[i]).title;
            [titles addObject:title];
//            [self addSubview:title];
            [self insertSubview:title aboveSubview:imageView];
        }
        
        self.imageViewArray = imageViews;
        self.titlesArray = titles;
        
        [self setNeedsUpdateConstraints];
    }
}

#pragma UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger number = [self.banners count];
    if (number > 1) {
        NSInteger index = floor((scrollView.contentOffset.x + SCREEN_WIDTH / 2) / SCREEN_WIDTH);
        self.pageControl.currentPage = index;
        [self setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}



@end
