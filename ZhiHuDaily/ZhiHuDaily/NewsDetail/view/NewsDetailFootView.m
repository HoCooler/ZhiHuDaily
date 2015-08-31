//
//  NewsDetailFootView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/30.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailFootView.h"
#import "UIColor+ZHDAddition.h"

@interface NewsDetailFootView()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *shareButton;//学习遮盖层
@property (nonatomic, strong) UIButton *voteButton; //animotion
@property (nonatomic, strong) UIButton *commentButton;

@end

@implementation NewsDetailFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)updateConstraints
{
    CGFloat kButtonSpace = 10.0f;
    
    [self.backButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
    }];
    
    [self.nextButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton.mas_right).offset(kButtonSpace);
        make.top.bottom.equalTo(self.backButton);
        make.width.equalTo(self.backButton.mas_width);
    }];
    
    [self.voteButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nextButton.mas_right).offset(kButtonSpace);
        make.top.bottom.equalTo(self.backButton);
        make.width.equalTo(self.backButton.mas_width);
    }];
    
    [self.shareButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.voteButton.mas_right).offset(kButtonSpace);
        make.top.bottom.equalTo(self.backButton);
        make.width.equalTo(self.backButton.mas_width);
    }];
    
    [self.commentButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareButton.mas_right).offset(kButtonSpace);
        make.top.bottom.equalTo(self.backButton);
        make.width.equalTo(self.backButton.mas_width);
        make.right.equalTo(self);
    }];
    
    [super updateConstraints];
}

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton new];
        _backButton.backgroundColor = [UIColor ZHDbackgroundcolor];
        [self addSubview:_backButton];
    }
    return _backButton;
}

-(UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton new];
        _nextButton.backgroundColor = [UIColor ZHDbackgroundcolor];
        [self addSubview:_nextButton];
    }
    return _nextButton;
}

-(UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton new];
        _shareButton.backgroundColor = [UIColor ZHDbackgroundcolor];
        [self addSubview:_shareButton];
    }
    return _shareButton;
}

-(UIButton *)voteButton
{
    if (!_voteButton) {
        _voteButton = [UIButton new];
        _voteButton.backgroundColor = [UIColor ZHDbackgroundcolor];
        [self addSubview:_voteButton];
    }
    return _voteButton;
}

-(UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [UIButton new];
        _commentButton.backgroundColor = [UIColor ZHDbackgroundcolor];
        [self addSubview:_commentButton];
    }
    return _commentButton;
}

@end
