//
//  XYCurSurveyTopView.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/7.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYCurSurveyTopView.h"

@interface XYCurSurveyTopView ()

@property(nonatomic , assign) BOOL isSuperModel;

@end

@implementation XYCurSurveyTopView

- (void)setModel:(XYSurveyModel *)model
{
    // 这里是重写父类的 setModel 方法,实际上只需要重写父类，然后修改上半部分约束和样式，底部重用
    [super setModel:model];  // 可以直接使用父类的SB文件，修改类型指向子类，其内部子控件会自动指向本子类
    
    // 修改上半部分布局。。去除小球们
    if (super.ballArrays.count) {
        for (UILabel *ball in super.ballArrays) {
            [ball removeFromSuperview];
        }
    }
    
//    if (_isSuperModel) { // 实际上已经是二次之后了，是自己的model
        self.dateLabel.text = [NSString stringWithFormat:@"第 %@ 期预测",model.kjissue];
//    }
//    // 上部第多少期
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        self.dateLabel.text = [NSString stringWithFormat:@"第 %@ 期预测",model.nextissue];
//        
//        _isSuperModel = YES;
//    });
    
}


@end
