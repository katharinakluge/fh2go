//
//  Grade.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Grade : NSObject

@property(strong,nonatomic) NSString *title;
@property(nonatomic) int gradeValue;
@property(strong,nonatomic) NSString *gradeDescription;

/*
 initialize a Grade object from a dictionary
 */
- (id)initWithDict:(NSDictionary*)dict;

@end
