//
//  XYNewsHistoryCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/10.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYNewsHistoryCell.h"

@interface XYNewsHistoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;

@property(nonatomic , strong) NSMutableArray  *ballArrays;


@end


@implementation XYNewsHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.timeBtn.imageView.contentMode = UIViewContentModeCenter;
}


- (void)setModel:(XYSurveyListModel *)model
{
    _model = model;
    
    // 移除之前的球
    // 每次进来，先删除之前可能复用的小球he其他要清缓存控件
    if (self.ballArrays.count) {
        for (UILabel *ball in self.ballArrays) {
            [ball removeFromSuperview];
        }
    }
    
    
    self.dateLabel.text = [NSString stringWithFormat:@"第 %@ 期",model.kjissue];
    [self.timeBtn setTitle:model.kjdate forState:UIControlStateNormal];
    
    // 添加小球
    // 添加球
    NSArray<NSString *> *kjnum = [model.kjnum componentsSeparatedByString:@"#"];
    //    NSLog(@"codes == %@",codes.firstObject);
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
    
    CGFloat padding = 10;
    CGFloat ballWH = 23;
    
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
        ball.textColor = [UIColor whiteColor];
        ball.layer.cornerRadius = ballWH / 2;
        ball.clipsToBounds = YES;
        ball.text = ballNums[i];
        ball.font = [UIFont systemFontOfSize:15];
        ball.textAlignment = NSTextAlignmentCenter;
        [self addSubview:ball];
        [self.ballArrays addObject:ball];
        
        [ball mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(padding + i * 35));
            make.top.equalTo(self.dateLabel.mas_bottom).offset(10);
            make.width.and.height.mas_equalTo(ballWH);
        }];
    }
    
}

@end
