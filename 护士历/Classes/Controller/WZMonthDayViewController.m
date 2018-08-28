//
//  WZMonthDayViewController.m
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import "WZMonthDayViewController.h"
#import "WZMonthDayViewController.h"
#import "WZKeyboardTool.h"
#import "WZMonthDayCollectionCell.h"
#import "Colours.h"
#import "WZUseTime.h"
#import "NSDate+WZ.h"
#define DeviceWidth self.view.frame.size.width

@interface WZMonthDayViewController ()<WZKeyboardToolDelegate>

/** 公历某个月的天数 */
@property (nonatomic, assign) NSInteger monthNumber;
/** 某天是星期几 */
@property (nonatomic, assign) NSInteger dayOfWeek;

/** 月日，星期几 */
@property (nonatomic, strong) NSMutableArray *monthNumberAndWeek;

/** 处理时间的方法 */
@property (nonatomic, strong) WZUseTime *useTime;
/**休息日*/
@property(nonatomic,copy)NSString *restDate;
/**上班颜色数组*/
@property(nonatomic,strong)NSArray  *workColors;
@end

@implementation WZMonthDayViewController

static NSString * const reuseIdentifier = @"monthDayViewCell";
static NSString * const reuseHeader = @"monthDayViewHeader";

// 懒加载
-(WZUseTime *)useTime{
    if (!_useTime) {
        _useTime = [[WZUseTime alloc] init];
    }
    return _useTime;
}
-(NSArray *)workColors
{
    if (_workColors==nil) {
        UIColor *R=[UIColor icebergColor];
        UIColor *A=[UIColor grassColor];
        UIColor *P=[UIColor carrotColor];
        UIColor *N=[UIColor coolGrayColor];
        UIColor *D=[UIColor steelBlueColor];
        _workColors=@[R,A,P,N,D];
    }
    return _workColors;
}
-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat wh = frame.size.width/7;
    layout.itemSize = CGSizeMake(wh, wh);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = -2;
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 15, 0);
    
    
    self = [super initWithCollectionViewLayout:layout];
    self.view.frame = frame;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册
    [self.collectionView registerClass:[WZMonthDayCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //注册头部
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeader];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return (2101-1970) * 12;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //每个月的第一天
    NSString *strYear = [NSString stringWithFormat:@"%ld", section / 12 + 1970];
    NSString *strMonth = [NSString stringWithFormat:@"%ld", section % 12 + 1];
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-01", strYear, strMonth];
    
    return [self.useTime timeFewWeekInMonth:dateStr] * 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WZMonthDayCollectionCell *cell = (WZMonthDayCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
  
    //每个月的第一天
    NSString *dateStr = [self getDateStrForSection:indexPath.section day:1];
    
    // 获得这个月的天数
    self.monthNumber = [self.useTime timeNumberOfDaysInString:dateStr];
    
    self.dayOfWeek = [self.useTime timeMonthWeekDayOfFirstDay:dateStr];
    
    NSInteger firstCorner = self.dayOfWeek;
    NSInteger lastConter = self.dayOfWeek + self.monthNumber - 1;
    if (indexPath.item <firstCorner || indexPath.item>lastConter) {
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
        NSInteger gregoiain = indexPath.item - firstCorner+1;
        //阳历
        cell.gregoiainDay = [NSString stringWithFormat:@"%ld", gregoiain];
        
        //农历
        NSString *dateStr = [self getDateStrForSection:indexPath.section day:gregoiain];
        
        //访问NSUserDefaults
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        _restDate=[defaults objectForKey:@"restDate"];
        if (!_restDate) {
            _restDate=[NSString stringWithFormat:@"2016-06-17"];
        }
        
        long int different=[NSDate_WZ calculateDifferentDayFromDate:dateStr ToDate:_restDate];
        
        long int work=different%5;
        
        CGFloat wh = DeviceWidth/7;
        cell.layer.cornerRadius = wh/2;
        cell.layer.masksToBounds = YES;
        if (work>0) {
            cell.backgroundColor=self.workColors[5-work];
        }else if(work<=0){
            cell.backgroundColor=self.workColors[labs(work)];
        }
        
        cell.lunarDay = [self.useTime timeChineseDaysWithDate:dateStr];
        
        //日期属性
        cell.gregoiainCalendar = dateStr;
        
        cell.chineseCalendar = [self.useTime timeChineseCalendarWithString:dateStr];
        
     }
    return cell;
}


//header
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeader forIndexPath:indexPath];
        
        UILabel *label = [headerView viewWithTag:11];
        if (label == nil) {
            // 添加日期
            label = [[UILabel alloc] init];
            label.tag = 11;
            [headerView addSubview:label];
            
            NSArray *weeks = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
            //添加星期
            for (int i = 0; i < 7; i++) {
                NSString *weekStr = weeks[i];
                UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake( headerView.frame.size.width/7 * i, headerView.frame.size.height/2, headerView.frame.size.width/7, 22)];
                week.font = [UIFont systemFontOfSize:15];
                week.text = weekStr;
                week.textAlignment = NSTextAlignmentCenter;
                [headerView addSubview:week];
            }
            
        }
        //设置属性
        label.text = [NSString stringWithFormat:@"%ld年 %ld月", indexPath.section/12 + 1970, indexPath.section%12 + 1];
        
        [label sizeToFit];
        
        CGFloat x = (headerView.frame.size.width - label.frame.size.width)/2;
        CGFloat y = (headerView.frame.size.height/2 - label.frame.size.height)/2;
        CGFloat width = label.frame.size.width;
        CGFloat height = label.frame.size.height;
        label.frame = CGRectMake(x, y, width, height);
        
        return headerView;
    }
    return nil;
    
}

-(NSString *)getDateStrForSection:(NSInteger)section day:(NSInteger)day{
    return [NSString stringWithFormat:@"%ld-%ld-%ld", section/12 + 1970, section%12 + 1, day];
}


//设置header的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    return (CGSize){ScreenWidth, 44};
}

//cell点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WZMonthDayCollectionCell *cell = (WZMonthDayCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(monthAndDayController:didSelectIndexPath: GregoiainCalendar:chineseCalendar:)]){
        
        [self.delegate monthAndDayController:self didSelectIndexPath:indexPath GregoiainCalendar:cell.gregoiainCalendar chineseCalendar:cell.chineseCalendar];
    }
}


-(void)refreshControlWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    // 每个月的第一天
    // (2101-1970) * 12
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", year, month, @1];
    // 获得这个月第一天是星期几
    NSInteger dayOfFirstWeek = [self.useTime timeMonthWeekDayOfFirstDay:dateStr];
    
    NSInteger section = ([year integerValue] - 1970)*12 + ([month integerValue] - 1);
    NSInteger item = [day integerValue] + dayOfFirstWeek - 1;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionCenteredVertically];
}

@end
