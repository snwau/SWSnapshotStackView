////////////////////////////////////////////////////////////////////////////
/*!
 ** \file AppDelegate.m
 ** \brief Application Delegate class implementation file
 ** \author Scott White (support@scottwhite.id.au, http://github.com/snwau)
 **
 ** Application Delegate class auto-generated via Xcode project wizard.
 **
 ** Copyright (c) 2012 Scott White. All rights reserved.
 **
 ** This program is free software: you can redistribute it and/or modify
 ** it under the terms of the GNU General Public License as published by
 ** the Free Software Foundation, either version 3 of the License, or
 ** (at your option) any later version.
 ** 
 ** This program is distributed in the hope that it will be useful,
 ** but WITHOUT ANY WARRANTY; without even the implied warranty of
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ** GNU General Public License for more details.
 ** 
 ** You should have received a copy of the GNU General Public License
 ** along with this program.  If not, see <http://www.gnu.org/licenses/>. 
 **
 ** \see AppDelegate.h
 */
// Documentation of the code is formatted for use with the documentation
// package Doxygen (see http://www.doxygen.org/).
//
// Project     : Snapshot Stack View Demonstration
// Platform    : iOS SDK 3.0+
//
////////////////////////////////////////////////////////////////////////////

#import "AppDelegate.h"


// ********************************************************************** //
// APPLICATION DELEGATE CLASS
// ********************************************************************** //

#pragma mark Application Delegate class

@implementation AppDelegate

// ********************************************************************** //
// PROPERTIES

#pragma mark Properties

@synthesize window = _window;
@synthesize viewController = _viewController;


// ********************************************************************** //
// INSTANCE METHODS

#pragma mark Instance Methods

- (void)dealloc
{
  [_window release];
  [_viewController release];
  
  [super dealloc];
}


// ********************************************************************** //

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  
  // Override point for customization after application launch.
  self.viewController = [[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil] autorelease];
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  return (YES);
}


// ********************************************************************** //

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}


// ********************************************************************** //

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}


// ********************************************************************** //

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}


// ********************************************************************** //

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}


// ********************************************************************** //

- (void)applicationWillTerminate:(UIApplication *)application
{
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}


// ********************************************************************** //

@end  // @AppDelegate

// End of file
