//
//  XYRedResultView.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/9/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYRedResultView.h"

@interface XYRedResultView ()

@property (weak, nonatomic) IBOutlet UILabel *openLabel;
@property (weak, nonatomic) IBOutlet UIImageView *openBGImage;

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



@end
