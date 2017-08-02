//
//  XYPopoverAnimator.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYPopoverAnimator.h"
#import "XYPresentationController.h"

@interface XYPopoverAnimator()<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@end

@implementation XYPopoverAnimator

- (instancetype)initWithCallBack:(callBack)callback
{
    if (self == [super init]) {
        
        self.callback = callback;
    }
    return self;
}

#pragma -- mark 自定义转场动画

// 展出动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.present = YES;
    return self;
}


// 隐藏动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.present = NO;
    if (self.callback) {
        self.callback(self.isPresent);
    }
    
    return self;
}

// 自定义弹出VC
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    
    XYPresentationController *presentVC = [[XYPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentVC.presentFrame = CGRectMake(0, 64, ScreenW, 200);
    
    return presentVC;
}


#pragma -- mark 自定义弹出和消失动画


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.isPresent ? [self animationForPresent:transitionContext] : [self animationForDismiss:transitionContext];
}

// 自定义弹出动画
- (void)animationForPresent:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 得到要展示的View，并添加到ContainerView中
    UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [transitionContext.containerView addSubview:presentView];
    
    // 执行对应动画
    presentView.transform = CGAffineTransformMakeScale(1.0, 0.0);
    presentView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        presentView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        // 必须告诉转场上下文你已经完成动画
        [transitionContext completeTransition:YES];
    }];
    

}

// 自定义消失动画
- (void)animationForDismiss:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    // 得到要展示的View，并添加到ContainerView中
    UIView *presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    [transitionContext.containerView addSubview:presentView];
    
    // 执行对应动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        presentView.transform = CGAffineTransformMakeScale(1.0, 0.0001);
    } completion:^(BOOL finished) {
        
        // 移除View并告诉上下文已经完成动画
        [presentView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];

}


@end
