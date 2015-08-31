//
//  NewsDetailWebView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/7/25.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "NewsDetailWebView.h"

@interface NewsDetailWebView()

@property (nonatomic, assign) CGSize headViewSize;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

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
        _headViewSize = header.frame.size;
        self.backgroundColor = [UIColor whiteColor];
        self.headView.frame = CGRectMake(0, 0, header.frame.size.width, header.frame.size.height);
        [self.scrollView addSubview:self.headView];
        
        _refreshControl = [UIRefreshControl new];
        [self.refreshControl addTarget:self action:@selector(LoadPreviousNews) forControlEvents:UIControlEventValueChanged];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"上拉获取上一篇"];
        [self.scrollView addSubview:self.refreshControl];
    }
    return self;
}

- (void)LoadPreviousNews
{
    if(self.previousCommand){
        [self.previousCommand execute:nil];
    }
    
    if (self.refreshControl.isRefreshing) {
        [self.refreshControl endRefreshing];
    }
}

- (void)setInfo:(NewsDetailInfo *)info
{
    if (![_info isEqual:info]) {
        _info = info;
        
        if (info.imageURL.absoluteString.length) {
            self.headView.frame = CGRectMake(0, 0, self.headViewSize.width, self.headViewSize.height);
        } else {
            self.headView.frame = CGRectMake(0, 0, self.headViewSize.width, 0);
        }
        
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
