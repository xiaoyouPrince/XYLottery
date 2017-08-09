//
//  XYScrollHeaderView.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/9.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TitleClickCallBack)(NSString *,NSInteger);

@interface XYScrollHeaderView : UIScrollView

@property(nonatomic , strong) NSArray  *titles; ///< 按钮 title 数组
@property(nonatomic , strong) UIColor  *headerBGColor;  ///< 背景颜色
@property(nonatomic , strong) UIColor  *sliderColor;  ///< title 指示线的颜色
@property(nonatomic , strong) UIColor  *titleColor;  ///< title 文字颜色
@property(nonatomic , copy) TitleClickCallBack titleClickCallback; ///< 选择 title 的回调


@end
