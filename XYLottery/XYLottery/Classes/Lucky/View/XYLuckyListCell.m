//
//  XYLuckyListCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/30.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

//  这里面完全可以用图文混排的富文本，傻乎乎的居然没有想到，然后自己拿着控件布局半天，不仅浪费了时间，方法还很 low！
//  直接用一个富文本多好，咋就忽略了呢？

#import "XYLuckyListCell.h"
#import "XYLucky.h"

@interface XYLuckyListCell()

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view_width_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *icon_width_cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label_left_cons;

@end


@implementation XYLuckyListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    ViewRadius(self.view, 4);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setModel:(XYLucky *)model
{
    _model = model;
    
    // model.type == 1 幸运星
    // model.type == 2 出手最快
    // model.type == 3 普通列表
    
    if (model.type.integerValue == 1) {
        
        self.iconView.image = [UIImage imageNamed:@"star_icon"];
        self.label.attributedText = [self attributedStrWithPreStr:@"幸运星"];
        
        // 先布局一下，才能使用frame
        [self layoutIfNeeded];
        self.view_width_cons.constant = WIDTH(self.label) + 50;

        
    }else if ([model.type isEqualToString:@"2"]){
        
        self.label.attributedText = [self attributedStrWithPreStr:@"出手最快"];
        
        // 先布局一下，才能使用frame
        [self layoutIfNeeded];
        self.view_width_cons.constant = WIDTH(self.label) + 50;
        
    }else
    {
        // 普通的,直接隐藏iconView
        self.iconView.hidden = YES;
        
        self.label.attributedText = [self attributedStrWithPreStr:@""];
        
        // 先布局一下，才能使用frame
        [self layoutIfNeeded];
        self.icon_width_cons.constant = 0;
        self.label_left_cons.constant = 0;
        self.view_width_cons.constant = WIDTH(self.label) +25;
    }
}

- (NSAttributedString *)attributedStrWithPreStr:(NSString *)pre_str
{
    NSString *str = [NSString stringWithFormat:@"%@ %@ 领取了 %@ 金币",pre_str,_model.username , _model.coin];
    
    NSMutableDictionary *attrDict = [NSMutableDictionary new];
    [attrDict setValue:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];

    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str attributes:attrDict];
    [attr addAttributes:@{NSForegroundColorAttributeName :[UIColor cyanColor] ,NSFontAttributeName :[UIFont systemFontOfSize:13]} range:NSMakeRange(pre_str.length + 1, _model.username.length)];
    
    return attr;
}



@end
