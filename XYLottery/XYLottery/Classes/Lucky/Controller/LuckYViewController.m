//
//  LuckYViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "LuckYViewController.h"
#import "XYLucky.h"
#import "XYLuckyCell.h"  // 这个是红包cell。名字取错了

#define k_lastHour @"lastHour"

@interface LuckYViewController ()

@property(nonatomic , strong) NSMutableArray <XYLucky *> *luckyList;


@end

@implementation LuckYViewController

- (NSMutableArray *)luckyList
{
    if (_luckyList == nil) {
        _luckyList = [NSMutableArray new];
    }
    return _luckyList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadLuckData];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYLuckyCell" bundle:nil] forCellReuseIdentifier:k_luckCellID];
    self.tableView.tableFooterView = [UIView new];

    /**
     基本模仿，主要有变化
     
     正点的时候下红包雨，，，来正经的来展示，，，
     
     用户点击判断是不是正确的时间，如果是就直接调接口强，不是就提示原来页面

     @return <#return value description#>
     */
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 每次记录一个时间段，如果这次在这个时间段之内就不再拉取新的数据，如果不是再重新拉取新的数据
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour;
    // 1.获得当前时间的小时
    NSDateComponents *cmps = [calendar components:unit fromDate:[NSDate date]];
    NSInteger lastHour = [kUserDefaults integerForKey:k_lastHour];
    
    if (cmps.hour % 24 != lastHour) {
        
        [self loadLuckData];
        
        lastHour = cmps.hour % 24;
        [kUserDefaults setInteger:lastHour forKey:k_lastHour];
    }
    
    if (!self.luckyList.count) [self loadLuckData];
}


- (void)loadLuckData
{
    [SVProgressHUD show];
    
    NSString *url = @"http://115.29.175.83/cpyc/getredpackets.php";
    [XYHttpTool getWithURL:url params:nil success:^(NSDictionary * json) {
        [SVProgressHUD dismiss];
        
        // 得到对应的当前获奖list
        NSMutableArray *arrayM = [NSMutableArray new];
        NSArray *array = [XYLucky objectArrayWithKeyValuesArray:json[@"list"]];
        for (XYLucky *luck in array) {
            [arrayM addObject:luck];
        }
        self.luckyList = arrayM;
        // 人为添加两条数据，一个是最上边的时间，一个是财神发红包,最后一个是自定义的查看全部
        [self.luckyList insertObject:[XYLucky new] atIndex:0];
        [self.luckyList insertObject:[XYLucky new] atIndex:0];
        [self.luckyList addObject:[XYLucky new]];
        
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请检查你的网络,并重试"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.luckyList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // 移除内部控件，防止复用一些没有必要的东西
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];

    if (indexPath.row == 0) {
        
        // time cell
        NSInteger lastHour = [kUserDefaults integerForKey:k_lastHour];
        UILabel *timeLable = [UILabel new];
        timeLable.text = [NSString stringWithFormat:@"上次开奖: %zd:00",lastHour];
        [timeLable sizeToFit];
        timeLable.frame = CGRectMake(3, 2, timeLable.bounds.size.width ,timeLable.bounds.size.height);
        
        // view
        UIView *content = [UIView new];
        CGFloat contentW = 130;
        content.frame = CGRectMake((ScreenW - contentW) / 2, 7, contentW, 25);
        [content addSubview:timeLable];
        content.backgroundColor = [UIColor lightGrayColor];
        ViewBorderRadius(content, 4, 0, [UIColor clearColor]);
        [cell.contentView addSubview: content];
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        // 财神 cell
        XYLuckyCell *cell = [tableView dequeueReusableCellWithIdentifier:k_luckCellID];
        cell.callback = ^{
            //cell 内部红包被用户点击的回调
            
            DLog(@"我被点击了e");
        };
        return cell;
    }
    
    if ((indexPath.row > 1) && (indexPath.row < self.luckyList.count - 1)) {
        
        static NSString *cellID = @"luckCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    
        cell.textLabel.text = [NSString stringWithFormat:@"---%zd----",indexPath.row];
        
        return cell;
    }else
    {
        cell.textLabel.text = @"去你妹的，什么情况啊";
        return cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 100;
    }else
    {
        return 40;
    }
}



@end
