//
//  XYPreSurveyCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/3.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYPreSurveyCell.h"

@interface XYPreSurveyCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UIButton *rate_topBtn;
@property (weak, nonatomic) IBOutlet UIButton *seeBtn;
@property (weak, nonatomic) IBOutlet UIButton *rate_downBtn;
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;

@property(nonatomic , strong) NSMutableArray *ballArrays;


@end

@implementation XYPreSurveyCell

#define k_radius 3
#define k_color [UIColor colorWithRed:1 green:0 blue:0 alpha:1]

- (void)awakeFromNib {
    [super awakeFromNib];
    // 一次性设置
    
    ViewBorderRadius(self.titleBtn, k_radius, 1, k_color);
    ViewBorderRadius(self.rate_topBtn, k_radius, 1, k_color);
    
    ViewRadius(self.rate_downBtn, k_radius);
    ViewRadius(self.coinBtn, k_radius);
    self.seeBtn.imageView.contentMode = UIViewContentModeCenter;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"PreSurveyCell";
    
    XYPreSurveyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[XYPreSurveyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
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
    
    
    self.nameLabel.text = model.username;
    [self.rate_topBtn setTitle:model.hitnum forState:UIControlStateNormal];
    
    [self.seeBtn setTitle:model.viewnum.stringValue forState:UIControlStateNormal];
    [self.rate_downBtn setTitle:model.award forState:UIControlStateNormal];
    
    // 添加球
    NSArray<NSString *> *kjnum = [model.calc componentsSeparatedByString:@"#"];
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
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.width.and.height.mas_equalTo(ballWH);
        }];
    }
    
}

@end
