//
//  MineViewController.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/8.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // configure under left view controller
        self.view.layer.borderWidth     = 1;
        self.view.layer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
        self.view.layer.borderColor     = [UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
        self.edgesForExtendedLayout     = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft; // don't go under the top view
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
