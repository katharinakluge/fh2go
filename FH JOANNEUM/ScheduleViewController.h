//
//  ScheduleViewController.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "KalViewController.h"
#import "KalDataProvider.h"

@interface ScheduleViewController : KalViewController <UITableViewDelegate>

@property (nonatomic, strong) Schedule *schedule;
@property (strong, nonatomic) KalDataProvider *dataProvider;

@end
