//
//  SettingsViewController.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 25/07/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsManager.h"



@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize usernameLabel = _usernameLabel;
@synthesize passwordLabel = _passwordLabel;
@synthesize departmentLabel = _departmentLabel;
@synthesize yearLabel = _yearLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
      
    // Set the background image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
    [self.tableView setBackgroundView:backgroundView];
    
    // Get username and password from settingsmanager
    SettingsManager *settingsManager = [SettingsManager sharedInstance];
    NSString *username = [settingsManager username];
    NSString *password = [settingsManager password];
    
    // if we got a username
    if (username) {
        [_usernameLabel setText:username];
    }
    
    // if we got a password
    if (password) {
        [_passwordLabel setText:password];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    // get department from settingsmanager
    NSString *department = [[SettingsManager sharedInstance] department];
    [_departmentLabel setText:department];
    
    // get year from settingsmanager
    NSString *year = [[SettingsManager sharedInstance] year];
    [_yearLabel setText:year];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    // Update settingsmanager with current username and password
    SettingsManager *settingsManager = [SettingsManager sharedInstance];
    [settingsManager setUsername:_usernameLabel.text password:_passwordLabel.text];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // if username cell is selected
    if (indexPath.section == 0 && indexPath.row == 0) {
        // select the username textfield
        [_usernameLabel becomeFirstResponder];
    } else if (indexPath.section == 0 && indexPath.row == 1) { // or if password cell is selected
        // select the password textfield
        [_passwordLabel becomeFirstResponder];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // remove keyboard when return is clicked
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setUsernameLabel:nil];
    [self setPasswordLabel:nil];
    [self setDepartmentLabel:nil];
    [self setYearLabel:nil];
    [super viewDidUnload];
}
@end
