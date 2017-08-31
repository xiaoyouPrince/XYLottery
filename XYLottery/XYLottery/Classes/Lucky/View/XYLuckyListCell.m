//
//  XYLuckyListCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/30.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYLuckyListCell.h"
#import "XYLucky.h"

@interface XYLuckyListCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end


@implementation XYLuckyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(XYLucky *)model
{
    _model = model;
    
    // model.type == 1 幸运星
    // model.type == 2 出手最快
    // model.type == 3 普通列表
    
    if (model.type.integerValue == 1) {
        
        NSString *str = [NSString stringWithFormat:@"幸运星 %@ 领取了 %@ 金币",model.username , model.coin];
        
        NSMutableDictionary *attrDict = [NSMutableDictionary new];
        [attrDict setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str attributes:attrDict];
        [attr addAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor] } range:NSMakeRange(3, model.username.length)];
        self.label.attributedText = attr;
        
    }else if ([model.type isEqualToString:@"2"]){
        
        NSString *str = [NSString stringWithFormat:@"出手最快 %@ 领取了 %@ 金币",model.username , model.coin];
        
        
        NSMutableDictionary *attrDict = [NSMutableDictionary new];
        [attrDict setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str attributes:attrDict];
        [attr addAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor] } range:NSMakeRange(3, model.username.length)];
        attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        self.label.attributedText = attr;
        
    }else
    {
        // 普通的,直接隐藏iconView
        self.iconView.hidden = YES;
        
        
        NSString *str = [NSString stringWithFormat:@" %@ 领取了 %@ 金币",model.username , model.coin];
        
        NSMutableDictionary *attrDict = [NSMutableDictionary new];
        [attrDict setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:str attributes:attrDict];
        [attr attributedSubstringFromRange:NSMakeRange(1, model.username.length)];
        self.label.attributedText = attr;

    }
    
}

@end
