//
//  XYBoughtViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/18.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYBoughtViewController.h"
#import "XYBoughtCacheCell.h"
#import "XYBoughtCacheTool.h"

@interface XYBoughtViewController ()

@end

@implementation XYBoughtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYBoughtCacheCell" bundle:nil] forCellReuseIdentifier:@"boughtCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [XYBoughtCacheTool caches].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XYBoughtCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:@"boughtCell"];
    
    cell.model = [XYBoughtCacheTool caches][indexPath.row];
    
    return cell;
}




@end
