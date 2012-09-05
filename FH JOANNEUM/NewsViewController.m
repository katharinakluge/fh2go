//
//  NewsViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsManager.h"
#import "News.h"
#import "NewsTableViewCell.h"
#import "BrowserViewController.h"


@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize newsArray = _newsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the background image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    [self.tableView setBackgroundView:backgroundView];
    
    // Style the table view
    [self.tableView setRowHeight:120];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCellIdentifier"];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    /*
     the spinning wheel, which indicates that the news articles are loading right now
     */
    UIActivityIndicatorView *loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadingIndicator setCenter:CGPointMake(self.view.center.x, self.view.center.y-50)];
    [loadingIndicator startAnimating];
    [self.view addSubview:loadingIndicator];
    
    /*
     shows the news on the display if no error occured 
     */
    NewsManager *newsManager = [[NewsManager alloc] init];
    [newsManager fetchNews:^(NSArray *newsArray, NSError *error){
        [loadingIndicator stopAnimating];
        if (!error) {
            self.newsArray = newsArray;
            [self.tableView reloadData];
            [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            
        } else {
            NSLog(@"NEWS ERROR");
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.newsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCellIdentifier";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    News *news = [self.newsArray objectAtIndex:indexPath.row];    
    [cell.titleLabel setText:news.title];
    [cell.detailLabel setText:news.description];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"BrowserSegueID" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BrowserSegueID"])
    {
        // Gives the URL of the clicked news to the BrowserViewController
        News *news = [self.newsArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        BrowserViewController *browserViewController = segue.destinationViewController;
        [browserViewController setURL:[NSURL URLWithString:news.link]];
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
        
    }
}

@end
