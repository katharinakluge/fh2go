//
//  InfoViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "InfoViewController.h"

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Load Info.txt from main bundle
    NSString *infoTextPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"txt"];
    NSError *error = nil;
    
    // Convert to string
    NSString *infoText = [NSString stringWithContentsOfFile:infoTextPath encoding:NSUTF8StringEncoding error:&error];
    
    if(error !=nil){
        NSLog(@"An Error has been occured: %@", [error localizedDescription]);
    }else {
        // Update textview with content
        _viewInfoText.text = infoText;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
