//
//  YearViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 30/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "YearViewController.h"
#import "SettingsManager.h"

@interface YearViewController ()
@property (nonatomic) NSMutableArray *years;
@end

@implementation YearViewController

@synthesize years = _years;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Array of selectable years
    _years = [[NSMutableArray alloc] init];
    
    NSDate *curentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:curentDate];
    
    // The current year according to the date set on the device
    int currentYear = [components year];
    
    // 3 years back and 1 year ahead.
    for (int i =currentYear-3; i < currentYear+2; i++) {
        [_years addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_years count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[_years objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // set new selected year
    [[SettingsManager sharedInstance] setYear:[_years objectAtIndex:indexPath.row]];
    
    // pop the viewcontroller of the navigationcontroller stack
    [self.navigationController popViewControllerAnimated:YES];
}


@end
