//
//  NSDate+DFLExtension.h
//  DFLCalendarView
//
//  Created by 杭州移领 on 16/12/23.
//  Copyright © 2016年 DFL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DFLExtension)
/**
 * 第几天
 */
+ (NSInteger)day:(NSDate *)date;
/**
 * 第几月
 */
+ (NSInteger)month:(NSDate *)date;
/**
 * 那一年
 */
+ (NSInteger)year:(NSDate *)date;
/**
 * 第一天是星期几
 */
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate*)nextMonth:(NSDate *)date;

@end
