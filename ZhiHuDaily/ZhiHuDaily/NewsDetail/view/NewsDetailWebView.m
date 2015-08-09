//
//  NewsDetailWebView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/25.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailWebView.h"

@interface NewsDetailWebView()
@end
@implementation NewsDetailWebView

- (id)initWithFrame:(CGRect)newFrame header:(UIView *)header
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin;
        self.delegate = self;
        
        self.frame = newFrame;
        self.headView = header;
//        self.scrollView.contentInset = UIEdgeInsetsMake(header.frame.size.height, 0.0f, 0.0f, 0.0f);
        self.headView.frame = CGRectMake(0, 0, header.frame.size.width, header.frame.size.height);
        [self.scrollView addSubview:self.headView];
    }
    return self;
}

- (void)setInfo:(NewsDetailInfo *)info
{
    if (![_info isEqual:info]) {
        _info = info;
        NSURL *cssURL = [NSURL URLWithString:(info.cssArray.count ? info.cssArray[0] : nil)];
        NSString *htmlString = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" type=\"text/css\" href=%@ /></head><body>%@</body></html>", cssURL.absoluteString, info.body];
        [self loadHTMLString:htmlString baseURL:nil];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //The default stick headView like tableView' HeadView
    float bottomOfHeaderView = MAX(0, -scrollView.contentOffset.y);
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(bottomOfHeaderView, 0, 0, 0);
    
}
@end
