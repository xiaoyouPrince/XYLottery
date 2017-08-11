//
//  XYProfileHeaderView.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/10.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYProfileHeaderView.h"

@interface XYProfileHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *loginIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;


@end

@implementation XYProfileHeaderView


- (void)setUser:(XYUser *)user
{
    _user = user;
    
    self.loginIdLabel.text = user.userid;
    self.nameLabel.text = user.username;
    self.coinLabel.text = [NSString stringWithFormat:@"%zd",user.coin];
    self.fansLabel.text = [NSString stringWithFormat:@"%zd",user.fans];
    self.scoreLabel.text = [NSString stringWithFormat:@"%zd",user.score];
    self.rankLabel.text = [NSString stringWithFormat:@"%d",user.isexpert];
}

- (IBAction)rechargeBtnClick:(id)sender {
    if (self.rechargeClick) {
        self.rechargeClick();
    }
}
- (IBAction)refreshBtnClick:(id)sender {
    if (self.refreshClick) {
        self.refreshClick();
    }
}


@end
