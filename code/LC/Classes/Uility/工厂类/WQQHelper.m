//
//  WQQHelper.m
//  LC
//
//  Created by QianFeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "WQQHelper.h"

@implementation WQQHelper

+(CGFloat)heightWithBody:(NSString *)body {
    //计算字符串占用的大小
    CGRect rect = [body boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.width;
}

@end
