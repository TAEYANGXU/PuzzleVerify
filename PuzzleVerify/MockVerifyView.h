//
//  MockVerifyView.h
//  TestDemo
//
//  Created by 徐琰璋 on 2017/9/13.
//  Copyright © 2017年 览益信息科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DrawDashLine.h"
#import "UIColor+Hex.h"

#undef      HEX
#define     HEX(HEX)        [UIColor colorWithHexString:HEX]

#undef      RGBA
#define     RGBA(R,G,B,A)    [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#define     SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define     SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@class MockVerifyView;
@protocol MockVerifyViewDelegate <NSObject>

@optional
-(void) mockVerifyViewVerifySuccess;

@end

@interface MockVerifyView : UIView

//事响应
@property (nonatomic,assign) id<MockVerifyViewDelegate>    delegate;

/**
 弹出滑动验证

 @param title 标题
 @param content 内容
 */
-(void) showVieWithTitle:(NSString *)title content:(NSAttributedString *)content;

@end
