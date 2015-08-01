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

@property (nonatomic, strong) NSNumber *height;

@property (nonatomic, strong) NSArray *clickButtons;
@end

@implementation NewsBannerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.height = @(frame.size.height);
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.decelerationRate = 0.1;
        
        [self setContentOffset:CGPointMake(SCREEN_WIDTH, 0)];
    }
    return self;
}

- (void)updateConstraints
{
    CGFloat defaultSpace = 15.0;
    CGFloat textHeight = 2.0 / 3.0 * [self.height integerValue];
    if (self.banners.count > 0) {
        [self.imageViewArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height);
            make.left.top.equalTo(self);
            make.width.equalTo(@(SCREEN_WIDTH));
        }];

        [self.titlesArray[0] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(defaultSpace);
            make.top.equalTo(self).offset(textHeight);
            make.width.equalTo(@(SCREEN_WIDTH- 2*defaultSpace));
            make.height.equalTo(@50);
        }];
        
        [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@7);
            make.left.equalTo(((UILabel *)self.titlesArray[0]).mas_left).offset(SCREEN_WIDTH / 2 - 30);
            make.top.equalTo(((UILabel *)self.titlesArray[0]).mas_bottom).offset(5);
        }];
        
        [self.clickButtons[0] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.imageViewArray[0]);
        }];
    }
    
    for (NSInteger i = 1; i < self.banners.count; ++i) {
        [self.imageViewArray[i] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.left.equalTo(((UIImageView *)self.imageViewArray[i-1]).mas_right);
            make.top.equalTo(self);
        }];
        
        [self.titlesArray[i] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(i * SCREEN_WIDTH + defaultSpace);
            make.top.equalTo(self).offset(textHeight);
            make.width.equalTo(@(SCREEN_WIDTH- 2*defaultSpace));
            make.height.equalTo(@50);
        }];
        
        [self.clickButtons[i] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.imageViewArray[i]);
        }];
    }
    
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

        for (id subView in self.subviews) {
            [subView removeFromSuperview];
        }
        
        NSMutableArray *imageViews = [NSMutableArray new];
        NSMutableArray *titles = [NSMutableArray new];
        NSMutableArray *buttons = [NSMutableArray new];
        for (NSInteger i = 0; i < number; ++i) {
            NewsBannerItem *banner = banners[i];

            UIImageView *imageView = [UIImageView new];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            [imageViews addObject:imageView];
            [imageView sd_setImageWithURL:banner.imageURL];
            [self addSubview:imageView];
            
            UILabel *title = [UILabel new];
            title.numberOfLines = 3;
            title.text = banner.title;
            title.font = [UIFont boldSystemFontOfSize:20];
            title.textColor = [UIColor whiteColor];
            [titles addObject:title];
            [self addSubview:title];

            UIButton *button = [UIButton new];
            button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                if (self.jumpCommand && banner.newsID) {
                    [self.jumpCommand execute:banner.newsID];
                }
                return [RACSignal empty];
            }];
            [self addSubview:button];
            [buttons addObject:button];
        }
        
        self.imageViewArray = imageViews;
        self.titlesArray = titles;
        self.clickButtons = buttons;
        
        [self addSubview:self.pageControl];
        
        [self setNeedsUpdateConstraints];
    }
}

#pragma UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger number = [self.banners count];
    if (number > 1) {
        NSInteger index = floor((scrollView.contentOffset.x - SCREEN_WIDTH / 2) / SCREEN_WIDTH) + 1;
        self.pageControl.currentPage = index;
        [self setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
        
        [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@7);
            make.left.equalTo(((UILabel *)self.titlesArray[index]).mas_left).offset(SCREEN_WIDTH / 2 - 30);
            make.top.equalTo(((UILabel *)self.titlesArray[index]).mas_bottom).offset(5);
        }];
    }
}


@end
