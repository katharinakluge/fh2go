//
//  News.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize title = _title;
@synthesize description = _description;
@synthesize link = _link;


- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _title = [dict objectForKey:@"title"];
        _link = [dict objectForKey:@"link"];
        _description = [dict objectForKey:@"description"];
    }
    
    return self;
}

@end
