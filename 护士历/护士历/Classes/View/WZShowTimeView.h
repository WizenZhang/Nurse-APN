//
//  WZShowTimeView.h
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZShowTimeView;
@protocol ShowTimeViewDelegate <NSObject>

@optional
//点击月日的时候调用
-(void)ShowTimeView:(WZShowTimeView *)timeView didSelectYear:(NSString *)year Month:(NSString *)month day:(NSString *)day;

//点击年的时候调用
-(void)ShowTimeView:(WZShowTimeView *)timeView didSelectYear:(NSString *)year;

@end

@interface WZShowTimeView : UIView

//以下属性均有默认值
/** HeaderName 头部的标题 */
@property (nonatomic, copy) NSString *headerName;
/** HeaderColor 头部标题的颜色*/
@property (nonatomic, strong) UIColor *headerColor;
/** HeaderBackgroundColor 头部标题栏背景颜色*/
@property (nonatomic, strong) UIColor *headerBackgroundColor;

/** contentColor 头部内容文本颜色*/
@property (nonatomic, strong) UIColor *contentColor;
/** contentBackgroundColor 头部内容背景颜色*/
@property (nonatomic, strong) UIColor *contentBackgroundColor;
/** month 月份值*/
@property (nonatomic, copy) NSString *monthText;
/** day 日期值*/
@property (nonatomic, copy) NSString *dayText;
/** year 年份值*/
@property (nonatomic, copy) NSString *yearText;

/** basicColor 未选中状态时文本颜色*/
@property (nonatomic, strong) UIColor *basicColor;

/** 代理 */
@property (nonatomic, assign) id<ShowTimeViewDelegate> delegate;

-(void) generateView;

@end
