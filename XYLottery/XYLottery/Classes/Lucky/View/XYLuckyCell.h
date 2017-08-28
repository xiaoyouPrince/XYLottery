//
//  XYLuckyCell.h
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/28.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>
#define k_luckCellID @"k_luckCellID"
typedef void(^BagCallBack)(void);

@interface XYLuckyCell : UITableViewCell

@property(nonatomic , copy)  BagCallBack callback;



@end
