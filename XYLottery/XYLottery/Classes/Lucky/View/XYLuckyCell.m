//
//  XYLuckyCell.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/28.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYLuckyCell.h"

@interface XYLuckyCell ()

@property (weak, nonatomic) IBOutlet UIButton *luckbag_downBtn;
@property (weak, nonatomic) IBOutlet UIButton *bag_coverBtn;

@end

@implementation XYLuckyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.luckbag_downBtn setBackgroundImage:[UIImage imageNamed:@"luckybag_down_sel"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (IBAction)bagCoverClick:(id)sender {
    
    [self.luckbag_downBtn setSelected:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.luckbag_downBtn setSelected:NO];
    });
    
    // 回调自己被点击
    if (self.callback) {
        self.callback();
    }
}

@end
