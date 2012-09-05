//
//  KalDataProvider.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Kal.h"
#import "Schedule.h"

@interface KalDataProvider : NSObject <KalDataSource>

@property (strong, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) NSMutableArray *items;


/*
 Returns a schedule at a specific indexPath
 */
- (Schedule *)eventAtIndexPath:(NSIndexPath *)indexPath;


@end
