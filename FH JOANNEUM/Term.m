//
//  Term.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//


#import "Term.h"
#import "Exam.h"

@implementation Term

@synthesize name = _name;
@synthesize exams = _exams;

- (id)initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        _name = [[dict objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"Studiengangssemester" withString:@"Semester"];
        
        NSMutableArray *exams = [[NSMutableArray alloc] init];
        for (NSDictionary *examDict in [dict objectForKey:@"Exams"]) {
            Exam *exam = [[Exam alloc] initWithDict:examDict];
            [exams addObject:exam];
        }
        
        _exams = [exams copy];
    }
    return self;
}

@end
