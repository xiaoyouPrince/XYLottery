//
//  XYCustomBackButtonViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/14.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYCustomBackButtonViewController.h"

@interface XYCustomBackButtonViewController ()

@end

@implementation XYCustomBackButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBack = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:(UIBarButtonItemStylePlain) target:self action:@selector(pop)];
    //    leftBack.imageInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    leftBack.width = 30;
    self.navigationItem.leftBarButtonItem = leftBack;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
