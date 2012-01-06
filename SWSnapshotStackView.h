////////////////////////////////////////////////////////////////////////////
/*!
 ** \file SWSnapshotStackView.h
 ** \brief Snapshot Stack Image View class definition file
 ** \author Scott White (support@scottwhite.id.au, http://github.com/snwau)
 **
 ** Snapshot Stack View provides an easy means of decorating your UIImage's
 ** of any aspect ratio with a rendered matte frame and associated drop 
 ** shadow. It also may render your image to look as though it is the top 
 ** photograph (or snapshot) within a stack of shots.
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
 ** \see SNWSnapshotStackView.m
 */
// Documentation of the code is formatted for use with the documentation
// package Doxygen (see http://www.doxygen.org/).
//
// Project     : iOS Common Components
// Component   : GUI/Views
// Platform    : iOS SDK 3.0+
//
////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>


// ********************************************************************** //
// TYPE DEFINITIONS
// ********************************************************************** //

//! Snapshot Position data structure
/*!
  Defines the centre position and angle of rotation about the centre of
  a snapshot.  Multiple snapshots at slightly varying positions then form
  a stack.
  
  Structure stores pre-calculated positions (which in future may be
  randomised upon initialisation of the view if configured to do so),
  which also allows the pre-calculation of the bounding rectangles of
  the snapshots in their specified positions (rotated and off-centre).
*/
typedef struct
{
  //! Centre point of rectangle (currently unused)
  //! Had thoughts of randomising and offsetting the centre points of
  //! underlying snapshots in the stack within a small radius of the views
  //! centre for make their placement look a little more adhoc and hence
  //! more natural. May update to make this functionality optional in the
  //! future.
  //CGPoint centre;
  
  //! Angle of rotation about the centre point, positive angle clockwise,
  //! negative angle counter-clockwise, specified in degrees.
  CGFloat angleRotation;
  
  //! Calculated size of bounding rectangle after rotation, as width and
  //! height protude outside the non-rotated base rectangle.  The bounding
  //! rectangle size is used to determine the required scaling to fit the
  //! snapshot within the views frame.
  CGSize boundingRectSize;
}
SnapshotPosition_t;


// ********************************************************************** //
// SNAPSHOT STACK VIEW CLASS
// ********************************************************************** //

#pragma mark Snapshot Stack View class

//! Snapshot Stack Image View
@interface SWSnapshotStackView : UIView 
{
  // ******************************************************************** //	
  // CONSTANTS

#pragma mark Constants

//! Number of snapshots to display within the stack of shots
#define SWSnapshotStackViewSnapshotsPerStack 3  


  // ******************************************************************** //	
  // MEMBER VARIABLES
  
  BOOL m_displayStack;    // property (displayAsStack)
  UIImage *m_image;       // property (image)
  
  //! Aspect Ratio of current image (Width/Height)
  CGFloat m_imageAspect;

  //! Array of defining the position of each snapshot in the stack, 
  //! defined from bottom of stack to the top, where the top image in
  //! the stack always has zero rotation.
  SnapshotPosition_t m_snapshotPositions[SWSnapshotStackViewSnapshotsPerStack];
  //! Index to snapshot within the positions array, requiring most scaling //! (minimum scaling factor) to fit within views frame.
  NSInteger m_minScaleShotIdx;
  //! Minimum scaling factor was calculated using image width (YES) otherwise
  //! height (NO), stored to avoid recalculation and comparison when drawing.
  BOOL m_scaledUsingWidth;
}


// ********************************************************************** //
// PROPERTIES

#pragma mark Properties

//! Display as a stack of multiple snapshots
/*!
    Display a stack of snapshots (YES) with the image provided within the
    image property as the top most snapshot, othwerwise display image as
    a single snapshot (NO).
 */
@property (nonatomic, assign) BOOL displayAsStack;

//! Image to display within the snapshot stack view
@property (nonatomic, retain) UIImage *image;


// ********************************************************************** //

@end  // @SWSnapshotStackView

// ********************************************************************** //

// End of File
