//
//  ViewController.m
//  PuzzleVerify
//
//  Created by 徐琰璋 on 2017/9/18.
//  Copyright © 2017年 上海览益信息科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "MockVerifyView.h"

@interface ViewController ()<MockVerifyViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)verifyAction:(id)sender {
    
    MockVerifyView *verifyView = [[MockVerifyView alloc] init];
    verifyView.delegate = self;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dictAttr1 = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:HEX(@"#323232"),NSParagraphStyleAttributeName:style};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"即将对沪黄金所有合约进行平仓\n预计盈利" attributes:dictAttr1];
    
    NSString *str2 = @"   ＋1812.00";
    NSDictionary *dictAttr2 = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:HEX(@"#e94646"),NSParagraphStyleAttributeName:style};
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:str2 attributes:dictAttr2];
    [attributedString appendAttributedString:attr2];
    
    [verifyView showVieWithTitle:@"确认平仓" content:attributedString];
}

#pragma mark - MockVerifyViewDelegate
-(void) mockVerifyViewVerifySuccess{
    
    NSLog(@"验证成功");
}


@end
