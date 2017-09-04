//
//  XYLuckyListDetailCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/9/4.
//  Copyright © 2017年 渠晓友. All rights reserved.
//
//  这里是看大家的手气页面的cell

#import "XYLuckyListDetailCell.h"
#import "XYLucky.h"

@interface XYLuckyListDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;
@property (weak, nonatomic) IBOutlet UIButton *descBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coinLabelTopCons;  ///< 金币Label的顶部约束

@end

@implementation XYLuckyListDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setModel:(XYLucky *)model
{
    _model = model;
    
    self.nameLabel.text = model.username;
    [self.timeBtn setTitle:model.createtime forState:0];
    self.coinLabel.text = [NSString stringWithFormat:@"%@金币",model.coin];
    
    // model.type == 1 幸运星
    // model.type == 2 出手最快
    // model.type == 3 普通列表
    
    if (model.type.integerValue == 1) {
        
        self.descBtn.hidden = NO;
        self.coinLabelTopCons.constant = 0;
        
        [self.descBtn setImage:[UIImage imageNamed:@"star_icon"] forState:0];
        [self.descBtn setTitle:@"幸运星" forState:0];
        
    }else if ([model.type isEqualToString:@"2"]){
        
        self.descBtn.hidden = NO;
        self.coinLabelTopCons.constant = 0;
        
        [self.descBtn setImage:[UIImage imageNamed:@"flash_icon"] forState:0];
        [self.descBtn setTitle:@"出手最快" forState:0];
        
    }else
    {
        self.descBtn.hidden = YES;
        self.coinLabelTopCons.constant = 10;
    }
}

@end
