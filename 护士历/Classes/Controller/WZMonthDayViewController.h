//
//  WZMonthDayViewController.h
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZMonthDayViewController;
@protocol MonthAndDayControllerDelegate <NSObject>

@optional
-(void) monthAndDayController:(WZMonthDayViewController *)controller didSelectIndexPath:(NSIndexPath *)indexPath GregoiainCalendar:(NSString *)gregoiainCalendar chineseCalendar:(NSString *)chineseCalendar;

@end
@interface WZMonthDayViewController : UICollectionViewController
/** 选中状态的color */
@property (nonatomic, strong) UIColor *selectColor;

-(instancetype)initWithFrame:(CGRect)frame;

/** 代理 */
@property (nonatomic, assign) id<MonthAndDayControllerDelegate> delegate;

//根据时间更新collection
-(void)refreshControlWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

@end
