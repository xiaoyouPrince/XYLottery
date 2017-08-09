//
//  NewsViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "NewsViewController.h"
#import "XYScrollHeaderView.h"


@interface NewsViewController ()


@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 防止headerView
    [self setupHeaderView];
    
    // 设置tableView的frame
    
    
}

- (void)setupHeaderView{
    
    XYScrollHeaderView *header = [[XYScrollHeaderView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 30)];
    [self.view addSubview:header];
    header.titles = @[@"大奖专家组合",
                      @"开奖历史",
                      @"中奖资讯",
                      @"走势图",
                      @"购彩技巧"];
    header.titleColor = [UIColor blackColor];
    header.sliderColor = [UIColor redColor];
    header.titleClickCallback = ^(NSString *title , NSInteger index){
        
        DLog(@"%@ ",title);
        DLog(@"%zd",index);
        // 不同页面有不同接口
        
        
    };
    
    self.tableView.frame = CGRectMake(0, 30, ScreenW, ScreenH - 74);
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}



@end
