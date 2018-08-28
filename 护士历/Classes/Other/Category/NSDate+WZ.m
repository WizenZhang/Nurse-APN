//
//  NSNSDate+WZ.m
//  堆糖画报
//
//  Created by Wizen Zhang on 16/5/4.
//  Copyright (c) 2016年 Wizen Zhang. All rights reserved.
//

#import "NSDate+WZ.h"

@implementation NSDate_WZ
+(NSString *)yearToWeek:(NSString *)year
{
    
    NSString *string = year;
    
    NSRange range = [string rangeOfString:@":" options:NSBackwardsSearch];
    
    [string substringWithRange:range];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init] ;
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:inputDate];
    
    NSInteger week = [comps weekday];
    
    return [self getweek:week];
}
+(NSString *)getweek:(NSInteger)week

{
    NSString*weekStr=nil;
    switch (week) {
        case 1:
            weekStr=@"星期天";
            break;
        case 2:
            weekStr=@"星期一";
            break;
        case 3:
            weekStr=@"星期三";
            break;
        case 4:
            weekStr=@"星期四";
            break;
        case 5:
            weekStr=@"星期四";
            break;
        case 6:
            weekStr=@"星期五";
            break;
        case 7:
            weekStr=@"星期六";
            break;
        default:
            break;
    }
    return weekStr;
    
}
/**计算日期间隔天数，以天为单位*/
+(long int)calculateDifferentDayFromDate:(NSString *)fromDate ToDate:(NSString *)toDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *FromDate;
    NSDate *ToDate;
    NSString *fromData=[NSString stringWithFormat:@"%@ 00:00:00",fromDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&FromDate interval:NULL forDate:[dateFormatter dateFromString:fromData]];
    //    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSString *toData=[NSString stringWithFormat:@"%@ 00:00:00",toDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&ToDate interval:NULL forDate:[dateFormatter dateFromString:toData]];
    
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:FromDate toDate:ToDate options:0];
    // dayComponents.day  即为间隔的天数
    return dayComponents.day;
}
@end
