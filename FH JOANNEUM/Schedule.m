//
//  Schedule.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 02.08.12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

@synthesize title = _title;
@synthesize lecturer = _lecturer;
@synthesize location = _location;
@synthesize type = _type;
@synthesize start = _start;
@synthesize end = _end;

static EKEventStore *eventStore;

+ (void)initialize {
    eventStore = [[EKEventStore alloc]init];
}

- (id)initWithDict:(NSDictionary *)scheduleDict {
    self = [super init];
    if (self) {
        _title = [scheduleDict objectForKey:@"Title"];
        _lecturer = [scheduleDict objectForKey:@"Lecturer"];
        _location = [scheduleDict objectForKey:@"Location"];
        _type = [scheduleDict objectForKey:@"Type"];
        _start = [[NSDate alloc] initWithTimeIntervalSince1970:[[scheduleDict objectForKey:@"Start"] intValue]];
        _end = [[NSDate alloc] initWithTimeIntervalSince1970:[[scheduleDict objectForKey:@"End"] intValue]];
    }
    return self;
}


- (EKEvent*)eventValue {    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    [event setStartDate:_start];
    [event setEndDate:_end];
    [event setTitle:_title];
    [event setLocation:_location];
    NSString *noteString = [NSString stringWithFormat:@"Lecturer: %@\nType: %@",_lecturer,_type];
    [event setNotes:noteString];
    
    return event;
}

@end