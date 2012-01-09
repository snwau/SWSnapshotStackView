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
 ** Permission is hereby granted, free of charge, to any person obtaining a
 ** copy of this software and associated documentation files (the "Software"),
 ** to deal in the Software without restriction, including without limitation
 ** the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 ** and/or sell copies of the Software, and to permit persons to whom the 
 ** Software is furnished to do so, subject to the following conditions:
 **
 ** The above copyright notice and this permission notice shall be included 
 ** in all copies or substantial portions of the Software.
 **
 ** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 ** OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
 ** MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 ** IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 ** CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
 ** TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
 ** SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 **
 ** Open Source Initiative OSI - The MIT License, 
 ** see <http://www.opensource.org/licenses/MIT/>.
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