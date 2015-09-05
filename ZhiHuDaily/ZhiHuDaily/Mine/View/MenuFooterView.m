//
//  MenuFooterView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/9/5.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MenuFooterView.h"
#import "UIColor+ZHDAddition.h"

@interface MenuFooterView()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation MenuFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor ZHDbackgroundcolor];
    }
    return self;
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(SCREEN_WIDTH, 40);
}

-(void)updateConstraints
{
    CGFloat kButtonSpace = 20;
    [self.leftButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.top.equalTo(self);
    }];
    
    [self.rightButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kButtonSpace);
        make.left.equalTo(self.leftButton.mas_right).offset(kButtonSpace);
        make.bottom.top.equalTo(self);
        make.width.equalTo(self.leftButton);
    }];
    
    [super updateConstraints];
}

-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton new];
        _leftButton.backgroundColor = [UIColor redColor];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton new];
        _rightButton.backgroundColor = [UIColor redColor];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

@end
