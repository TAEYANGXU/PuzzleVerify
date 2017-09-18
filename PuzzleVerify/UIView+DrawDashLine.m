//
//  UIView+DrawDashLine.m
//  LyCompassApp
//
//  Created by 徐琰璋 on 16/8/4.
//  Copyright © 2016年 上海览益信息科技有限公司. All rights reserved.
//

#import "UIView+DrawDashLine.h"

@implementation UIView (DrawDashLine)

/**
 *  绘制虚线
 *
 *  @param lineView   父视图
 *  @param startPoint 起始位置
 *  @param endPoint   终点
 *  @param lineColor  虚线颜色
 */
+ (void)drawDashLine:(UIView *)lineView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor
{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:lineView.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[lineColor CGColor]];
    
    // 设置虚线的高度1.0f
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 设置每条线的宽度1 设置每条线的间距2
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
      [NSNumber numberWithInt:2],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    // x，y代表初始坐标
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    // x，y代表终点坐标
    CGPathAddLineToPoint(path, NULL, endPoint.x,endPoint.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [lineView.layer addSublayer:shapeLayer];
    
}

@end
