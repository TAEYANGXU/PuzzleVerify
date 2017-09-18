//
//  PatternPathProvider
//  LyFutureApp
//
//  Created by 徐琰璋 on 2017/9/13.
//  Copyright © 2017年 览益信息科技. All rights reserved.
//

#import "MockPuzzleVerifyView.h"

@interface MockPuzzleVerifyView (PatternPathProvider)

/**
 * Path for different puzzle pattern
 * @param pattern
 * @return
 */
+ (UIBezierPath *)verifyPathForPattern:(MockPuzzleVerifyPattern)pattern;

@end
