//
//  MarksViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "MarksViewController.h"
#import "MarkManager.h"
#import "MarkTableViewCell.h"
#import "Grade.h"
#import "Semester.h"

@interface MarksViewController ()

@end

@implementation MarksViewController

@synthesize markArray = _markArray;


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

    // set the background image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    [self.tableView setBackgroundView:backgroundView];
    
    // style the tableview
    [self.tableView setRowHeight:52];
    [self.tableView registerNib:[UINib nibWithNibName:@"MarkTableViewCell" bundle:nil] forCellReuseIdentifier:@"MarkCellIdentifier"];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setAllowsSelection:NO];
    
    /*
     the spinning wheel, which indicates that the marks are loading right now
     */
    UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadingIndicator setCenter:CGPointMake(self.view.center.x, self.view.center.y-50)];
    [loadingIndicator startAnimating];
    [self.view addSubview:loadingIndicator];
    
    /*
     shows the marks on the display if no error occured
     */
    MarkManager *markManager = [[MarkManager alloc] init];
    [markManager fetchMarks:^(NSArray *markArray, NSError *error){
        [loadingIndicator stopAnimating];
        if (!error) {
            self.markArray = markArray;
            [self.tableView reloadData];
            [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Notice" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
        }
    }];
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

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.markArray objectAtIndex:section] name];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.markArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[self.markArray objectAtIndex:section] grades] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MarkCellIdentifier";
    MarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    Grade *mark = [[[self.markArray objectAtIndex:indexPath.section] grades] objectAtIndex:indexPath.row];
    
    [cell.titleLabel setText:mark.title];
    [cell.gradeLabel setText:[NSString stringWithFormat:@"%d",mark.gradeValue]];
    [cell.gradeDescriptionLabel setText:mark.gradeDescription];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
