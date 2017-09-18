//
//  UIColor+Hex.h
//  LyLiveApp
//
//  Created by 徐琰璋 on 16/5/27.
//  Copyright © 2016年 LyLiveApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
