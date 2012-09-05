//
//  DepartmentsViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 30/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "DepartmentsViewController.h"
#import "SettingsManager.h"

@interface DepartmentsViewController ()

@property (nonatomic) NSArray *departments;

@end

@implementation DepartmentsViewController

@synthesize departments = _departments;

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
    
    // get departments from settingsmanager
    _departments = [[SettingsManager sharedInstance] departments];
    
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
    return [_departments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[_departments objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // set new selected department
    [[SettingsManager sharedInstance] setDepartment:[_departments objectAtIndex:indexPath.row]];
    // pop the viewcontroller of the navigationcontroller stack
    [self.navigationController popViewControllerAnimated:YES];
}

@end
