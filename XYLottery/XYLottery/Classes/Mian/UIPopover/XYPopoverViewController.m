//
//  XYPopoverViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/2.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYPopoverViewController.h"

@interface XYPopoverViewController ()

@property(nonatomic , strong)     NSArray  *dataArray;


@end

@implementation XYPopoverViewController

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@"双色球",
                       @"福彩3D",
                       @"七乐彩",
                       @"七星彩",
                       @"排列三",
                       @"排列五",
                       @"大乐透"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.9];
    
    // 九宫格几个按钮
    // 设置列数为 3
    int clos = 3;
    
    // 设置书的宽高分别为 W H
    CGFloat W = ScreenW / 4;
    CGFloat H = 70 * heightRate;
    
    // 计算书的位置
    // 获得索引
    for (NSInteger index = 0; index < self.dataArray.count; index ++) {
        
        // 0. 创建书
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor redColor];
        
        // 计算横间距 margin
        CGFloat margin = (ScreenW - clos * W) / (clos + 1); // -1 是贴边， +1 是两边也有间距
        // 书 frame 的 X
        CGFloat x = (index % clos) * (W + margin) + margin; // 多加一个margin，左边一倍边距
        // 书 frame 的 Y
        CGFloat y = (index / clos) * (H + margin) + margin; // 多加一个margin，左边一倍边距
        
        btn.frame = CGRectMake(x, y, W, H);
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.dataArray[index] forState:UIControlStateNormal];
    }
    
    
//    int clum = 3; // 列数
//    CGFloat itemH = 70 * heightRate;
//    
//    for (int i = 0; i < self.dataArray.count; i++) {
//        
//        UIButton *item = [[UIButton alloc] init];
//        item.layer.borderWidth = 0.25;
//        item.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        item.tag = i;
//        [self.view addSubview:item];
//        
//        //        if ( i % clum  == 0 ) { // 第0列
//        
//        item.frame = CGRectMake( (i % clum) *  (ScreenW / clum),0 + i/clum * itemH, ScreenW / clum , itemH);
// 
//        [item setTitle:self.dataArray[i] forState:UIControlStateNormal];
//        [item addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    }

}

- (void)btnClicked:(UIButton *)sender
{
    if (self.callback) {
        
        self.callback(sender.currentTitle);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

//// 里边内容点击之后，进行的操作
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (self.callback) {
//        
//        NSInteger a = arc4random_uniform(30);
//        NSString *str = [NSString stringWithFormat:@"用户选择%ld",a];
//        
//        self.callback(str);
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//}

@end
