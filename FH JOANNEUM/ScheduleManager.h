//
//  ScheduleManager.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 02.08.12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleManager : NSObject

@property (nonatomic, strong) NSOperationQueue *scheduleQueue;

/*
 method to fetch the schedule from the server
 has one @parameter completion, which is a block that uses the following paramters: (void(^)(NSArray *scheduleArray,NSError *error))
 */
-(void)fetchschedule:(void(^)(NSArray *scheduleArray,NSError *error)) scheduleCompletion;

@end
