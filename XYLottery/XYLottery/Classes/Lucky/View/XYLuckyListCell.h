//
//  XYLuckyListCell.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/30.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>
#define k_luckListCellID @"k_luckListCellID"


@class XYLucky;
@interface XYLuckyListCell : UITableViewCell

@property(nonatomic , strong) XYLucky  *model;


@end
