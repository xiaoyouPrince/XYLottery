//
//  XYCurSurveyCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/8.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYCurSurveyCell.h"

@interface XYCurSurveyCell()


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UIButton *rate_topBtn;
@property (weak, nonatomic) IBOutlet UIButton *seeBtn;
@property (weak, nonatomic) IBOutlet UILabel *rate_downLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property(nonatomic,assign) CGFloat cellHeight;// 自己的高度

@end

@implementation XYCurSurveyCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(XYSurveyListModel *)model
{    
    self.nameLabel.text = model.username;
    [self.rate_topBtn setTitle:model.hitnum forState:UIControlStateNormal];
    
    [self.seeBtn setTitle:model.viewnum.stringValue forState:UIControlStateNormal];
    
    self.rate_downLabel.text = model.calc;
    
    // 返回自己cell高度
    [self layoutIfNeeded];
    _cellHeight = MaxY(self.rate_downLabel) + 10;
    self.cur_model.cell_height = _cellHeight;
    
}

- (void)setCur_model:(XYSurveyListModel *)cur_model
{
    _cur_model = cur_model;
    
    [self setModel:cur_model];
}
- (IBAction)checkBtnClick:(UIButton *)sender {
    
    DLog(@"点击查看按钮，这里进行判断是否进行过登录，，如果登录过就直接根据用户余额进行请求，否则进入登录页面，让用户先登录");
    
}


@end
