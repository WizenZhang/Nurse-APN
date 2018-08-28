//
//  WZDecisionView.h
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZDecisionView;
@protocol DecisionDelegate <NSObject>

@optional
-(void) DecisionDidSelectNow: (WZDecisionView *)decision;

-(void) DecisionDidSelectCancel: (WZDecisionView *)decision;

-(void) DecisionDidSelectAction: (WZDecisionView *)decision;

@end

@interface WZDecisionView : UIView

//初始化
-(void) generateDecision;

/** 代理 */
@property (nonatomic, assign) id<DecisionDelegate> delegate;

/** 按钮文字颜色 */
@property (nonatomic, copy) UIColor *textColor;
/** 点击按钮文字颜色 */
@property (nonatomic, copy) UIColor *selectColor;
@end
