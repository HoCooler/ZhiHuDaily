//
//  NewsDetailFootView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/30.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailFootView.h"
#import "UIColor+ZHDAddition.h"
#import "NewsDetailExtraInfo.h"
#import "TKAlertCenter.h"

@interface NewsDetailFootView()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *shareButton;//学习遮盖层
@property (nonatomic, strong) UIButton *voteButton; //学习animotion
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UILabel *commentNumberLabel;
@property (nonatomic, strong) UILabel *voteNumberLabel;

@property (nonatomic, assign) BOOL isVoted;
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
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(kButtonSpace);
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
        make.right.equalTo(self).offset(-kButtonSpace);
    }];
    
    [self.commentNumberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commentButton.mas_centerY).offset(-8);
        make.centerX.equalTo(self.commentButton.mas_centerX).offset(8);
    }];
    
    [self.voteNumberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.voteButton.mas_centerY).offset(-8);
        make.centerX.equalTo(self.voteButton.mas_centerX).offset(12);
    }];
    
    [super updateConstraints];
}

-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton new];
        _backButton.backgroundColor = [UIColor clearColor];
        [_backButton setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
        @weakify(self)
        _backButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if (self.backCommand) {
                [self.backCommand execute:nil];
            }
            return [RACSignal empty];
        }];
        [self addSubview:_backButton];
    }
    return _backButton;
}

-(UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton new];
        _nextButton.backgroundColor = [UIColor clearColor];
        @weakify(self)
        _nextButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if (self.nextCommand) {
                [self.nextCommand execute:nil];
            }
            return [RACSignal empty];
        }];
        
        [_nextButton setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
        [self addSubview:_nextButton];
    }
    return _nextButton;
}

-(UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton new];
        _shareButton.backgroundColor = [UIColor clearColor];
        [_shareButton setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
        @weakify(self)
        _shareButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"I should have presented a viewController here, but I'm too lazy! " message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"I know", nil];
            [alertView show];
            return [RACSignal empty];
        }];
        [self addSubview:_shareButton];
    }
    return _shareButton;
}

-(UIButton *)voteButton
{
    if (!_voteButton) {
        _voteButton = [UIButton new];
        _voteButton.backgroundColor = [UIColor clearColor];
        [_voteButton setImage:[UIImage imageNamed:@"News_Navigation_Vote"] forState:UIControlStateNormal];
        @weakify(self)
        _voteButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if (self.isVoted) {
                [self.voteButton setImage:[UIImage imageNamed:@"News_Navigation_Vote"] forState:UIControlStateNormal];
                self.extraInfo.voteNumber = [@([self.extraInfo.voteNumber integerValue] - 1) stringValue];
            } else {
                [self.voteButton setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateNormal];
                self.extraInfo.voteNumber = [@([self.extraInfo.voteNumber integerValue] + 1) stringValue];
            }
            
            [[TKAlertCenter defaultCenter] postAlertWithMessage:(self.isVoted ? @"-1" : @"+1")];
            self.isVoted = !self.isVoted;
            self.voteNumberLabel.text = self.extraInfo.voteNumber;

            //Should add the request here;

            return [RACSignal empty];
        }];
        [self addSubview:_voteButton];
    }
    return _voteButton;
}

-(UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [UIButton new];
        _commentButton.backgroundColor = [UIColor clearColor];
        [_commentButton setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
        @weakify(self)
        _commentButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"I should have jumped a  new viewController, but I'm too lazy! " message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"I know", nil];
            [alertView show];
            return [RACSignal empty];
        }];
        [self addSubview:_commentButton];
    }
    return _commentButton;
}

-(UILabel *)commentNumberLabel
{
    if (!_commentNumberLabel) {
        _commentNumberLabel = [UILabel new];
        _commentNumberLabel.font = [UIFont systemFontOfSize:8];
        _commentNumberLabel.text = @"...";
        [self addSubview:_commentNumberLabel];
    }
    return _commentNumberLabel;
}

-(UILabel *)voteNumberLabel
{
    if (!_voteNumberLabel) {
        _voteNumberLabel = [UILabel new];
        _voteNumberLabel.font = [UIFont systemFontOfSize:8];
        [self addSubview:_voteNumberLabel];
    }
    return _voteNumberLabel;
}

-(void)setExtraInfo:(NewsDetailExtraInfo *)extraInfo
{
    if (_extraInfo != extraInfo) {
        _extraInfo = extraInfo;
        self.commentNumberLabel.text = extraInfo.commentNumber;
        self.voteNumberLabel.text = extraInfo.voteNumber;
        
        //other Information should set here;
    }
}
@end
