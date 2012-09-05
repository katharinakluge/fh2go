//
//  Exam.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "Exam.h"

@implementation Exam

@synthesize identifier =_identifier;
@synthesize title = _title;
@synthesize type = _type;
@synthesize mode = _mode;
@synthesize dateString = _dateString;
@synthesize registrationString = _registrationString;
@synthesize date = _date;
@synthesize registrationDate = _registrationDate;
@synthesize status = _status;

- (id)initWithDict:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        _identifier = [dict objectForKey:@"Id"];
        _title = [dict objectForKey:@"Title"];
        _type = [dict objectForKey:@"Type"];
        _mode = [dict objectForKey:@"Mode"];
        _dateString = [dict objectForKey:@"Date"];
        _registrationString = [dict objectForKey:@"RegistrationEnd"];
        _date = [[NSDate alloc] initWithTimeIntervalSince1970:[[dict objectForKey:@"DateUnix"] intValue]];
        _registrationDate = [[NSDate alloc] initWithTimeIntervalSince1970:[[dict objectForKey:@"RegistrationEndUnix"] intValue]];
        _status = [dict objectForKey:@"ExamStatus"];
    }
    return self;
}


@end
