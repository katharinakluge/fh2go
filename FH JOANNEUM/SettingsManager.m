//
//  SettingsManager.m
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 28/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import "SettingsManager.h"
#import "SSKeychain.h"

#define kLoginKey @"LoginKey"
#define kDepartmentKey @"DepartmentKey"
#define kYearKey @"YearKey"

@interface SettingsManager () {
    
    NSString *_username;
}

@end

@implementation SettingsManager

+(SettingsManager *)sharedInstance {
    // static reference to instance
    static SettingsManager *sharedInstance = nil;
    static dispatch_once_t pred;
    
    //if already initialized. Return the instance 
    if (sharedInstance) return sharedInstance;
    
    // Only run this code once.
    dispatch_once(&pred, ^{
        sharedInstance = [SettingsManager alloc];
        sharedInstance = [sharedInstance init];
    });
    
    return sharedInstance;
}

- (void)setUsername:(NSString*)username password:(NSString*)password {
    // Remove old username and password from keychain
    [SSKeychain deletePasswordForService:kLoginKey account:_username];
    
    // save the new username and password
    [SSKeychain setPassword:password forService:kLoginKey account:username];
}

- (NSString*)password {
    // get the accouns for service. Should never return more than 1
    NSArray *accounts = [SSKeychain accountsForService:kLoginKey];
    
    // If we got an account
    if (accounts && [accounts count]>0) {
        // return password for that account
        return [SSKeychain passwordForService:kLoginKey account:[[accounts objectAtIndex:0] objectForKey:@"acct"]];
    }
    
    // return nil if no account was found
    return nil;
}

- (NSString*)username {
    // get the accouns for service. Should never return more than 1
    NSArray *accounts = [SSKeychain accountsForService:kLoginKey];
    // If we got an account
    if (accounts && [accounts count]>0) {
        //save username for that account. Used for deleting the password and username if later updated.
        _username = [[accounts objectAtIndex:0] objectForKey:@"acct"];
        // return that username
        return _username;
    }
    
    // return nil if no account was found
    return nil;
}

- (void)setYear:(NSString*)year {
    // save year in userdefaults
    [[NSUserDefaults standardUserDefaults] setObject:year forKey:kYearKey];
}

- (void)setDepartment:(NSString*)department {
    // save department in userdefaults
    [[NSUserDefaults standardUserDefaults] setObject:department forKey:kDepartmentKey];
}

- (NSString*)year {
    // return year from userdefaults
    return [[NSUserDefaults standardUserDefaults] objectForKey:kYearKey];
}

- (NSString*)department {
    // return department from userdefaults
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDepartmentKey];
}

- (NSArray*)departments {
    // find the Departments.plist file in the main bundle
    NSBundle* bundle = [NSBundle mainBundle];
	NSString* plistPath = [bundle pathForResource:@"Departments" ofType:@"plist"];
    
    // Make array of content
	NSArray* departments = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    //return array
    return departments;
}

@end
