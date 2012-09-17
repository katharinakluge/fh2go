//
//  ExamsViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "ExamsViewController.h"
#import "Term.h"
#import "Exam.h"
#import "ExamManager.h"
#import "ExamTableViewCell.h"

@interface ExamsViewController ()

@end

@implementation ExamsViewController

@synthesize examArray = _examArray;


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
    [self.tableView setRowHeight:82];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExamTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExamCellIdentifier"];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setAllowsSelection:NO];
    
    /*
     the spinning wheel, which indicates that the page is loading right now
     */
    UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadingIndicator setCenter:CGPointMake(self.view.center.x, self.view.center.y-50)];
    [loadingIndicator startAnimating];
    [self.view addSubview:loadingIndicator];
    
    /*
      displays the server return, if no error occured
     */
    ExamManager *examManager = [[ExamManager alloc] init];
    [examManager fetchExams:^(NSArray *examArray, NSError *error){
        [loadingIndicator stopAnimating];
        if (!error) {
            self.examArray = examArray;
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
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

/*
 returns the name of the semester for the section title
 */
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.examArray objectAtIndex:section] name];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.examArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[self.examArray objectAtIndex:section] exams] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ExamCellIdentifier";
    ExamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
   /* 
    Configures the cell, and shows the user the name of the exam, when it is, if the user is enrolled or when the last day for enrollment is 
    */
    Exam *exam = [[[self.examArray objectAtIndex:indexPath.section] exams] objectAtIndex:indexPath.row];
    
    [cell.titleLabel setText:exam.title];
    if ([exam.status isEqualToString:@"registered"]) {
        [cell.descriptionLabel setText:[NSString stringWithFormat:@"Status: %@",exam.status]];
    } else if(exam.registrationString){
        [cell.descriptionLabel setText:[NSString stringWithFormat:@"Register before: %@",exam.registrationString]];
    } else {
        [cell.descriptionLabel setText:@""];
    }
    
    [cell.dateLabel setText:exam.dateString];
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
