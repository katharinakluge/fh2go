//
//  Mark.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Semester : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *grades;

/*
 initialize a Semester object from a dictionary
 */
- (id)initWithDict:(NSDictionary*)dict;

@end
