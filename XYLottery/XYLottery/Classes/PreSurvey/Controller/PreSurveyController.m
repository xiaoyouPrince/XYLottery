//
//  PreSurveyController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//


#define topViewH 100

#import "PreSurveyController.h"
#import "XYPreSurveyTopView.h"

@interface PreSurveyController ()

@property (nonatomic , weak) XYPreSurveyTopView *top;

@end

@implementation PreSurveyController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加topView

    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    XYPreSurveyTopView *top = [[NSBundle mainBundle] loadNibNamed:@"XYPreSurveyTopView" owner:nil options:nil].lastObject;
    self.top = top;
    top.frame = CGRectMake(0, 64, ScreenW, 100);
    [self.view addSubview:top];
    
    self.tableView.frame = CGRectMake(0, 100, ScreenW, ScreenH - 100);
    
    [super viewWillAppear:animated];
}

-(void)reloadPageData
{
    [super reloadPageData];
    
    self.top.model = self.model;
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"---%zd----",indexPath.row];
    
    return cell;
}



@end
