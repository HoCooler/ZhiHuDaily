//
//  MenuTableView.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/9.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MenuTableView.h"

@interface MenuTableView ()

@property (nonatomic, strong) NSArray *themeNames;  //主题名称
@property (nonatomic, strong) NSArray *themeStatus; //主题是否被订阅
@property (nonatomic, strong) NSArray *orders; //默认列表展示顺序（版本号：2.5.2）
//@property (nonatomic, strong) 
@end

@implementation MenuTableView

- (id)init
{
    self = [super init];
    if (self) {
        _themeNames = @[@"首页"/*1*/, @"开始游戏"/*2*/, @"电影日报"/*3*/, @"设计日报"/*4*/, @"大公司日报"/*5*/, @"财经日报"/*6*/, @"音乐日报"/*7*/, @"体育日报"/*8*/, @"动漫日报"/*9*/, @"互联网安全"/*10*/, @"不许无聊"/*11*/, @"用户推荐日报"/*12*/, @"日常心理学"/*13*/];
        _orders = @[@1, @13, @12, @3, @11, @4, @5, @6, @10, @2, @7, @9, @8];
        _themeStatus = @[@YES, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO];
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
    
    cell.textLabel.text = self.themeNames[[self.orders[indexPath.row] integerValue] - 1];
    
    NSInteger index = [self.orders[indexPath.row] integerValue] - 1;
    
    UIButton *subscribeButton = [UIButton new];
    subscribeButton.backgroundColor = [UIColor clearColor];
    [subscribeButton addTarget:self action:@selector(tapSubscribe:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.themeStatus[index] boolValue]) {
        if (index == 0) {
            [subscribeButton setTitle:@"" forState:UIControlStateNormal];
        } else {
            [subscribeButton setTitle:@">" forState:UIControlStateNormal];
        }
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
    
    return cell;
}

- (void)tapSubscribe:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *subButton = (UIButton *)sender;
        if ([subButton.currentTitle isEqual:@"+"]) {
            [subButton setTitle:@">" forState:UIControlStateNormal];
        }
    }
}

@end
