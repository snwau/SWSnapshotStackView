////////////////////////////////////////////////////////////////////////////
/*!
 ** \file SWSnapshotStackView.h
 ** \brief Snapshot Stack Image View
 ** \author Scott White (http://github.com/snwau)
 **
 ** [TBD]
 **
 ** Copyright (c) 2011 Scott White. All rights reserved.
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
 ** \see SNWSnapshotStackView.m
 */
// Documentation of the code is formatted for use with the documentation
// package Doxygen (see http://www.doxygen.org/).
//
// Project     : iOS Common Components
// Component   : GUI/Views
// Platform    : iOS 3.0+
//
////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>


// ********************************************************************** //
// SNAPSHOT STACK VIEW CLASS
// ********************************************************************** //

#pragma mark Snapshot Stack View class

//! Custom Snapshot Stack Image View
@interface SWSnapshotStackView : UIView 
{
  // ******************************************************************** //	
  // MEMBER VARIABLES
  
  BOOL m_displayStack;
  UIImage *m_image;
  CGFloat m_imageAspect;
  BOOL m_scaleByWidth;
  
  UIImageView *m_imageView;
}


// ********************************************************************** //
// PROPERTIES

#pragma mark Properties

//! Display as a stack of snapshots
/*!
    Display a stack of snapshots (YES), othwerwise display as a single 
    snapshot (NO).
 */
@property (nonatomic, assign) BOOL displayAsStack;
@property (nonatomic, retain) UIImage *image;


// ********************************************************************** //
// INSTANCE METHODS

#pragma mark Instance Methods


// ********************************************************************** //

@end  // @SWSnapshotStackView

// ********************************************************************** //

// End of File
