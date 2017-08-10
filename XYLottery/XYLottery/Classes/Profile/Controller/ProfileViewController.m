//
//  ProfileViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "ProfileViewController.h"
#import "XYProfileHeaderView.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UITableView *tableView;

@end

@implementation ProfileViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = kGlobalBg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Nav
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // tableView
    UITableView *tableView = [UITableView new];
    tableView.frame = CGRectMake(0, 214, ScreenW, ScreenH - 260);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.tableFooterView = [UIView new];
    tableView.backgroundColor = [UIColor lightTextColor];
    
    // header
    XYProfileHeaderView *header = [[NSBundle mainBundle] loadNibNamed:@"XYProfileHeaderView" owner:nil options:nil].firstObject;
    header.frame = CGRectMake(0, 64, ScreenW, 150);
    [self.view addSubview:header];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"---%zd---",indexPath.row];
    
    return cell;
}


@end
