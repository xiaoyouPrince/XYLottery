//
//  LuckYViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/1.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "LuckYViewController.h"
#import "XYLucky.h"
#import "XYLuckyCell.h"  // 这个是红包cell。名字取错了抢红包列表的cell。好像有点错了也
#import "XYLuckyListCell.h"   // 这个是抢红包的列表cell
#import "XYOpenRedPackageView.h"

#define k_lastHour @"lastHour"

@interface LuckYViewController ()

@property(nonatomic , strong) NSMutableArray <XYLucky *> *luckyList;  ///< 数据
@property(nonatomic , strong) XYOpenRedPackageView *openRedPackageView;  ///< 数据
@property(nonatomic , strong) UILabel  *tiplabel;


@end

@implementation LuckYViewController

- (XYOpenRedPackageView *)openRedPackageView
{
    if (_openRedPackageView == nil) {
        _openRedPackageView = [[NSBundle mainBundle] loadNibNamed:@"XYOpenRedPackageView" owner:nil options:0].lastObject;
        _openRedPackageView.frame = self.tableView.bounds;
    }
    return _openRedPackageView;
}


- (NSMutableArray *)luckyList
{
    if (_luckyList == nil) {
        _luckyList = [NSMutableArray new];
    }
    return _luckyList;
}

- (UILabel *)tiplabel
{
    if (_tiplabel == nil) {
        UILabel *tipLabel = [UILabel new];
        tipLabel.backgroundColor = XYColor(219, 72, 106);
        tipLabel.frame = CGRectMake(0, ScreenH - 44 - 40, ScreenW, 40);
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.font = [UIFont systemFontOfSize:14];
        
        // 每次记录一个时间段，如果这次在这个时间段之内就不再拉取新的数据，如果不是再重新拉取新的数据
        NSCalendar *calendar = [NSCalendar currentCalendar];
        int unit = NSCalendarUnitHour;
        // 1.获得当前时间的小时
        NSDateComponents *cmps = [calendar components:unit fromDate:[NSDate date]];
        NSInteger nowHour = cmps.hour % 24;
        tipLabel.text = [NSString stringWithFormat:@"下一波金币抢红包 %zd:00 开始",nowHour + 1];
        _tiplabel = tipLabel;
    }
    return _tiplabel;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tiplabel removeFromSuperview];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadLuckData];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYLuckyCell" bundle:nil] forCellReuseIdentifier:k_luckCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYLuckyListCell" bundle:nil] forCellReuseIdentifier:k_luckListCellID];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

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
    
    // 下次开奖时间
    [[UIApplication sharedApplication].keyWindow addSubview:self.tiplabel];
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
        timeLable.font = [UIFont systemFontOfSize:12];
        [timeLable sizeToFit];
        timeLable.textAlignment = NSTextAlignmentCenter;
        timeLable.frame = CGRectMake(5, 5, timeLable.bounds.size.width ,timeLable.bounds.size.height);
        
        // view
        UIView *content = [UIView new];
        CGFloat contentW = timeLable.bounds.size.width + 10;
        content.frame = CGRectMake((ScreenW - contentW) / 2, 7, contentW, 25);
        [content addSubview:timeLable];
        content.backgroundColor = XYColor(242, 239, 247);
        ViewBorderRadius(content, 4, 0, [UIColor clearColor]);
        [cell.contentView addSubview: content];
        return cell;
    }
    
    if (indexPath.row == 1) {
        
        // 财神 cell
        XYLuckyCell *cell = [tableView dequeueReusableCellWithIdentifier:k_luckCellID];
        cell.callback = ^{
            //cell 内部红包被用户点击的回调
    
            DLog(@"红包被点击了e");
            [self userHasClickRedPacket];
            
        };
        return cell;
    }
    
    if ((indexPath.row > 1) && (indexPath.row < self.luckyList.count - 1)) {
        
//        static NSString *cellID = @"luckCell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        }
//        cell.textLabel.text = [NSString stringWithFormat:@"---%zd----",indexPath.row];
        
        XYLuckyListCell *cell = [tableView dequeueReusableCellWithIdentifier:k_luckListCellID];
        cell.model = self.luckyList[indexPath.row];
        return cell;
    }else
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, ScreenW, 30);
        [btn setTitle:@"点击查看大家手气" forState:UIControlStateNormal];
        [btn setTitleColor:XYColor(131, 175, 222) forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(checkAllLuckys) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        
        return cell;
    }
    
    return cell;
}


/**
    用户点击了红包
 */
- (void)userHasClickRedPacket
{
    // 进入对应的开红包页面
    
    // view
    [self.tableView addSubview:self.openRedPackageView];
    self.openRedPackageView.callBack = ^(XYOpenRedPackageView *openView) {
        [openView removeFromSuperview];
    };
}

// 查看所有的幸运观众
- (void)checkAllLuckys
{
    DLog(@"去你妹的，什么情况啊");
    
    /// 进入对应的列表页面
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
    }else if (indexPath.row == 1) {
        return 100;
    }else
    {
        return 30;
    }
}



@end
