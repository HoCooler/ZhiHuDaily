//
//  MenuHeadView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/9/5.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MenuHeadView.h"
#import "UIColor+ZHDAddition.h"

@interface MenuHeadView()

@property (nonatomic, strong) UIView *userImage;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation MenuHeadView

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
    return CGSizeMake(SCREEN_WIDTH, 140);
}

- (void)updateConstraints
{
    CGFloat kButtonSpace = 10;
//    CGFloat klineSapce = 15;
    
    [self.userImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kButtonSpace);
        make.top.equalTo(self).offset(20);
        make.bottom.equalTo(self.leftButton.mas_top).offset(-10);
        make.width.equalTo(self.userImage.mas_height);
    }];
    
    [self.userLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImage.mas_right).offset(kButtonSpace);
        make.centerY.equalTo(self.userImage.mas_centerY);
        make.right.lessThanOrEqualTo(self);
        make.height.equalTo(@30);
    }];
    
    [self.leftButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kButtonSpace);
        make.height.equalTo(@36);
        make.bottom.equalTo(self);
    }];
    
    [self.middleButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftButton.mas_right).offset(kButtonSpace);
        make.bottom.top.equalTo(self.leftButton);
        make.width.equalTo(self.leftButton);
    }];
    
    [self.rightButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.middleButton.mas_right).offset(kButtonSpace);
        make.bottom.top.equalTo(self.leftButton);
        make.right.equalTo(self).offset(-kButtonSpace);
        make.width.equalTo(self.leftButton);
    }];
    
    [super updateConstraints];
}

-(UIView *)userImage
{
    if (!_userImage) {
        _userImage = [UIView new];
        _userImage.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:@"Menu_Avatar"];
        _userImage.layer.cornerRadius = image.size.width;
        _userImage.layer.masksToBounds = YES;
        _userImage.layer.borderWidth = 1;
        _userImage.layer.borderColor = [[UIColor whiteColor] CGColor];
        _userImage.layer.contents = (id)[image CGImage];
        [self addSubview:_userImage];
    }
    return _userImage;
}

-(UILabel *)userLabel
{
    if (!_userLabel) {
        _userLabel = [UILabel new];
        _userLabel.backgroundColor = [UIColor clearColor];
        _userLabel.text = @"请登录";
        [self addSubview:_userLabel];
    }
    return _userLabel;
}

-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton new];
        _leftButton.backgroundColor = [UIColor clearColor];
        [_leftButton setImage:[UIImage imageNamed:@"Menu_Icon_Message"] forState:UIControlStateNormal];
        [_leftButton setTitle:@" 消息" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}

-(UIButton *)middleButton
{
    if (!_middleButton) {
        _middleButton = [UIButton new];
        _middleButton.backgroundColor = [UIColor clearColor];
        [_middleButton setImage:[UIImage imageNamed:@"Menu_Icon_Collect"] forState:UIControlStateNormal];
        [_middleButton setTitle:@" 收藏" forState:UIControlStateNormal];
        _middleButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_middleButton];
    }
    return _middleButton;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton new];
        _rightButton.backgroundColor = [UIColor clearColor];
        [_rightButton setImage:[UIImage imageNamed:@"Menu_Download"] forState:UIControlStateNormal];
        [_rightButton setTitle:@" 离线下载" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

@end
