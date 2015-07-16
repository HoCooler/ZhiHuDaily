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
@end

@implementation NewsBannerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)updateConstraints
{
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(@160);
    }];
    
    [super updateConstraints];
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self addSubview:_imageView];
    }
    return _imageView;
}
@end
