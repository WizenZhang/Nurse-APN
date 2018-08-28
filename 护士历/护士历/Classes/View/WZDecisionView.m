//
//  WZDecisionView.m
//  护士历
//
//  Created by Wizen Zhang on 16/6/21.
//  Copyright © 2016年 Wizen Zhang. All rights reserved.
//

#import "WZDecisionView.h"
#import "WZInstructionView.h"
#import "WZKeyboardTool.h"

#define WZColor(r, g, b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])
@interface WZDecisionView()<WZKeyboardToolDelegate>
@property (nonatomic, weak) UITextField *settingField;
@property (nonatomic, weak) UITextField *infoField;
@end
@implementation WZDecisionView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor brownColor];
        self.textColor = WZColor(71, 55, 169);
        self.selectColor = WZColor(30, 25, 70);
    }
    return self;
}


-(void) generateDecision{
    CGFloat width = self.frame.size.width/4;
    CGFloat height = self.frame.size.height;
    
    // 返回当前
    CGRect nowRect = CGRectMake(0, 0, width, height);
    [self addNow:nowRect];
    // 取消
    CGRect cancelRect = CGRectMake(width * 2, 0, width, height);
    [self addCancel:cancelRect];
    // 确定
    CGRect actionRect = CGRectMake(width * 3, 0, width, height);
    [self addAction:actionRect];
    
}
// 返回当前
-(void) addNow:(CGRect)rect{
    
    UIButton *now = [[UIButton alloc] initWithFrame:rect];
    [now setTitle:@"今日" forState:UIControlStateNormal];
    now.titleLabel.font = [UIFont systemFontOfSize:15];
    [now setTitleColor:self.textColor forState:UIControlStateNormal];
    [now setTitleColor:self.selectColor forState:UIControlStateHighlighted];
    
    [now addTarget:self action:@selector(didNow:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:now];
    
}
// 返回按钮点击事件
-(void) didNow:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(DecisionDidSelectNow:)]) {
        [self.delegate DecisionDidSelectNow:self];
    }
    
}


// 取消
-(void) addCancel:(CGRect)rect{
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:rect];
    [cancel setTitle:@"说明" forState:UIControlStateNormal];
    [cancel setTitleColor:self.textColor forState:UIControlStateNormal];
    [cancel setTitleColor:self.selectColor forState:UIControlStateHighlighted];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    
    //    [cancel addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:cancel];
    
    UITextField *infoField = [self textField];
    
    UIView *instruction=[[UIView alloc]init];
    instruction.frame=CGRectMake(0, 0, self.frame.size.width,  self.frame.size.height);
    instruction.backgroundColor=[UIColor grayColor];
    
    //    UIBarButtonItem *btn=[UIBarButtonItem alloc
    // 2.创建键盘工具条
    WZInstructionView *info = [WZInstructionView instructionView];

    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit:)];
    [info addGestureRecognizer:tap];
    infoField.inputView=info;
//    field.inputAccessoryView = info;
    
    [cancel addSubview:infoField];
    _infoField=infoField;
}

-(void)endEdit:(UITapGestureRecognizer *)tap
{
    [self.infoField endEditing:YES];
}
// 取消按钮点击事件
-(void) didCancel:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(DecisionDidSelectCancel:)]) {
        [self.delegate DecisionDidSelectCancel:self];
    }
}

-(UITextField *)textField
{
    CGFloat width = self.frame.size.width/4;
    CGFloat height = self.frame.size.height;
    UITextField *field = [[UITextField alloc]init];
    field.frame=CGRectMake(0, 0, width, height);
    
    field.textColor=[UIColor clearColor];
    field.tintColor=[UIColor clearColor];
    return field;
}
// 确定
-(void) addAction:(CGRect)rect{
    
    UIButton *action = [[UIButton alloc] initWithFrame:rect];
    [action setTitle:@"设置" forState:UIControlStateNormal];
    [action setTitleColor:self.textColor forState:UIControlStateNormal];
    [action setTitleColor:self.selectColor forState:UIControlStateHighlighted];
    action.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [action addTarget:self action:@selector(didAction:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:action];
    
    UITextField *settingField = [self textField];
    settingField.text = @"2016-06-17";
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate; // 只显示日期5
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [datePicker addTarget:self action:@selector(birthdayChange:) forControlEvents:UIControlEventValueChanged];

    settingField.inputView=datePicker;

    // 创建键盘工具条
    WZKeyboardTool *tool = [WZKeyboardTool keyboardTool];
    tool.delegate = self;
    
    settingField.inputAccessoryView = tool;
    
    [action addSubview:settingField];
    _settingField=settingField;
}
#pragma mark - 生日改变
- (void)birthdayChange:(UIDatePicker *)picker
{
    // 1.取得当前时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    // 2.赋值到文本框
    self.settingField.text = [fmt stringFromDate:picker.date];
  
}

// 确定按钮点击事件
-(void) didAction:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(DecisionDidSelectAction:)]) {
        [self.delegate DecisionDidSelectAction:self];
    }
}
#pragma mark - MJKeyboardTool代理方法
#pragma mark 点击了工具条上面的按钮就会调用
- (void)keyboardTool:(WZKeyboardTool *)keyboardTool itemClick:(WZKeyboardToolItemType)itemType
{
    if (itemType == WZKeyboardToolItemTypeDone) {// 完成
        
        
        if ([self.settingField.text isEqual:@"2016-06-17"]) {
            NSDate *today= [NSDate dateWithTimeIntervalSinceNow:0];
            // 1.取得当前时间
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd";
            // 2.赋值到文本框
            self.settingField.text = [fmt stringFromDate:today];
            
        }
     
        //访问NSUserDefaults
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        //存储数据
        [defaults setObject:self.settingField.text forKey:@"restDate"];
        //立刻同步
        [defaults synchronize];
        if ([self.delegate respondsToSelector:@selector(DecisionDidSelectAction:)]) {
            [self.delegate DecisionDidSelectAction:self];
        }

        [self.settingField endEditing:YES];
    } else { // 取消
  
        [self.settingField endEditing:YES];
    }
}

@end
