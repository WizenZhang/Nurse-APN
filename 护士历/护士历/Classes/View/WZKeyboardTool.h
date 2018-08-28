//
//  WZKeyboardTool.h
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZKeyboardTool;

typedef enum {
    WZKeyboardToolItemTypeCancel, // 取消
        WZKeyboardToolItemTypeDone // 完成
} WZKeyboardToolItemType;

@protocol WZKeyboardToolDelegate <NSObject>
@optional

- (void)keyboardTool:(WZKeyboardTool *)keyboardTool itemClick:(WZKeyboardToolItemType)itemType;
@end

@interface WZKeyboardTool : UIView
- (IBAction)cancel; // 取消
- (IBAction)done; // 完成

@property (nonatomic, weak) id<WZKeyboardToolDelegate> delegate;

+ (id)keyboardTool;
@end
