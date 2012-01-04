////////////////////////////////////////////////////////////////////////////
/*!
 ** \file AppDelegate.h
 ** \brief Application Delegate class definition file
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
 ** \see AppDelegate.m
 */
// Documentation of the code is formatted for use with the documentation
// package Doxygen (see http://www.doxygen.org/).
//
// Project     : Snapshot Stack View Demonstration
// Platform    : iOS SDK 3.0+
//
////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

#import "RootViewController.h"


// ********************************************************************** //
// APPLICATION DELEGATE CLASS
// ********************************************************************** //

#pragma mark Application Delegate class

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
  
}


// ********************************************************************** //
// PROPERTIES

#pragma mark Properties

@property (strong, nonatomic) RootViewController *viewController;
@property (strong, nonatomic) UIWindow *window;


// ********************************************************************** //

@end  // @AppDelegate

// End of file