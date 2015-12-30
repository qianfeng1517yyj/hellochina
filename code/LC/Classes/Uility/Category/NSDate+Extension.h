//
//  NSDate+Extension.h
//  LC
//
//  Created by QianFeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  判断是否为昨天
 */
-(BOOL)isYesterDay;

/**
 *  判断是否为今天
 */
- (BOOL)isToday;

/**
 *  判断是否为今年
 */
- (BOOL)isThisYear;


/**
 *  比较两个日期之间的差值
 */
- (NSDateComponents *)deltaFromDate:(NSDate *)fromDate;

@end
