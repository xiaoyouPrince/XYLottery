//
//  XYPresentationController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYPresentationController.h"

@interface XYPresentationController ()

@property(nonatomic,strong) UIView *coverView;

@end

@implementation XYPresentationController

- (UIView *)coverView;
{
    if (_coverView == nil) {
        
        UIView *coverView = [UIView new];
        _coverView = coverView;
        coverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopoverView)];
        [coverView addGestureRecognizer:tap];
    }

    return _coverView;
}


// 重新布局内部presentVC 和 coverView
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    self.presentedView.frame = self.presentFrame;
    [self.containerView insertSubview:self.coverView atIndex:0];
    self.coverView.frame = self.containerView.bounds;
}

#pragma mark -- 蒙版点击,dismiss

- (void)dismissPopoverView
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
