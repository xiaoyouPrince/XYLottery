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
    
    // 自己的箭头
    [self.sortTypeBtn setImage:[UIImage imageNamed:@"expand_up"] forState:UIControlStateNormal];

    
    // 出现一个透明蒙版
    UIView *coverView = [UIView new];
    coverView.frame = [UIScreen mainScreen].bounds;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick:)];
    [coverView addGestureRecognizer:tap];
    [self.superview addSubview:coverView];
    
    // 选择类型背景板 h = 150
    UIView *typeView = [UIView new];
    typeView.backgroundColor = [UIColor greenColor];
    [coverView addSubview:typeView];
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sender.mas_left).offset(5);
        make.top.mas_equalTo(sender.mas_bottom).offset(5);
        make.width.mas_equalTo(sender.mas_width);
        make.height.equalTo(@150);
    }];
    
    // 添加按钮
    for (int i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton new];
        [typeView addSubview:btn];
        btn.tag = 1038; // 这是根据类型类决定的
        btn.backgroundColor = [UIColor blackColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:@"最近7期排序" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(typeView.mas_left);
            make.right.mas_equalTo(typeView.mas_right);
            make.top.mas_equalTo(typeView.mas_top).offset(i * 30);
            make.height.mas_equalTo(30);
        }];
        
    }

  
}

- (void)coverClick:(UITapGestureRecognizer *)tap
{
    [tap.view removeFromSuperview];
    // 自己的箭头
    [self.sortTypeBtn setImage:[UIImage imageNamed:@"expand_down"] forState:UIControlStateNormal];
}

- (void)btnClick:(UIButton *)btn
{
    // 修改原Btn的默认值
    [self.sortTypeBtn setTitle:btn.currentTitle forState:UIControlStateNormal];
    [self.sortTypeBtn setImage:[UIImage imageNamed:@"expand_down"] forState:UIControlStateNormal];
    [btn.superview.superview removeFromSuperview]; // 蒙版移除
    
#warning 处理对应的几期分类。是什么样的类型  7期 -- 1038 ，，， 回调去外面实现请求
    
    // 请求对应分期排列
    // 通过回调来实现。更好
    DLog(@"type == %zd",btn.tag);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 每次进来默认更新sortScrollViewContent
    [self updateSortScrollViewContent];
}

- (void)playTypeBtnClick:(UIButton *)btn
{
    DLog(@"你点击的 name 是 ： %@ ",btn.currentTitle);
    DLog(@"你点击的 type 是 ： %zd ",btn.tag);
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
    
    
    // 更新scrollview上的内容（每种类型都不一样）
    [self updateSortScrollViewContent];
    
}

- (void)updateSortScrollViewContent
{
    // 同样也要先移除旧的控件
    if (self.sortScrollView.subviews.count) {
        [self.sortScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    
#define btn_width 100
    // 添加对应的一些玩法按钮，到scrollview上
    XYLottery *lot = [XYTools lotteryWithName:[kUserDefaults objectForKey:k_CurrentLotteryType]];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lot.coinplays.count * btn_width, 35)];
    [self.sortScrollView addSubview:containerView];
    
    for (int i = 0 ; i < lot.coinplays.count; i ++) {
        
        // 创建btns
        UIButton *btn = [UIButton new];
        NSString *title = lot.coinplays[i].playname;
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        //        [btn sizeToFit];
        btn.tag = lot.coinplays[i].playtype.integerValue;
        [btn addTarget:self action:@selector(playTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.left.mas_equalTo(self.sortScrollView.mas_left).offset(i * btn_width);
//            make.top.mas_equalTo(self.sortScrollView);
//            make.bottom.mas_equalTo(self.sortScrollView);
//            make.width.mas_equalTo(btn_width);
            make.left.mas_equalTo(containerView.mas_left).offset(i * btn_width);
            make.top.mas_equalTo(containerView);
            make.bottom.mas_equalTo(containerView);
            make.width.mas_equalTo(btn_width);
        }];
    }
    
    // 设置contentSize
//    self.sortScrollView.scrollEnabled = YES;
//    self.sortScrollView.userInteractionEnabled = YES;
    self.sortScrollView.contentSize = CGSizeMake(lot.coinplays.count * btn_width, 0);
    DLog(@"%@",NSStringFromCGSize(self.sortScrollView.contentSize));
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
