//
//  MainTabController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/7/31.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "MainTabController.h"
#import "MainNavController.h"
#import "PreSurveyController.h"
#import "CurSurveyController.h"
#import "NewsViewController.h"
#import "LuckyViewController.h"
#import "ProfileViewController.h"


@interface MainTabController ()

@end

@implementation MainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor redColor];


    PreSurveyController *pre = [PreSurveyController new];
    [self addChildViewController:pre withTitle:@"上期测中" imageName:@"tabbar_preSurvey"];
    
    CurSurveyController *cur = [CurSurveyController new];
    [self addChildViewController:cur withTitle:@"本期测中" imageName:@"tabbar_curSurvey"];
    
    NewsViewController *news = [NewsViewController new];
    [self addChildViewController:news withTitle:@"彩讯" imageName:@"tabbar_news"];
    
    LuckYViewController *lucky = [LuckYViewController new];
    [self addChildViewController:lucky withTitle:@"幸运得奖" imageName:@"tabbar_lucky"];
    
    ProfileViewController *profile = [ProfileViewController new];
    [self addChildViewController:profile withTitle:@"我" imageName:@"tabbar_profile"];
    
}


- (void)addChildViewController:(UIViewController *)childVC withTitle:(NSString *)title imageName:(NSString *)imageName{
    
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_sel"]];
    // nav
    MainNavController *nav = [[MainNavController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
    
}


// 没有用，这个方法时序不对，无奈系统也米有对应的方法，
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    
//    UITabBarItem *lastItem = tabBar.items.lastObject;
//    if ([item isEqual:lastItem]) {
//        // 点击最后一个-- 我
//        if ([XYAccountTool user]) {
////            [super tabBar:tabBar didSelectItem:item];
//        }else
//        {
//            XYLoginController *loginVc = [XYLoginController new];
//            [self presentViewController:loginVc animated:YES completion:nil];
//            loginVc.loginSuccess = ^(BOOL isSuccess) {
//                if (isSuccess) {
//                    // 登录成功，展示对应的子页面
//                    [self setNeedsFocusUpdate];
//                }
//            };
//        }
//    }
//}

@end
