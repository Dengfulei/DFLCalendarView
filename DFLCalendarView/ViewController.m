//
//  ViewController.m
//  DFLCalendarView
//
//  Created by 杭州移领 on 16/12/23.
//  Copyright © 2016年 DFL. All rights reserved.
//

#import "ViewController.h"
#import "DFLCalendarView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DFLCalendarView *view = [[DFLCalendarView alloc] initWithFrame:CGRectMake(10, 64, self.view.frame.size.width - 20, 0)];
    view.date = [NSDate date];
//    view.keyValueDic = @{@"2" : @"+3",
//                         @"6" : @"+2",
//                         @"25" : @"+15",
//                         @"26" : @"+20",
//                         @"300" : @"+10",};
    [view selectDateCallBack:^(BOOL isSelected, NSString *month) {
        if (!isSelected) {
            NSLog(@">>>>%@",month);
        }
    }];
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
