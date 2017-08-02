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
    
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 添加 第 多少期
    
}

- (void)setModel:(XYPreSurveyModel *)model
{
    _model = model;
    
    self.dateLabel.text = [NSString stringWithFormat:@"第%@期",model.kjissue];
}




@end
