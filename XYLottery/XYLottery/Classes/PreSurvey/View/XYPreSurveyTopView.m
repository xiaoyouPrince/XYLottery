//
//  XYPreSurveyTopView.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYPreSurveyTopView.h"
#import "XYTitleButton.h"

@interface XYPreSurveyTopView ()

@property(nonatomic , strong) NSMutableArray  *ballArrays;


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet XYTitleButton *sortTypeBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *sortScrollView;

@end

@implementation XYPreSurveyTopView


/**
 按多少期分类的 Btn 点击

 @param sender 对应Btn
 */
- (IBAction)sortTypeBtnClick:(XYTitleButton *)sender {
    
    // 出现一个透明蒙版
    UIView *coverView = [UIView new];
    coverView.frame = [UIScreen mainScreen].bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick:)];
    [coverView addGestureRecognizer:tap];
    [self.superview addSubview:coverView];
    
    // 选择类型
    UIView *typeView = [UIView new];
    typeView.backgroundColor = [UIColor greenColor];
    [coverView addSubview:typeView];
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sender.mas_left).offset(5);
        make.top.mas_equalTo(sender.mas_bottom).offset(5);
        make.width.mas_equalTo(sender.mas_width);
        make.height.equalTo(@150);
    }];
    
    UIButton *btn = [UIButton new];
    [typeView addSubview:btn];
    btn.tag = 1038; // 这是根据类型类决定的
    btn.backgroundColor = [UIColor blackColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"按最近7期排列" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(typeView.mas_left);
        make.right.mas_equalTo(typeView.mas_right);
        make.top.mas_equalTo(typeView.mas_top);
        make.height.mas_equalTo(40);
    }];
  
}

- (void)coverClick:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview];

}

- (void)btnClick:(UIButton *)btn
{
    // 修改原Btn的默认值
    [self.sortTypeBtn setTitle:btn.currentTitle forState:UIControlStateNormal];
    
    // 请求对应分期排列
    // 通过回调来实现。更好
    
    DLog(@"type == %zd",btn.tag);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 添加 第 多少期
    
}

- (void)setModel:(XYSurveyModel *)model
{
    _model = model;
    
    // 每次进来，先删除之前可能复用的小球he其他要清缓存控件
    if (self.ballArrays.count) {
        for (UILabel *ball in self.ballArrays) {
            [ball removeFromSuperview];
        }
    }
    
    self.dateLabel.text = [NSString stringWithFormat:@"第%@期",model.kjissue];
    
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
        
    }else
    {
//        // 没有球，是比赛的那两种
//        UILabel *rightLabel = [UILabel new];
//        [self.contentView addSubview:rightLabel];
//        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@10);
//            make.left.equalTo(@55);
//            make.right.offset(-25);
//            make.height.mas_equalTo(20);
//            
//        }];
//        rightLabel.textColor = [UIColor lightGrayColor];
//        rightLabel.font = [UIFont systemFontOfSize:12];
//        rightLabel.textAlignment = NSTextAlignmentRight;
//        rightLabel.text = model.match_time;
//        self.dateLabel.hidden = YES;
//        [self.ballArrays addObject:rightLabel];
//        
//        UILabel *matchLabel = [UILabel new];
//        matchLabel.textAlignment = NSTextAlignmentCenter;
//        matchLabel.font = [UIFont systemFontOfSize:14];
//        matchLabel.textColor = [UIColor whiteColor];
//        NSString *str = [NSString stringWithFormat:@"%@  %@  %@",model.home_team,model.score,model.guest_team];
//        matchLabel.text = str;
//        [self.contentView addSubview:matchLabel];
//        matchLabel.backgroundColor = RGB(170, 80, 149);
//        matchLabel.layer.cornerRadius = 20;
//        matchLabel.clipsToBounds = YES;
//        
//        [matchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@15);
//            make.right.offset(-25);
//            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
//            make.height.equalTo(@40);
//        }];
//        [self.ballArrays addObject:matchLabel];
//        
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
    
    CGFloat padding = 15;
    CGFloat ballWH = 26;
    
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
        ball.textAlignment = NSTextAlignmentCenter;
        [self addSubview:ball];
        [self.ballArrays addObject:ball];
        
        [ball mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(padding + i * 35));
            make.top.equalTo(self.dateLabel.mas_bottom).offset(3);
            make.width.and.height.mas_equalTo(ballWH);
        }];
    }
    
}



@end
