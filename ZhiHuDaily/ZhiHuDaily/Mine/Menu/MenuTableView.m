//
//  MenuTableView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/9.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MenuTableView.h"
#import "HomePageViewController.h"

@interface MenuTableView ()

@property (nonatomic, strong) NSArray *themeNames;  //主题名称
@property (nonatomic, strong) NSArray *themeStatus; //主题是否被订阅
@property (nonatomic, strong) NSArray *orders; //默认列表展示顺序（版本号：2.5.2）
@end

@implementation MenuTableView

- (id)init
{
    self = [super init];
    if (self) {
        _themeNames = @[@"首页"/*1*/, @"开始游戏"/*2*/, @"电影日报"/*3*/, @"设计日报"/*4*/, @"大公司日报"/*5*/, @"财经日报"/*6*/, @"音乐日报"/*7*/, @"体育日报"/*8*/, @"动漫日报"/*9*/, @"互联网安全"/*10*/, @"不许无聊"/*11*/, @"用户推荐日报"/*12*/, @"日常心理学"/*13*/];
        _orders = @[@1, @13, @12, @3, @11, @4, @5, @6, @10, @2, @7, @9, @8];
        _themeStatus = @[@YES/*NO USE*/, @YES, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.themeNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kThemeIdentifier = @"themeResueIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kThemeIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kThemeIdentifier];
    }
    
    NSInteger index = [self.orders[indexPath.row] integerValue];

    cell.textLabel.text = self.themeNames[index - 1];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIButton *subscribeButton = [UIButton new];
    subscribeButton.backgroundColor = [UIColor clearColor];
    @weakify(self)
    subscribeButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        if (![self.themeStatus[index] boolValue]) {
            [self themeReorder:index];
        }
        return [RACSignal empty];
    }];
    if ([self.themeStatus[index] boolValue]) {
        [subscribeButton setTitle:@">" forState:UIControlStateNormal];
    } else {
        [subscribeButton setTitle:@"+" forState:UIControlStateNormal];
    }
    [subscribeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [cell.contentView addSubview:subscribeButton];
    
    [subscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView.mas_right).offset(-5);
        make.top.bottom.equalTo(cell.contentView);
        make.width.equalTo(@40);
    }];
    
    UIButton *jumpButton = [UIButton new];
    jumpButton.backgroundColor = [UIColor clearColor];
    jumpButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        return [RACSignal empty];
    }];
    return cell;
}

- (void)themeReorder:(NSInteger )index
{
    NSMutableArray *newThemeStatus = [NSMutableArray arrayWithArray:self.themeStatus];
    NSMutableArray *newOrders = [NSMutableArray arrayWithArray:self.orders];
    
    for (NSInteger i = 0; i < self.themeStatus.count - 1; ++i) {
        NSInteger trueIndex = [self.orders[i] integerValue];
        if (![self.themeStatus[trueIndex] boolValue]) {
            newThemeStatus[index] = @YES;
            [newOrders removeObject:@(index)];
            [newOrders insertObject:@(index) atIndex:i];
            i = self.themeStatus.count;
        }
    }
    
    self.orders = [newOrders copy];
    self.themeStatus = [newThemeStatus copy];
    
    [self reloadData];
}

@end
