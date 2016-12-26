//
//  DFLCalendarView.h
//  DFLCalendarView
//
//  Created by 杭州移领 on 16/12/23.
//  Copyright © 2016年 DFL. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DFLCalendarView : UIView

@property (nonatomic, strong) NSDate *date;

@property (nonatomic , copy) void (^selectDateBlock) (BOOL isSelected,NSString *month);

//@property (nonatomic , strong) NSDictionary *keyValueDic;

- (void)selectDateCallBack:(void (^) (BOOL isSelected,NSString *month)) callBack;
@end
