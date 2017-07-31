//
//  ViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/7/28.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationItem.title = @"你好啊";
    self.title = @"tab one";
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *vc = [UIViewController new];
    vc.title = @"sdasdf ";
    vc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
