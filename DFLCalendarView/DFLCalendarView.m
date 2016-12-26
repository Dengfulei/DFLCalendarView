//
//  DFLCalendarView.m
//  DFLCalendarView
//
//  Created by 杭州移领 on 16/12/23.
//  Copyright © 2016年 DFL. All rights reserved.
//

#import "DFLCalendarView.h"
#import "NSDate+DFLExtension.h"

@interface DFLCalendarView()

@property (nonatomic , strong) NSMutableArray *buttonArray;

@property (nonatomic , strong) UILabel *selectDateLabel;

@property (nonatomic , strong) UIView *headerWeekView;

@property (nonatomic , strong) UIButton *selectedButton;
@end
@implementation DFLCalendarView




- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubviews];

    }
    return self;
}

- (void)initSubviews {
    
    CGFloat itemW = self.frame.size.width / 7;
    UIView *weekView = [self configurateHeaderWeekView:itemW];
    [self addSubview:weekView];
    self.buttonArray = [NSMutableArray new];
    for (NSInteger i = 0; i < 42; i ++) {
        CGFloat x = (i % 7) * itemW;
        CGFloat y = (i / 7) * itemW + CGRectGetMaxY(weekView.frame);
        CGRect frame = CGRectMake(x, y, itemW, itemW);
        UIButton *button = [self configurateSubViewButton:frame];
        [self.buttonArray addObject:button];
        [self addSubview:button];
    }
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(weekView.frame) + 6 * itemW;
    self.frame = frame;
}

- (UIView *)configurateHeaderWeekView:(CGFloat)itemW {
    UIView *headerWeekView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    headerWeekView.backgroundColor = [UIColor yellowColor];
    UIImage *leftImage = [UIImage imageNamed:@"leftarr"];
    UIImage *rightImage = [UIImage imageNamed:@"rightarr"];
    
    UIButton *leftButton = ({
        leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5,  leftImage.size.width/3, leftImage.size.height/3)];
        [leftButton setImage:leftImage forState:UIControlStateNormal];
         [leftButton addTarget:self action:@selector(lastMonth:) forControlEvents:UIControlEventTouchUpInside];
        leftButton;
        
    });
    [headerWeekView addSubview:leftButton];
 
    UIButton *righrButton =({
        righrButton =  [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - rightImage.size.width/3 - 10,5, rightImage.size.width/3, rightImage.size.height/3)];
        [righrButton setImage:rightImage forState:UIControlStateNormal];
        [righrButton addTarget:self action:@selector(nextMonth:) forControlEvents:UIControlEventTouchUpInside];
        righrButton;
    });
    [headerWeekView addSubview:righrButton];
   
    UILabel *label = ({
        label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width - 60, 30)];
        label.backgroundColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        self.selectDateLabel = label;
        label;
    });
    [headerWeekView addSubview:label];
    
    
    
    NSArray *weekArray = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    for (NSInteger i = 0; i < weekArray.count; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = weekArray[i];
        week.font     = [UIFont systemFontOfSize:14];
        week.frame    = CGRectMake(itemW * i, 30, itemW, 30);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = [UIColor blackColor];
        [headerWeekView addSubview:week];
    }
    
    return headerWeekView;
    
}

- (UIButton *)configurateSubViewButton:(CGRect)frame {
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];;
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.numberOfLines = 2;
    [button addTarget:self action:@selector(clcikMonthDay:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = frame.size.width/2;
    return button;
}

- (void)clcikMonthDay:(UIButton *)button {
    if (self.selectedButton == button) {
        if (self.selectDateBlock) {
            self.selectDateBlock(YES,button.titleLabel.text);
        }
    } else {
        self.selectedButton.backgroundColor = [UIColor clearColor];
        [self setStyle_Today:button];
        self.selectedButton = button;
        if (self.selectDateBlock) {
            self.selectDateBlock(NO,button.titleLabel.text);
        }
    }
}

- (void)selectDateCallBack:(void (^) (BOOL isSelected,NSString *month)) callBack {
    self.selectDateBlock = callBack;
}

#pragma mark - date button style
//设置不是本月的日期字体颜色   ---白色  看不到
- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)setStyle_AfterToday:(UIButton *)btn
{
    btn.enabled = YES;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setStyle_Today:(UIButton *)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:94/255.0 green:169/255.0 blue:251/255.0 alpha:1]];
}

- (void)lastMonth:(UIButton *)button {
    NSDate *lastDate = [NSDate lastMonth:self.date];
    self.date = lastDate;
}

- (void)nextMonth:(UIButton *)button {
    NSDate *nextDate = [NSDate nextMonth:self.date];
    self.date = nextDate;
}

- (void)setDate:(NSDate *)date {
    
    _date = date;
    [self showCalendarViewWithDate:_date];
    
}

- (void)showCalendarViewWithDate:(NSDate *)date {
    
    self.selectDateLabel.text     = [NSString stringWithFormat:@"%li-%li",[NSDate year:date],[NSDate month:date]];
    NSInteger daysInLastMonth = [NSDate totaldaysInMonth:[NSDate lastMonth:date]];
    NSInteger daysInThisMonth = [NSDate totaldaysInMonth:date];
    NSInteger firstWeekday    = [NSDate firstWeekdayInThisMonth:date];
    for (NSInteger i = 0; i < self.buttonArray.count; i++) {
        UIButton *button = self.buttonArray[i];
        NSInteger day = 0;
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:button];
            
        } else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:button];
            
        } else {
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:button];
        }

        [button setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
            
        
        // this month
        NSInteger todayIndex = [NSDate day:[NSDate date]] + firstWeekday - 1;
        if([self judgementDate] && i ==  todayIndex) {
            [self setStyle_Today:button];
            self.selectedButton = button;
        } else {
            button.backgroundColor=[UIColor whiteColor];
        }

    }
}

//- (void)setKeyValueDic:(NSDictionary *)keyValueDic {
//    _keyValueDic = keyValueDic;
//    
//    for (NSInteger i = 0; i < self.buttonArray.count; i ++) {
//        if (_keyValueDic.count > 0) {
//            UIButton *button = self.buttonArray[i];
//            NSString *key = button.titleLabel.text;
//            for (NSString *dicKey in [_keyValueDic allKeys]) {
//                if ([key isEqual:dicKey]) {
//                    [button setTitle:[NSString stringWithFormat:@"%@\n%@", key,_keyValueDic[dicKey]] forState:UIControlStateNormal];
//                }
//            }
//        }
//    }
//}

-(BOOL)judgementDate
{
    //获取当前月份
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyyy-MM";
    NSString *dateMon= [formatter stringFromDate:[NSDate date]] ;
    
    //获取选择的月份
    NSString *dateFormatter= self.selectDateLabel.text ;
    
    if ([dateMon isEqual:dateFormatter]){
        return YES;
    }
    return NO;
}



@end
