//
//  WZKeyboardTool.m
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import "WZKeyboardTool.h"


@implementation WZKeyboardTool

+ (id)keyboardTool
{
    return [[NSBundle mainBundle] loadNibNamed:@"WZKeyboardTool" owner:nil options:nil][0];
}

#pragma mark 取消
- (void)cancel
{
    // 通知代理（上一个按钮被点击了）
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:WZKeyboardToolItemTypeCancel];
    }
}

#pragma mark 完成
- (void)done
{
    // 通知代理（完成按钮被点击了）
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:WZKeyboardToolItemTypeDone];
    }
}

@end
