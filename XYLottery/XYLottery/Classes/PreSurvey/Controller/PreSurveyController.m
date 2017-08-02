//
//  PreSurveyController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//


#define topViewH 100

#import "PreSurveyController.h"

@interface PreSurveyController ()

@end

@implementation PreSurveyController



- (void)loadView
{
    [super loadView];
    
    self.view.frame = CGRectMake(0, topViewH, ScreenW, ScreenH - 108 - topViewH);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}



@end
