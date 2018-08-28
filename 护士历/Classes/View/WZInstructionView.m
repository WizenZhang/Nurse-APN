//
//  WZInstructionView.m
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import "WZInstructionView.h"

@implementation WZInstructionView

+ (id)instructionView
{
    return [[NSBundle mainBundle] loadNibNamed:@"WZInstructionView" owner:nil options:nil][0];
}
@end
