//
//  Schedule.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 02.08.12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface Schedule : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *lecturer;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDate *start;
@property (nonatomic, strong) NSDate *end;

/*
 initialize a Schedule object from a dictionary
 */
- (id)initWithDict:(NSDictionary *)scheduleDict;

/*
 convert to a EKEvent object
 */
- (EKEvent*)eventValue;
@end
