//
//  XYRedResultView.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/9/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYRedResultView.h"

@interface XYRedResultView ()

@property (weak, nonatomic) IBOutlet UILabel *openLabel;   ///< 在本页面中是close的“按钮”，由于直接继承，所以名字还是没改
@property (weak, nonatomic) IBOutlet UIImageView *openBGImage;   ///< close “按钮”点击展示高亮用的，只是展示
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;   ///< “对不起” or “很抱歉”
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;  ///< “来晚了” or “11点你已经抢过了”
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;     ///< “还剩1次机会” or “等下个时间点来哦”

@end

@implementation XYRedResultView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTaped:)];
    self.openLabel.userInteractionEnabled = YES;
    [self.openLabel addGestureRecognizer:tap];
}

- (void)labelTaped:(UITapGestureRecognizer *)tap
{
    self.openBGImage.highlighted = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.openBGImage.highlighted = NO;
    });
    
    
    // 修改文字，让后提示下一次再来。。。。。
    if (self.closeCallBack) {
        self.closeCallBack();
    }
}

- (void)setShowFailPage:(BOOL)showFailPage
{
    _showFailPage = showFailPage;
    
    if (showFailPage) {
        self.titleLabel.text = @"很抱歉";
        self.detailLabel.text = @"11点你已经抢过了";  // 当前时间点
        self.tipLabel.text = @"等下个时间点来哦";
    }else
    {
        self.titleLabel.text = @"对不起";
        self.detailLabel.text = @"来晚了";  // 当前时间点
        self.tipLabel.text = @"还剩1次机会";
    }
}



@end
