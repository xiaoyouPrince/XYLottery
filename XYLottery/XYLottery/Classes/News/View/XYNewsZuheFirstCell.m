//
//  XYNewsZuheFirstCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/10.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYNewsZuheFirstCell.h"

@interface XYNewsZuheFirstCell()

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;

@property(nonatomic , strong) NSMutableArray  *ballArrays;



@end

@implementation XYNewsZuheFirstCell


- (void)setModel:(XYSurveyModel *)model
{
    _model = model;
    
    
    // 移除之前的球
    // 每次进来，先删除之前可能复用的小球he其他要清缓存控件
    if (self.ballArrays.count) {
        for (UILabel *ball in self.ballArrays) {
            [ball removeFromSuperview];
        }
    }
    
    self.topLabel.text = model.linetwo;
    
    NSArray<NSString *> *lineoneS = [model.lineone componentsSeparatedByString:@"："];
    self.downLabel.text = lineoneS.firstObject;

    // 添加球
    NSArray<NSString *> *kjnum = [model.kjnum componentsSeparatedByString:@"#"];
    if (kjnum.count == 2) {
        // 两种颜色
        NSArray *reds = [kjnum.firstObject componentsSeparatedByString:@","];
        NSArray *blues = [kjnum.lastObject componentsSeparatedByString:@","];
        
        [self addLotBallsWithRed:reds blue:blues];
        
    }else if(kjnum.count == 1){
        // 只有红球的类型
        NSArray *reds = [kjnum.firstObject componentsSeparatedByString:@","];
        
        [self addLotBallsWithRed:reds blue:nil];
        
    }
    
}

- (NSMutableArray *)ballArrays
{
    if (_ballArrays == nil) {
        _ballArrays = [[NSMutableArray alloc] init];
    }
    return _ballArrays;
}

- (void)addLotBallsWithRed:(NSArray *)reds blue:(NSArray *)blue{
    
    CGFloat padding = 5;
    CGFloat ballWH = 15;
    
    NSInteger blueCount = 0;
    if (blue.count) {
        blueCount = blue.count;
    }
    
    NSInteger redCount = reds.count;
    
    NSMutableArray *ballNums = [NSMutableArray new];
    for (NSString *code in reds) {
        [ballNums addObject:code];
    }
    for (NSString *code in blue) {
        [ballNums addObject:code];
    }
    
    for (NSInteger i = 0 ; i < reds.count + blueCount; i++) {
        
        UILabel *ball = [UILabel new];
        ball.backgroundColor = i < redCount ? [UIColor redColor] : [UIColor blueColor];
        ball.font = [UIFont systemFontOfSize:11];
        ball.textColor = [UIColor whiteColor];
        ball.layer.cornerRadius = ballWH / 2;
        ball.clipsToBounds = YES;
        ball.text = ballNums[i];
        ball.textAlignment = NSTextAlignmentCenter;
        [self addSubview:ball];
        [self.ballArrays addObject:ball];
        
        [ball mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.downLabel.mas_right).offset(padding + i * 18);
            make.top.equalTo(self.downLabel.mas_top).offset(-2);
            make.width.and.height.mas_equalTo(ballWH);
        }];
    }
    
}

@end
