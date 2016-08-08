//
//  ViewController.m
//  UICountingLabel_Demo
//
//  Created by admin on 16/8/8.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "ViewController.h"
#import "UICountingLabel.h"


@interface ViewController ()
@property(strong,nonatomic)UICountingLabel* colorLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 从1加到10     Duration 是累加速度
    UICountingLabel* myLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
    myLabel.method = UILabelCountingMethodLinear;
    myLabel.format = @"%d";
//    [self.view addSubview:myLabel];
    [myLabel countFrom:1 to:10 withDuration:1.0];


    //从5%提高到10%
    UICountingLabel* countPercentageLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 50, 200, 40)];
//    [self.view addSubview:countPercentageLabel];
    countPercentageLabel.format = @"%.1f%%";
    [countPercentageLabel countFrom:5 to:10];
    
    //数使用字符串,使用数字格式化程序
    UICountingLabel* scoreLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 90, 200, 40)];
//    [self.view addSubview:scoreLabel];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    scoreLabel.formatBlock = ^NSString* (CGFloat value)
    {
        NSString* formatted = [formatter stringFromNumber:@((NSInteger)value)];
        return [NSString stringWithFormat:@"Score: %@",formatted];
    };
    scoreLabel.method = UILabelCountingMethodEaseOut;
    [scoreLabel countFrom:0 to:1234567890 withDuration:2.5];
    
    
    
    
    //累加带属性字符串
    NSInteger toValue = 100;
    UICountingLabel* attributedLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 130, 200, 40)];
//    [self.view addSubview:attributedLabel];
    attributedLabel.attributedFormatBlock = ^NSAttributedString* (CGFloat value)
    {
        NSDictionary* normal = @{ NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-UltraLight" size: 20] };
        NSDictionary* highlight = @{ NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size: 20] };
        
        NSString* prefix = [NSString stringWithFormat:@"%ld", (NSInteger)value];
        NSString* postfix = [NSString stringWithFormat:@"/%ld", (NSInteger)toValue];
        
        NSMutableAttributedString* prefixAttr = [[NSMutableAttributedString alloc] initWithString: prefix
                                                                                       attributes: highlight];
        NSAttributedString* postfixAttr = [[NSAttributedString alloc] initWithString: postfix
                                                                          attributes: normal];
        [prefixAttr appendAttributedString: postfixAttr];
        
        return prefixAttr;
    };
    [attributedLabel countFrom:0 to:toValue withDuration:2.5];
    
    
    
    //完成了数字滚动之后变个颜色
    self.colorLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(10, 200, 200, 40)];
    [self.view addSubview:self.colorLabel];
    self.colorLabel.method = UILabelCountingMethodEaseInOut;
    self.colorLabel.format = @"%d%%";
    __weak ViewController* blockSelf = self;
    self.colorLabel.completionBlock = ^{
        blockSelf.colorLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
    };
    [self.colorLabel countFrom:0 to:100];
    
}



@end
