//
//  GYDSearchReusableView.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDSearchReusableView.h"
#import "GYDSearchBar.h"

@interface GYDSearchReusableView ()<UITextFieldDelegate>

@property (nonatomic) GYDSearchBar *searchBar;

@end

@implementation GYDSearchReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customUI];
    }
    return self;
}

- (void)customUI {
    [self createSearchView];
    [self createButtons];
}

- (void)createSearchView {
    self.searchBar = [GYDSearchBar searchBar];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入关键词...";
    self.searchBar.font = [UIFont systemFontOfSize:15];
    self.searchBar.frame = CGRectMake(10, 10, LCKScreenWidth-20, 35);
    [self addSubview:self.searchBar];
}
- (void)createButtons {
    UIButton *leftButton = [self createButton:@"btn_msg_highlight" highlightBG:@"btn_msg_normal" action:@selector(leftButtonClick) title:@"搜索良品"];
    leftButton.frame = CGRectMake(10, 45, (LCKScreenWidth - 20)/2, 35);
    [self addSubview:leftButton];
    UIButton *rightButton = [self createButton:@"btn_msg_highlight" highlightBG:@"btn_msg_normal" action:@selector(rightButtonClick) title:@"搜索用户"];
    rightButton.frame = CGRectMake(10+leftButton.frame.size.width, 45, (LCKScreenWidth - 20)/2, 35);
    [self addSubview:rightButton];
    
}
- (UIButton *)createButton:(NSString *)normalBG highlightBG:(NSString *)highlightBG action:(SEL)action title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (normalBG) {
        [button setBackgroundImage:[UIImage imageWithOriginal:normalBG] forState:UIControlStateNormal];
    }
    if (highlightBG) {
        [button setBackgroundImage:[UIImage imageWithOriginal:highlightBG] forState:UIControlStateHighlighted];
    }
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)leftButtonClick {
    NSString *str = self.searchBar.text;
    if (str.length == 0) {
        return;
    }
    if (self.delegate) {
        [self.delegate searchReusableViewLeftBTClick:self.searchBar.text];
    }
}
- (void)rightButtonClick {
    NSString *str = self.searchBar.text;
    if (str.length == 0) {
        return;
    }
    if (self.delegate) {
        [self.delegate searchReusableViewrightBTClick:self.searchBar.text];
    }
}


@end
