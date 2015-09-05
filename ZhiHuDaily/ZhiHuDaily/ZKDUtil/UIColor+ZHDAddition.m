//
//  UIColor+ZHDAddition.m
//  ZhiHuDaily
//
//  Created by HoCooler on 15/8/30.
//  Copyright (c) 2015年 HoCooler. All rights reserved.
//

#import "UIColor+ZHDAddition.h"

@implementation UIColor(Addition)

+(UIColor *)ZHDbackgroundcolor
{
    return [UIColor ZHDbackgroundcolor:1.0f];
}

+(UIColor *)ZHDbackgroundcolor:(CGFloat)alpha
{
    return [UIColor colorWithRed:52.0/255 green:185.0/255 blue:253.0/255 alpha:alpha];
}
@end
