////////////////////////////////////////////////////////////////////////////
/*!
 ** \file RootViewController.h
 ** \brief Root View Controller class definition file
 ** \author Scott White (support@scottwhite.id.au, http://github.com/snwau)
 **
 ** The root (and only) view controller responsible for displaying and
 ** controlling a Snapshot Stack View and associated controls for 
 ** demonstrating its capabilities such as dynamic frame adjustment,
 ** support for all image aspects and the selectable display modes (single
 ** or stack).
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
 ** \see RootViewController.m
 */
// Documentation of the code is formatted for use with the documentation
// package Doxygen (see http://www.doxygen.org/).
//
// Project     : Snapshot Stack View Demonstration
// Platform    : iOS SDK 3.0+
//
////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

#import "SWSnapshotStackView.h"


// ********************************************************************** //
// ROOT VIEW CONTROLLER CLASS
// ********************************************************************** //

#pragma mark Root View Controller class

@interface RootViewController : UIViewController
{
  // ******************************************************************** //	
  // MEMBER VARIABLES  
  
  UISwitch *m_displayStackSwitch;
  UISegmentedControl *m_imageSelection;
  UILabel *m_imageFrameSize;
  UISlider *m_sizeSlider;
  SWSnapshotStackView *m_snapshotStackView;  
}


// ********************************************************************** //
// PROPERTIES

#pragma mark Properties

@property (nonatomic, retain) IBOutlet UISwitch *displayStackSwitch;
@property (nonatomic, retain) IBOutlet UILabel *imageFrameSize;
@property (nonatomic, retain) IBOutlet UISegmentedControl *imageSelection;
@property (nonatomic, retain) IBOutlet UISlider *sizeSlider;
@property (nonatomic, retain) IBOutlet SWSnapshotStackView *snapshotStackView;


// ********************************************************************** //
// ACTION METHODS

#pragma mark Action Methods

- (IBAction)displayStackSwitchValueChanged:(id)sender;
- (IBAction)imageSelectionValueChanged:(id)sender;
- (IBAction)sizeSliderValueChanged:(id)sender;


// ********************************************************************** //

@end  // @RootViewController

// End of file
