//
//  XYLuckyListDetailCell.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/9/4.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>
#define k_XYLuckyListDetailCell @"XYLuckyListDetailCell"

@class XYLucky;
@interface XYLuckyListDetailCell : UITableViewCell

@property(nonatomic , strong) XYLucky  *model;


@end
