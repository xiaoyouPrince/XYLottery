//
//  XYBoughtCacheCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/18.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYBoughtCacheCell.h"

@interface XYBoughtCacheCell ()


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@end

@implementation XYBoughtCacheCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(XYSurveyCache *)model
{
    _model = model;
    
    self.timeLabel.text = model.createtime;
    self.nameLabel.text = model.expertname;
    self.playNameLabel.text = [NSString stringWithFormat:@"%@,%@",model.playtype,model.lotname];
    self.coinLabel.text = model.coin;
    self.contentLable.text = model.calcdata;
}

@end
