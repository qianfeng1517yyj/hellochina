//
//  UIButton+HandEvent.m
//  BlockButton
//
//  Created by QianFeng on 15/9/23.
//  Copyright (c) 2015年 王启启. All rights reserved.
//

#import "UIButton+HandEvent.h"
#import <objc/runtime.h>

@implementation UIButton (HandEvent)

char key;

// 分类里面不增加变量
- (id)initWithHandleEvent:(ClickEventType)block {
    if (self = [super init]) {
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 给一个对象绑定一个value的对象objc_getAssociatedObject再次得到该对象
        objc_setAssociatedObject(self, &key, block, OBJC_ASSOCIATION_COPY);
        
           }
    return self;
}
- (void)buttonClick:(UIButton *)button {
    ClickEventType block = objc_getAssociatedObject(self, &key);

    if (block) {
        block(button);
    }
}

@end
