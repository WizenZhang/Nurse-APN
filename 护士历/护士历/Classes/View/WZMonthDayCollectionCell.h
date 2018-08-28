//
//  WZMonthDayCollectionCell.h
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZMonthDayCollectionCell : UICollectionViewCell
/** 月 */
@property (nonatomic, copy) NSString *gregoiainDay;
/** 日 */
@property (nonatomic, copy) NSString *lunarDay;

/** 阳历 */
@property (nonatomic, copy) NSString *gregoiainCalendar;
/** 农历 */
@property (nonatomic, copy) NSString *chineseCalendar;

@property (weak, nonatomic) IBOutlet UILabel *gregoiainDaylabel;

@property (weak, nonatomic) IBOutlet UILabel *lunarDayLabel;

@end
