//
//  MockVerifyView.m
//  TestDemo
//
//  Created by 徐琰璋 on 2017/9/13.
//  Copyright © 2017年 览益信息科技. All rights reserved.
//

#import "MockVerifyView.h"
#import "MockPuzzleVerifyView.h"
#import "Masonry.h"

@interface MockVerifyView()<MockPuzzleVerifyViewDelegate>

@property(nonatomic,strong) UIView                  *bgView;
@property(nonatomic,strong) UILabel                 *titleLabel;
@property(nonatomic,strong) UILabel                 *contentLabel;
@property(nonatomic,strong) UIView                  *contentView;

@property(nonatomic,strong) MockPuzzleVerifyView     *verifyView;
@property(nonatomic,strong) UIView                  *slidView;
@property(nonatomic,strong) UILabel                 *slidTitle;
@property(nonatomic,strong) UIImageView             *slider;
@property(nonatomic,strong) UIActivityIndicatorView *stateView;

@property(nonatomic,strong) UIView                  *bottomLine;
@property(nonatomic,strong) UIButton                *cancelButton;

@end

@implementation MockVerifyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setLayout];
    }
    return self;
}

-(void) setupUI{
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.userInteractionEnabled = YES;
    self.backgroundColor = HEX(@"#ffffff");
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.verifyView];
    
    [self addSubview:self.slidView];
    [self.slidView addSubview:self.slidTitle];
    [self.slidView addSubview:self.slider];
    [self.slidView addSubview:self.stateView];
    
    [self addSubview:self.bottomLine];
    [self addSubview:self.cancelButton];
}

-(void) setLayout{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    
    [UIView drawDashLine:self startPoint:CGPointMake(0, 120) endPoint:CGPointMake(SCREEN_WIDTH - 40, 120) lineColor:HEX(@"#cdcdcd")];
    
    [self.slidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyView.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.slidTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2);
        make.left.mas_equalTo(2);
        make.size.mas_equalTo(CGSizeMake(72, 36));
    }];
    
    [self.stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo((SCREEN_WIDTH - 80 - 40)/2);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.slidView.mas_bottom).offset(15);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLine.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
}

#pragma mark - event methods

-(void) hide{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void) showVieWithTitle:(NSString *)title content:(NSAttributedString *)content{
    
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    
    self.titleLabel.text = title;
    if (content) {
        self.contentLabel.attributedText = content;
    }
    
    [superView addSubview:self.bgView];
    [superView addSubview:self];
    
    self.alpha = 0;
    self.frame = CGRectMake(20, (SCREEN_HEIGHT - 360)/2, SCREEN_WIDTH - 40 , 360);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {}];
}

//拖动事件
-(void)panAction:(UIPanGestureRecognizer *)panGestureRecognizer
{
    //视图前置操作
    [panGestureRecognizer.view.superview bringSubviewToFront:panGestureRecognizer.view];
    
    CGPoint center = panGestureRecognizer.view.center;
    CGPoint translation = [panGestureRecognizer translationInView:self.slider];
    if (center.x < 40) {
        center.x = 40;
    }
    if (center.x > (SCREEN_WIDTH - 80 - 40)) {
        center.x = SCREEN_WIDTH - 80 - 40;
    }
    panGestureRecognizer.view.center = CGPointMake(center.x + translation.x, center.y);
    [panGestureRecognizer setTranslation:CGPointZero inView:self.slider];
    CGFloat value = center.x/(SCREEN_WIDTH - 80);
    _verifyView.puzzleXPercentage = value;
}

-(void) verifySuccess{

    [_stateView stopAnimating];
    [self.slidTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
    }];
    _slidTitle.text = @"验证成功";
    [self performSelector:@selector(popView) withObject:self afterDelay:0.5];
}

-(void) popView{

    
    [self hide];
    if ([self.delegate respondsToSelector:@selector(mockVerifyViewVerifySuccess)]) {
        [self.delegate mockVerifyViewVerifySuccess];
    }
}

#pragma mark - MockPuzzleVerifyViewDelegate

- (void)puzzleVerifyView:(MockPuzzleVerifyView *)puzzleVerifyView didChangedVerification:(BOOL)isVerified {
    
    if ([_verifyView isVerified]) {
        [_verifyView completeVerificationWithAnimation:YES];
        _verifyView.enable = NO;
        _slider.hidden = YES;
        _slidTitle.text = @"";
        [_stateView startAnimating];
        [self performSelector:@selector(verifySuccess) withObject:self afterDelay:1.0];
    }
}

#pragma mark - setter and getter

-(UIActivityIndicatorView *)stateView{

    if (_stateView == nil) {
        _stateView = [[UIActivityIndicatorView alloc] init];
        _stateView.color = [UIColor lightGrayColor];
    }
    return _stateView;
}

-(UIView *)bottomLine{

    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = HEX(@"#a7a7a8");
    }
    return _bottomLine;
}

-(UIButton *)cancelButton{

    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton setTitleColor:HEX(@"#929292") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(UILabel *)titleLabel{
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = HEX(@"#323232");
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{

    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:17];
        _contentLabel.textColor = HEX(@"#666666");
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(MockPuzzleVerifyView *)verifyView{
    
    if (_verifyView == nil) {
        _verifyView = [[MockPuzzleVerifyView alloc] initWithFrame:CGRectMake(20, 140, SCREEN_WIDTH-80, 100)];
        _verifyView.image = [UIImage imageNamed:@"verity_bg"];
        _verifyView.puzzleBlankPosition = CGPointMake(200, 30);
        _verifyView.puzzlePosition = CGPointMake(100, 30);
        _verifyView.puzzleXPercentage = 0.1;
        _verifyView.layer.cornerRadius = 10;
        _verifyView.layer.masksToBounds = YES;
        _verifyView.delegate = self;
    }
    return _verifyView;
}

-(UIView *)slidView{
    
    if (_slidView == nil) {
        _slidView = [[UIView alloc] init];
        _slidView.backgroundColor = [UIColor colorWithHexString:@"#e4f7dc"];
        _slidView.layer.cornerRadius = 20;
        _slidView.layer.masksToBounds = YES;
        _slidView.layer.borderWidth = 1;
        _slidView.layer.borderColor = [UIColor colorWithHexString:@"#e2e0e0"].CGColor;
    }
    return _slidView;
}

-(UILabel *)slidTitle{
    
    if (_slidTitle == nil) {
        _slidTitle = [[UILabel alloc] init];
        _slidTitle.textColor = [UIColor colorWithHexString:@"#777777"];
        _slidTitle.font = [UIFont systemFontOfSize:14];
        _slidTitle.textAlignment = NSTextAlignmentCenter;
        _slidTitle.text = @">>>请拖动滑块完成拼图>>>";
    }
    return _slidTitle;
}

-(UIImageView *)slider{
    
    if (_slider == nil) {
        _slider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slider_icon"]];
        _slider.userInteractionEnabled = YES;
        [self addPanGestureTecognizer];
    }
    return _slider;
}

//创建平移手势
-(void) addPanGestureTecognizer
{
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    //添加到指定视图
    [_slider addGestureRecognizer:pan];
}

-(UIView *)bgView{
    
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _bgView.backgroundColor = RGBA(0, 0, 0, 0.3);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

@end
