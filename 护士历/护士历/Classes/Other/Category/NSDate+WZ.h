//
//  NSDate+WZ.h
//  堆糖画报
//
//  Created by Wizen Zhang on 16/5/4.
//  Copyright (c) 2016年 Wizen Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate_WZ : NSObject
+(NSString *)yearToWeek:(NSString *)year;
+(NSString *)getweek:(NSInteger)week;
/**计算日期间隔天数，以天为单位*/
+(long int)calculateDifferentDayFromDate:(NSString *)fromDate ToDate:(NSString *)toDate;
@end
