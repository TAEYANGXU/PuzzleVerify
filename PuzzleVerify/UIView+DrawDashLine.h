//
//  UIView+DrawDashLine.h
//  LyCompassApp
//
//  Created by 徐琰璋 on 16/8/4.
//  Copyright © 2016年 上海览益信息科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DrawDashLine)

/**
 *  绘制虚线
 *
 *  @param lineView   父视图
 *  @param startPoint 起始位置
 *  @param endPoint   终点
 *  @param lineColor  虚线颜色
 */
+ (void)drawDashLine:(UIView *)lineView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor;

@end
