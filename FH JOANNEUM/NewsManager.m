//
//  NewsManager.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "NewsManager.h"
#import "News.h"
/*
 predefined class, for a better XML fetch
 */
#import "TouchXML.h"

@implementation NewsManager

@synthesize queue = _queue;

- (id)init {
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        
        // A maximum of concurrent operations
        [_queue setMaxConcurrentOperationCount:4];
    }
    return self;
}

- (void)fetchNews:(void(^)(NSArray *newsArray,NSError *error)) completion {
    
    /*
     creates the request from a URL
     */
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://ws.fh-joanneum.at/getnews.php?k=LOvkZCPesk"] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30];
    
    /*
     creates an asynchronous request using the request variable created above 
     also includes a block which returns the content of the news if no error occured, otherwise returns an error
     */
    [NSURLConnection sendAsynchronousRequest:request queue:_queue completionHandler:^(NSURLResponse *response, NSData *date, NSError *error){
        
        //If the request returned an error
        if (error) {
            /*
             executes this again on the main thread
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
                
            });
        } else {
            // Array to hold the returned data
            NSMutableArray *responseArray = [[NSMutableArray alloc] init];
            
            // Create a XMLDocument from the returned data
            CXMLDocument *xmlDoc = [[CXMLDocument alloc] initWithData:date encoding:NSUTF8StringEncoding options:0 error:nil];
            
            // Parses the XML into objects
            NSArray *responseNodes = [xmlDoc nodesForXPath:@"//item" error:nil];
            for (CXMLElement *node in responseNodes) {
                NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
                
                for (CXMLNode *childNode in [node children]) {
                    [item setObject:[childNode stringValue] forKey:[childNode name]];
                }
                
                News *news = [[News alloc] initWithDict:item];
                [responseArray addObject:news];
            }
            
            /*
             will be executed on the main thread again
             dispatch_get_main_queue() -> C funktion will return the main queue
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                completion([NSArray arrayWithArray:responseArray], nil);
                
            });
        }
    }];
    
}

@end