//
//  XYNewsDetailViewController.m
//  XYLottery
//
//  Created by 渠晓友 on 2017/8/20.
//  Copyright © 2017年 渠晓友. All rights reserved.
//

#import "XYNewsDetailViewController.h"

@interface XYNewsDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *web;

@end

@implementation XYNewsDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIWebView *web = [UIWebView new];
    web.delegate = self;
    web.frame = self.view.bounds;
    [self.view addSubview:web];
    self.web = web;
    [web loadRequest:self.request];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    [SVProgressHUD show];
    return YES;
    
}



@end
