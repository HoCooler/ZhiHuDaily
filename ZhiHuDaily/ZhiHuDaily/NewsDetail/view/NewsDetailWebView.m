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
        self.scrollView.contentInset = UIEdgeInsetsMake(self.headView.frame.size.height, 0.0f, 0.0f, 0.0f);
        self.headView.frame = CGRectMake(0, 0, self.headView.frame.size.width, -self.headView.frame.size.height);
        [self.scrollView addSubview:self.headView];
    }
    return self;
}

- (void)setInfo:(NewsDetailInfo *)info
{
    if (![_info isEqual:info]) {
        _info = info;
        NSURL *url = [NSURL URLWithString:(info.cssArray.count ? info.cssArray[0] : nil)];
        [self loadHTMLString:info.body baseURL:url];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Web - Request-URL : %@",request.URL);
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //The default stick headView like tableView' HeadView
    float bottomOfHeaderView = MAX(0, -scrollView.contentOffset.y);
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(bottomOfHeaderView, 0, 0, 0);
    
}
@end
