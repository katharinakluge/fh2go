//
//  Grade.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "Grade.h"

@implementation Grade

@synthesize title = _title;
@synthesize gradeValue = _gradeValue;
@synthesize gradeDescription = _gradeDescription;

- (id)initWithDict:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        _title = [dict objectForKey:@"Title"];
        _gradeValue = [[dict objectForKey:@"Grade"] intValue];
        _gradeDescription = [dict objectForKey:@"GradeWords"];
    }
    return self;
}

@end
