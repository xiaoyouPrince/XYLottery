//
//  XYScrollHeaderView.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/9.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYScrollHeaderView.h"

@interface XYScrollHeaderView ()

@property(nonatomic,weak) UIView *contentView;

@end

@implementation XYScrollHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self setupContent];
    }
    return self;
}

- (void)setupContent
{
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    self.contentView = contentView;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;

    [titles enumerateObjectsUsingBlock:^(NSString*  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UIButton *btn = [UIButton new];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = idx;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:btn];
    }];
    
    
    static CGFloat _currentWith = 0;
    CGFloat padding = 20;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [btn sizeToFit];
        btn.frame = CGRectMake(_currentWith, 0, btn.frame.size.width + padding, btn.frame.size.height);
        _currentWith += btn.frame.size.width;
    }];
    self.contentView.frame = CGRectMake(0, 0, _currentWith, self.bounds.size.height);
    self.contentSize = CGSizeMake(_currentWith, 0);
    
}

- (void)setTitleColor:(UIColor *)titleColor
{
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }];
}

- (void)setHeaderBGColor:(UIColor *)headerBGColor
{
    self.backgroundColor = headerBGColor;
    self.contentView.backgroundColor = headerBGColor;
}

- (void)titleClick:(UIButton *)btn
{
    
#define lineHeight 2
    [btn.superview.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.height == lineHeight) {
                [obj removeFromSuperview];
            }
        }];
    }];
    
    CGFloat lineInsetMargin = 15;
    UIView *line = [UIView new];
    line.backgroundColor = _sliderColor ? _sliderColor : [UIColor redColor];
    line.frame = CGRectMake(lineInsetMargin, btn.frame.size.height - lineHeight, btn.frame.size.width - 2*lineInsetMargin,lineHeight);
    [btn addSubview:line];
    
    if (self.titleClickCallback) {
        self.titleClickCallback(btn.currentTitle, btn.tag);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // scrollView 在滚动的时候会多次调用这里去实现新的布局，所以不能在这里设置 contentSize
    
    // 展示之前点击默认第一个按钮点击
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self titleClick:self.contentView.subviews.firstObject];
    });
}


@end
