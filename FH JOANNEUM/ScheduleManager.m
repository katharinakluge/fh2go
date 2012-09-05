//
//  ScheduleManager.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 02.08.12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "ScheduleManager.h"
#import "Schedule.h"
#import "TouchXML.h"
#import "SettingsManager.h"

@implementation ScheduleManager

@synthesize scheduleQueue = _scheduleQueue;

-(id)init {
    self = [super init];
    if (self) {
        _scheduleQueue = [[NSOperationQueue alloc] init];
        
        // A maximum of concurrent operations
        [_scheduleQueue setMaxConcurrentOperationCount:4];
    }
    
    return self;
}

- (void)fetchschedule:(void(^)(NSArray *scheduleArray,NSError *error)) scheduleCompletion {
    
    NSString *year = [[SettingsManager sharedInstance] year];
    NSString *department = [[SettingsManager sharedInstance] department];
    
    NSString *requestString = [NSString stringWithFormat:@"https://ws.fh-joanneum.at/getschedule.php?c=%@&y=%@&k=LOvkZCPesk",department,year];
    
    /*
     creates the request from a URL
     */
    NSURLRequest *scheduleRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30];
    
    /*
     now an asynchronous reqest will be initated to return the schedule
     */
    [NSURLConnection sendAsynchronousRequest:scheduleRequest queue:_scheduleQueue completionHandler:^(NSURLResponse *scheduleResponse, NSData *scheduleData, NSError *error) {
        
        //If the request returned an error
        if(error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                scheduleCompletion(nil,error); 
            });
        } else {
            // Array to hold the returned data
            NSMutableArray *responseScheduleArray = [[NSMutableArray alloc] init];
            
            // Create a XMLDocument from the returned data
            CXMLDocument *xmlScheduleDoc = [[CXMLDocument alloc] initWithData:scheduleData encoding:NSUTF8StringEncoding options:0 error:nil];
            
            // Checks if the request was succesfull by looking at the Status returned
            if(![[[xmlScheduleDoc nodeForXPath:@"//Status" error:nil] stringValue] isEqualToString:@"OK"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Create error
                    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                    [errorDetail setValue:@"Something went wrong. Please check your credentials in settings." forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain:@"None" code:100 userInfo:errorDetail];
                    // run completion block with error
                    scheduleCompletion(nil,error);
                });
                // No need to continue parsing when server returns bad status. Return method!
                return;
            }
            
            // Parses the XML into objects
            NSArray *responseScheduleNodes = [xmlScheduleDoc nodesForXPath:@"//Event" error:nil];
            for (CXMLElement *nodeSchedule in responseScheduleNodes) {
                NSMutableDictionary *itemSchedule = [[NSMutableDictionary alloc] init];
                
                for (CXMLNode *childScheduleNode in [nodeSchedule children]) {
                    [itemSchedule setObject:[childScheduleNode stringValue] forKey:[childScheduleNode name]];
                }
                
                Schedule *schedule = [[Schedule alloc] initWithDict:itemSchedule];
                [responseScheduleArray addObject:schedule];
                
            }
            
            /*
             this will lead the execution again back to the main thread
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                scheduleCompletion([NSArray arrayWithArray:responseScheduleArray], nil);
            }
                           );
            
            
        }
    }];
    
}

@end