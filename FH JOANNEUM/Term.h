//
//  Term.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Term : NSObject

@property (nonatomic, strong) NSArray *exams;
@property (nonatomic, strong) NSString *name;

/*
 initialize a Term object from a dictionary
 */
- (id)initWithDict:(NSDictionary*)dict;

@end
