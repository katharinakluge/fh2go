//
//  NewsManager.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsManager : NSObject

@property (nonatomic, strong) NSOperationQueue *queue;

/*
 method to fetch the news from the server
 has one @parameter completion, which is a block that uses the following paramters: (void(^)(NSArray *newsArray,NSError *error))
 */
- (void)fetchNews:(void(^)(NSArray *newsArray,NSError *error)) completion;


@end
