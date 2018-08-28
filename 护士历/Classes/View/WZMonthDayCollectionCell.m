//
//  WZMonthDayCollectionCell.m
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import "WZMonthDayCollectionCell.h"

@implementation WZMonthDayCollectionCell
-(void)setGregoiainDay:(NSString *)gregoiainDay{
    _gregoiainDay = gregoiainDay;
    self.gregoiainDaylabel.text = gregoiainDay;
}

-(void)setLunarDay:(NSString *)lunarDay{
    _lunarDay = lunarDay;
    self.lunarDayLabel.text = lunarDay;
}


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 在此添加
        // 初始化时加载collectionCell.xib文件
        
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WZMonthDayCollectionCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        
        if(arrayOfViews.count < 1){return nil;}
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end
