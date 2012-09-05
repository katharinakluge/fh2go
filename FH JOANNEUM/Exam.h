//
//  Exam.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exam : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *mode;
@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) NSString *registrationString;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSDate *registrationDate;
@property (strong, nonatomic) NSString *status;

/*
 initialize a Exam object from a dictionary
 */
- (id)initWithDict:(NSDictionary*)dict;

@end
