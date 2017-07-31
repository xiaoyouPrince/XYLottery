//
//  MainNavController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/7/28.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "MainNavController.h"

@interface MainNavController ()

@end

@implementation MainNavController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UINavigationBar *)navigationBar
{
    
    return [super navigationBar];
    if (self.childViewControllers.count == 1) {
        
        UIView *bar = [UIView new];
        bar.backgroundColor = [UIColor grayColor];
        UINavigationBar *navBar = [[UINavigationBar alloc] init];
        navBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
        navBar.tintColor = [UIColor redColor];
        return navBar;
        
    }else{
        
        return [super navigationBar];
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        
//        [self setHidesBottomBarWhenPushed:YES];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}



@end
