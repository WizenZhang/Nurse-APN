//
//  WZYearViewController.h
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YearViewControllerDelegate <NSObject>

@optional
-(void)yearTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath cellText:(NSString *)cellText;

@end
@interface WZYearViewController : UITableViewController
/** 选中状态的color */
@property (nonatomic, strong) UIColor *selectColor;

// 根据时间更新tableview
-(void) refreshControlWithCellText: (NSString *)year;

/** 代理 */
@property (nonatomic, assign) id<YearViewControllerDelegate> delegate;
@end
