//
//  KalDataProvider.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "KalDataProvider.h"
#import "ScheduleManager.h"

@implementation KalDataProvider

@synthesize items = _items;
@synthesize events = _events;


- (id)init
{
    self = [super init];
    if (self) {
        // holds currently showing events
        _items = [[NSMutableArray alloc] init];
        
        // holds all events
        _events = [[NSMutableArray alloc] init];
        
        // fetches the schedule from the server
        ScheduleManager *scheduleManager = [[ScheduleManager alloc] init];
        [scheduleManager fetchschedule:^(NSArray *scheduleArray, NSError *error){
            if (!error) {
                _events = [scheduleArray mutableCopy];
            } else {
                // show alertview if error occurs
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alertView show];
            }
        }];
    }
    return self;
}

static BOOL IsDateBetweenInclusive(NSDate *date, NSDate *begin, NSDate *end)
{
    // Determine if a date is between to order dates. Return YES if it is the case. NO otherwise.
    return [date compare:begin] != NSOrderedAscending && [date compare:end] != NSOrderedDescending;
}

/*
 return all events from - to a date
 */
- (NSArray *)eventsFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    NSMutableArray *matches = [NSMutableArray array];
    // for all events
    for (Schedule *event in _events) {
        // if date is in range
        if (IsDateBetweenInclusive(event.start, fromDate, toDate)) {
            // add event to array of matches
            [matches addObject:event];
        }
    }
    
    return matches;
}

- (Schedule *)eventAtIndexPath:(NSIndexPath *)indexPath
{
    // get the event from the array that matches the row of the indexPath
    return [_items objectAtIndex:indexPath.row];
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    // Returns array of start dates for the event within the provided range
    return [[self eventsFrom:fromDate to:toDate] valueForKeyPath:@"start"];
}

- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    // Add events to the array of selected events that are within the provided range
    [_items addObjectsFromArray:[self eventsFrom:fromDate to:toDate]];
}

- (void)removeAllItems
{
    // remove all selected events
    [_items removeAllObjects];
}

- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
    [_items removeAllObjects];
    [delegate loadedDataSource:self];
}

#pragma mark UITableViewDataSource protocol conformance

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    Schedule *event = [self eventAtIndexPath:indexPath];
    cell.textLabel.text = event.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

@end
