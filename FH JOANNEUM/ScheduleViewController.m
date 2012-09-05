//
//  ScheduleViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "ScheduleViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "KalDataProvider.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

@synthesize dataProvider = _dataProvider;
@synthesize schedule = _schedule;



- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Create the dataprovider and set it as data source
    _dataProvider = [[KalDataProvider alloc] init];
    [self setDataSource:_dataProvider];
    self.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create button in right corner that will go to todays date
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)];
}

- (void)showAndSelectToday
{
    // Call method in super class. Set the selected date to todays date.
    [self showAndSelectDate:[NSDate date]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    // Display a details screen for the selected event/row.
    EKEventViewController *vc = [[EKEventViewController alloc] init];
    UITableView *eventTableView = [[vc.view subviews]objectAtIndex:0];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    [eventTableView setBackgroundView:backgroundView];
    Schedule *schedule = [_dataProvider eventAtIndexPath:indexPath];
    vc.event = [schedule eventValue];
    vc.allowsEditing = NO;
    [vc.navigationItem setRightBarButtonItem:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
