//
//  Mark.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "Semester.h"
#import "Grade.h"

@implementation Semester

@synthesize name = _name;
@synthesize grades = _grades;

- (id)initWithDict:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        _name = [[dict objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"Studiengangssemester" withString:@"Semester"];

        NSMutableArray *grades = [[NSMutableArray alloc] init];
        for (NSDictionary *gradeDict in [dict objectForKey:@"Courses"]) {
            Grade *grade = [[Grade alloc] initWithDict:gradeDict];
            [grades addObject:grade];
        }
        
        _grades = [grades copy];
    }
    return self;
}

@end
