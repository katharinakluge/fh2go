//
//  SettingsManager.h
//  FH JOANNEUM
//
//  Created by Katharina Kluge on 28/08/12.
//  Copyright (c) 2012 Katharina Kluge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsManager : NSObject

/* 
  Returns a singleton shared instance of the class
*/
+(SettingsManager *)sharedInstance;

/*
 Return the password. Returns nil if not set
 */
- (NSString*)password;

/*
 Return the username. Returns nil if not set
 */
- (NSString*)username;

/*
 Stores username and password in keychain
 */
- (void)setUsername:(NSString*)username password:(NSString*)password;

/*
 Returns the selected department
 */
- (NSString*)department;

/*
 Returns the selected year
 */
- (NSString*)year;

/*
 sets the selected years
 */
- (void)setYear:(NSString*)year;

/*
 sets the selected department
 */
- (void)setDepartment:(NSString*)department;

/*
 returns an array of departments
 */
- (NSArray*)departments;

@end
