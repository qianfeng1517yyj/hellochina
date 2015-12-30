//
//  GYDWebViewController.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDWebViewController.h"
#import <WebKit/WebKit.h>

@interface GYDWebViewController ()
@property(nonatomic)WKWebView *myWebView;
@property (nonatomic) UIProgressView *progressView;
@end

@implementation GYDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self customNavidationBar];
    [self createWebView];
    [self createProgressView];
}
- (void)createProgressView {
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, LCKScreenWidth, 10)];
    self.progressView.progress = 0;
    [self.view addSubview:self.progressView];
}
- (void)createWebView {
    self.myWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.myWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.webUrl]];
    [self.myWebView loadRequest:request];
    [self.view addSubview:self.myWebView];
}
- (void)customNavidationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:nil target:self action:@selector(back)];
    self.title = self.subTitle;
}
- (void)back {
    [self.myWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    self.progressView.progress = self.myWebView.estimatedProgress;
    if(self.progressView.progress == 1.0) {
        self.progressView.hidden = YES;
    }
}

@end
