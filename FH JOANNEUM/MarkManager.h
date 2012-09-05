//
//  MarkManager.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarkManager : NSObject

@property (nonatomic, strong) NSOperationQueue *queue;

/*
 method to fetch the marks from the server
 has one @parameter completion, which is a block that uses the following paramters: (void(^)(NSArray *marksArray,NSError *error))
 */
- (void)fetchMarks:(void(^)(NSArray *marksArray,NSError *error)) completion;

@end
