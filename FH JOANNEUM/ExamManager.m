//
//  ExamManager.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 19/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "ExamManager.h"
#import "TouchXML.h"
#import "Term.h"
#import "SettingsManager.h"

@implementation ExamManager

@synthesize queue = _queue;

- (id)init{
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        
        // A maximum of concurrent operations
        [_queue setMaxConcurrentOperationCount:4];
    }
    return self;
}

- (void)fetchExams:(void(^)(NSArray *examArray,NSError *error)) completion {
    
    // Get username and password from settings manager
    NSString *username = [[SettingsManager sharedInstance] username]; 
    NSString *password = [[SettingsManager sharedInstance] password]; 
    
    
    // if no username or password is set
    if (!username || !password || username.length==0 || password.length==0) {
        // create error
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue:@"Invalid user credentials. Go to settings and enter your credentials." forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"None" code:100 userInfo:errorDetail];
        // run completion block with error
        completion(nil,error);
        // No need to request server when no username or password. Return method!
        return;
    }
    
    // create URL string with username and password included
    NSString *requestString = [NSString stringWithFormat:@"https://ws.fh-joanneum.at/getmarks.php?u=%@&p=%@&k=LOvkZCPesk",username,password];
    
    /*
     creates the request from the URL string
     */
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30];
    
    /*
     creates an asynchronous request using the request variable created above
     also includes a block which returns the content of the exams if no error occured, otherwise returns an error
     */
    [NSURLConnection sendAsynchronousRequest:request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        //If the request returned an error
        if (error) {
            /*
             execute completion block on main thread
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
                
            });
        } else {
            // Array to hold the returned data
            NSMutableArray *responseArray = [[NSMutableArray alloc] init];
            
            // Create a XMLDocument from the returned data
            CXMLDocument *xmlDoc = [[CXMLDocument alloc] initWithData:data encoding:NSUTF8StringEncoding options:0 error:nil];
            
            // Checks if the request was succesfull by looking at the Status returned
            if(![[[xmlDoc nodeForXPath:@"//Status" error:nil] stringValue] isEqualToString:@"OK"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Create error
                    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                    [errorDetail setValue:@"Something went wrong. Please check your credentials in settings." forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain:@"None" code:100 userInfo:errorDetail];
                    // run completion block with error
                    completion(nil,error);
                });
                // No need to continue parsing when server returns bad status. Return method!
                return;
            }
            
            
            // Parses the XML into objects
            NSArray *responseNodes = [xmlDoc nodesForXPath:@"//Term" error:nil];
            for (CXMLElement *node in responseNodes) {
                NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
                
                [item setObject:[[node attributeForName:@"name"] stringValue] forKey:@"name"];
                
                NSMutableArray *courses = [[NSMutableArray alloc] init];
                
                for (CXMLNode *childNode in [node children]) {
                    NSMutableDictionary *c = [[NSMutableDictionary alloc] init];
                    
                    for (CXMLNode *childChildNode in [childNode children]) {
                        [c setObject:[childChildNode stringValue] forKey:[childChildNode name]];
                    }
                    [courses addObject:c];
                }
                
                [item setObject:courses forKey:@"Exams"];
                
                Term *term = [[Term alloc] initWithDict:item];
                [responseArray addObject:term];
            }
            
            /*
             will be executed on the main thread again
             dispatch_get_main_queue() -> C function will return the main queue
             */
            dispatch_async(dispatch_get_main_queue(), ^{
                completion([NSArray arrayWithArray:responseArray], nil);
                
            });
        }
    }];
    
}

@end