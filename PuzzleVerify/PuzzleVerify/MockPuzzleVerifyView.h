//
//  MockPuzzleVerifyView.h
//  LyFutureApp
//
//  Created by 徐琰璋 on 2017/9/13.
//  Copyright © 2017年 览益信息科技. All rights reserved.
//
#import <UIKit/UIKit.h>

/**
 * MockPuzzleVerifyView pattern type
 */
typedef NS_ENUM(NSInteger, MockPuzzleVerifyPattern) {
    MockPuzzleVerifyClassicPattern = 0, // Default
    MockPuzzleVerifySquarePattern,
    MockPuzzleVerifyCirclePattern,
    MockPuzzleVerifyCustomPattern
};

@class MockPuzzleVerifyView;

/**
 * Verification changed callback delegate
 */
@protocol MockPuzzleVerifyViewDelegate <NSObject>
@optional
- (void)puzzleVerifyView:(MockPuzzleVerifyView *)puzzleVerifyView didChangedVerification:(BOOL)isVerified;

- (void)puzzleVerifyView:(MockPuzzleVerifyView *)puzzleVerifyView didChangedPuzzlePosition:(CGPoint)newPosition
             xPercentage:(CGFloat)xPercentage yPercentage:(CGFloat)yPercentage;
@end

/**
 * MockPuzzleVerifyView
 */
@interface MockPuzzleVerifyView : UIView
@property (nonatomic, strong) UIImage *image; // Image for verification

// Puzzle pattern, default is MockPuzzleVerifyClassicPattern
@property (nonatomic, assign) MockPuzzleVerifyPattern puzzlePattern;

// Custom path for puzzle shape. Only work when puzzlePattern is MockPuzzleVerifyCustomPattern
@property (nonatomic, strong) UIBezierPath *customPuzzlePatternPath;

// Puzzle rect size，not for MockPuzzleVerifyCustomPattern pattern
@property (nonatomic, assign) CGSize puzzleSize;

// Puzzle blank position
@property (nonatomic, assign) CGPoint puzzleBlankPosition;

// Puzzle current position
@property (nonatomic, assign) CGPoint puzzlePosition;

// Puzzle current X and Y position percentage, range: [0, 1]
@property (nonatomic, assign) CGFloat puzzleXPercentage;
@property (nonatomic, assign) CGFloat puzzleYPercentage;

// Verification
@property (nonatomic, assign) CGFloat verificationTolerance; // Verification tolerance, default is 8
@property (nonatomic, assign, readonly) BOOL isVerified; // Verification boolean

// Enable
@property (nonatomic, assign) BOOL enable;

/**
 * Style
 */

// Puzzle blank alpha, default is 0.5
@property (nonatomic, assign) CGFloat puzzleBlankAlpha;

// Puzzle blank inner shadow
@property (nonatomic, strong) UIColor *puzzleBlankInnerShadowColor; // Default: black
@property (nonatomic, assign) CGFloat puzzleBlankInnerShadowRadius; // Default: 4
@property (nonatomic, assign) CGFloat puzzleBlankInnerShadowOpacity; // Default: 0.5
@property (nonatomic, assign) CGSize puzzleBlankInnerShadowOffset; // Default: (0, 0)

// Puzzle shadow
@property (nonatomic, strong) UIColor *puzzleShadowColor; // Default: black
@property (nonatomic, assign) CGFloat puzzleShadowRadius; // Default: 4
@property (nonatomic, assign) CGFloat puzzleShadowOpacity; // Default: 0.5
@property (nonatomic, assign) CGSize puzzleShadowOffset; // Default: (0, 0)

// Callback
@property (nonatomic, weak) id <MockPuzzleVerifyViewDelegate> delegate; // Callback delegate
@property (nonatomic, copy) void (^verificationChangeBlock)(MockPuzzleVerifyView *puzzleVerifyView, BOOL isVerified); // verification changed callback block


/**
 Complete verification. Call this with set the puzzle to its original position and fill the blank.

 @param withAnimation if show animation
 */
- (void)completeVerificationWithAnimation:(BOOL)withAnimation;

@end
