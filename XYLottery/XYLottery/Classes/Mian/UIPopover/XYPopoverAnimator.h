//
//  XYPopoverAnimator.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^callBack)(BOOL);

@interface XYPopoverAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign , getter=isPresent) BOOL present;
@property(nonatomic , copy) callBack callback;

- (instancetype)initWithCallBack:(callBack)callback;

@end
