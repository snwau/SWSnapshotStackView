////////////////////////////////////////////////////////////////////////////
/*!
 ** \file SWSnapshotStackView.m
 ** \brief Snapshot Stack Image View class implementation file
 ** \author Scott White (support@scottwhite.id.au, http://github.com/snwau)
 **
 ** Snapshot Stack View provides an easy means of decorating your UIImage's
 ** of any aspect ratio with a rendered matte frame and associated drop 
 ** shadow. It also may render your image to look as though it is the top 
 ** photograph (or snapshot) within a stack of shots.
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
 ** MIT License, see <http://www.opensource.org/licenses/MIT/>.
 **
 ** \see SWSnapshotStackView.h
 */
// Documentation of the code is formatted for use with the documentation
// package Doxygen (see http://www.doxygen.org/).
//
// Project     : iOS Common Components
// Component   : GUI/Views
// Platform    : iOS SDK 3.1+
//
////////////////////////////////////////////////////////////////////////////

#import "SWSnapshotStackView.h"


// ********************************************************************** //
// SNAPSHOT STACK VIEW CLASS (PRIVATE METHODS)
// ********************************************************************** //

#pragma mark Snapshot Stack View class (Private Interface)

@interface SWSnapshotStackView (Private)

//! Perform common initialisation activities
- (void)commonInitialisation;
//! Calculate the scaling required to fit the rotated snapshots in views frame
- (void)calculateScalingToFitStack;

@end


// ********************************************************************** //
// SNAPSHOT STACK VIEW CLASS
// ********************************************************************** //

#pragma mark - Snapshot Stack View class

@implementation SWSnapshotStackView

// ********************************************************************** //
//  CONSTANTS

#pragma mark Constants

//! Defines the width of the matte border around a snapshot (each side)
#define SWSnapshotStackViewMatteWidth          7.0

// SINGLE DISPLAY MODE CONSTANTS
//! Defines X offset for either edge to indent shadow effect (single mode)
#define SWSnapshotStackViewSingleShadowXOffset 5.0
//! Defines Y offset to drop shadow below snapshot matte frame 
#define SWSnapshotStackViewSingleShadowYOffset 5.0
//! Defines radius of the shadow (results in magnitude and softness of shadow)
#define SWSnapshotStackViewSingleShadowRadius  5.0
#define SWSnapshotStackViewSingleShadowTotalHeight (SWSnapshotStackViewSingleShadowYOffset + SWSnapshotStackViewSingleShadowRadius)

// STACK DISPLAY MODE CONSTANTS
//! Defines Y offset to drop shadow below snapshot matte frame 
#define SWSnapshotStackViewStackShadowYOffset  2.0
//! Defines radius of the shadow (results in magnitude and softness of shadow)
#define SWSnapshotStackViewStackShadowRadius   6.0
#define SWSnapshotStackViewStackShadowTotalHeight ((2 * SWSnapshotStackViewStackShadowRadius) - SWSnapshotStackViewStackShadowYOffset)


// ********************************************************************** //
//  PROPERTIES

#pragma mark Properties

@dynamic image;
@dynamic displayAsStack;


// ********************************************************************** //
//  DYNAMIC PROPERTY METHODS

#pragma mark Dynamic Property Methods

- (UIImage *)image
{
  return (m_image);
}

- (void)setImage:(UIImage *)image
{
  // Release previous image, assign and retain new image
  [m_image release];
  m_image = [image retain];
 
  // If an image is provided, perform some pre-calculations to assist
  // drawing that remain constant for a given image
  if (nil != m_image)
  {
    // Calculate the image aspect ratio, used to determine aspect of
    // image (landscape, square, portrait) which determines the larger
    // dimension required for calculating required scaling
    m_imageAspect = m_image.size.width / m_image.size.height;

    // When display mode is Stack, rotation of snapshot/image rectangles
    // changes dimensions of bounding rectangle, perform calculations to
    // discover largest bounding rectangle requiring most scaling
    if (YES == m_displayStack)
    {
      [self calculateScalingToFitStack];
    }
  }
  
  // Image has change, redraw the view
  [self setNeedsDisplay];
}


// ********************************************************************** //

- (BOOL)displayAsStack
{
  return (m_displayStack);
}

- (void)setDisplayAsStack:(BOOL)displayAsStack
{
  // Take action only if the requested display mode is differs from current
  if (displayAsStack != m_displayStack)
  {
    m_displayStack = displayAsStack;
    
    // Rotation of snapshot/image rectangles changes dimensions of bounding
    // rectangle, perform calculations to discover largest bounding rectangle
    // requiring most scaling
    if ((YES == m_displayStack) && (nil != m_image))
    {
      [self calculateScalingToFitStack];
    }
    
    // Display mode has changed, redraw the view
    [self setNeedsDisplay];
  }
} 


// ********************************************************************** //
//  INSTANCE METHODS

#pragma mark Instance Methods

- (id)initWithFrame:(CGRect)frame 
{
  if (nil != (self = [super initWithFrame:frame])) 
  {
    [self commonInitialisation];
  }
  
  return (self);
}


// ********************************************************************** //

- (void)awakeFromNib
{
  [self commonInitialisation];
}


// ********************************************************************** //

// METHOD: commonInitialisation
/*!
    Perform initialisation activities common to all forms of instantiation;
    programatically via initWithFrame: or from XIB instantiation via 
    awakeFromNib: method.
*/
- (void)commonInitialisation
{
  // Initialise the positions of all snapshots in a stack
  // Offsetting centre of snapshots about the view frame centre is 
  // reserved for future functionality and currently the rotations are
  // static, may be optionally randomised in future updates.
  /*
  for (NSInteger idx = 0; idx < SWSnapshotStackViewSnapshotsPerStack; idx++)
  {
    m_snapshotPositions[idx].centre = CGPointMake (x,y);
  }
   */
  m_snapshotPositions[0].angleRotation = 2.5;   // 2.0  // 3.0
  m_snapshotPositions[1].angleRotation = -3.0;   // 4.0  // -5.0
  // Top most shot must always have zero rotation
  m_snapshotPositions[2].angleRotation = 0.0;  
  
  // View's background is transparent underneath the rendered snapshot(s)
  self.backgroundColor = [UIColor clearColor];
  
  // Check system (iOS) version, invert sign of shadow direction when
  // running on iOS <3.2
  m_shadowDirSign = 1.0;
  if (NSOrderedAscending == [[[UIDevice currentDevice] systemVersion] compare:@"3.2" options:NSNumericSearch])
  {
    m_shadowDirSign = -1.0;
  }
}


// ********************************************************************** //

- (void)dealloc 
{
  [m_image release], m_image = nil;
  
  [super dealloc];
}


// ********************************************************************** //

- (void)drawRect:(CGRect)rect 
{
  // Do nothing if no image is available to display
  if (nil == m_image)
  {
    return;
  }
  
  CGContextRef context = UIGraphicsGetCurrentContext ();
  
  CGPoint viewCenter = 
    CGPointMake (CGRectGetMidX (self.bounds), CGRectGetMidY (self.bounds));

  // Initialise to shut static analyser up, gets confused by stacked display
  // mode processing 'for' loop and conditional 'if (0 == angle of rotation)'
  // where this is initialised for stacked display mode (last snapshot ALWAYS
  // zero rotation)
  CGRect matteFrameRect = rect;    

  // Set fill & stroke colour and stroke line width for rendering of the
  // matte frame around snapshots
  UIColor *colour = [UIColor whiteColor];
  [colour setFill];
  colour = [UIColor grayColor];
  [colour setStroke];  
  CGContextSetLineWidth (context, 1.0);

  CGFloat MatteWidthTotal = 2.0 * SWSnapshotStackViewMatteWidth;  
 
  if (NO == m_displayStack)
  {
    // SINGLE SNAPSHOT DISPLAY MODE
  
    CGSize scaledImageSize;

    // Calculate required scaling of image to fit within the views frame
    // using the images aspect ratio to determine the largest dimension
    // to drive scaling factor, leaving room for matte frame and shadow
    if (m_imageAspect > 1.0)
    {
      CGFloat targetWidth = self.frame.size.width - MatteWidthTotal;
      scaledImageSize = CGSizeMake (targetWidth, targetWidth / m_imageAspect);
    }
    else
    {
      CGFloat targetHeight = self.frame.size.height - MatteWidthTotal - SWSnapshotStackViewSingleShadowTotalHeight;
      scaledImageSize = CGSizeMake (targetHeight * m_imageAspect, targetHeight);
    }
    
    // Create the matte frame rectangle
    matteFrameRect = CGRectMake (floorf (viewCenter.x - ((scaledImageSize.width / 2.0) + SWSnapshotStackViewMatteWidth)) + 0.5,
                                 floorf (viewCenter.y - ((scaledImageSize.height / 2.0) + SWSnapshotStackViewMatteWidth + (SWSnapshotStackViewSingleShadowTotalHeight / 2.0))) + 0.5,
                                 floorf (scaledImageSize.width + MatteWidthTotal) - 1.0,
                                 floorf (scaledImageSize.height + MatteWidthTotal) - 1.0);
    
    CGContextSaveGState (context);

    // Render the curved drop shadow, path is defined from top left hand
    // corner in a clockwise direction
    CGMutablePathRef shadowPath = CGPathCreateMutable ();
    CGPathMoveToPoint (shadowPath, NULL, 
                       matteFrameRect.origin.x + SWSnapshotStackViewSingleShadowXOffset,
                       matteFrameRect.origin.y + matteFrameRect.size.height - SWSnapshotStackViewSingleShadowTotalHeight);
    CGPathAddLineToPoint (shadowPath, NULL, 
                          matteFrameRect.origin.x + matteFrameRect.size.width - SWSnapshotStackViewSingleShadowXOffset, 
                          matteFrameRect.origin.y + matteFrameRect.size.height - SWSnapshotStackViewSingleShadowTotalHeight);
    CGPathAddLineToPoint (shadowPath, NULL, 
                          matteFrameRect.origin.x + matteFrameRect.size.width - SWSnapshotStackViewSingleShadowXOffset, 
                          matteFrameRect.origin.y + matteFrameRect.size.height);
    CGPathAddQuadCurveToPoint (shadowPath, NULL, 
                               (matteFrameRect.origin.x + matteFrameRect.size.width) / 2.0, 
                               matteFrameRect.origin.y + matteFrameRect.size.height - SWSnapshotStackViewSingleShadowTotalHeight, 
                               matteFrameRect.origin.x + SWSnapshotStackViewSingleShadowXOffset, 
                               matteFrameRect.origin.y + matteFrameRect.size.height);
    CGPathCloseSubpath (shadowPath);
    
    // Draw the shadow using it's calculated path
    colour = [UIColor colorWithRed:0 green:0 blue:0.0 alpha:0.6];
    CGContextSetShadowWithColor (context, CGSizeMake (0, (SWSnapshotStackViewSingleShadowYOffset * m_shadowDirSign)), 
                                 SWSnapshotStackViewSingleShadowRadius, colour.CGColor);
    CGContextAddPath (context, shadowPath);
    CGContextFillPath (context);      
    CGPathRelease (shadowPath);
      
    CGContextRestoreGState (context);
      
    // Draw the matte frame
    CGPathRef matteFramePath = CGPathCreateWithRect (matteFrameRect, NULL); 
    CGContextAddPath (context, matteFramePath);
    CGContextDrawPath (context, kCGPathFillStroke);
    CGPathRelease (matteFramePath); 
  }
  else
  {
    // STACK DISPLAY MODE 
  
    // Using the snapshot within the stack of rotated snapshots which
    // has the largest bounding rectangle (calculated via 
    // calculateScalingToFitStack:) determine the required scaling to
    // fit the snapshot within the views frame, leaving room for shadows
    CGFloat requiredScaling;
    if (YES == m_scaledUsingWidth)
    {
      requiredScaling = (self.frame.size.width - 1 - SWSnapshotStackViewStackShadowTotalHeight) / 
        m_snapshotPositions[m_minScaleShotIdx].boundingRectSize.width;
    }
    else
    {
      requiredScaling = (self.frame.size.height - 1 - SWSnapshotStackViewStackShadowTotalHeight) / 
        m_snapshotPositions[m_minScaleShotIdx].boundingRectSize.height;
    }

    CGSize matteSize = CGSizeMake (m_image.size.width * requiredScaling,
                                   m_image.size.height * requiredScaling);
    
    // Draw each snapshot in the stack
    for (NSInteger shotIdx = 0; shotIdx < SWSnapshotStackViewSnapshotsPerStack; shotIdx++)   
    {
      CGContextSaveGState (context);
      
      CGMutablePathRef matteFramePath = CGPathCreateMutable ();
      
      CGFloat angleRotation = (m_snapshotPositions[shotIdx].angleRotation) * (M_PI / 180.0);
      
      // snapshots containing no rotation don't require the complex
      // drawing of rotated rectangles
      if (0.0 == angleRotation)
      {
        matteFrameRect = 
          CGRectMake (floorf (viewCenter.x - (matteSize.width / 2.0)) + 0.5,
                      floorf (viewCenter.y - (matteSize.height / 2.0)) + 0.5,
                      floorf (matteSize.width), floorf (matteSize.height));
        CGPathAddRect (matteFramePath, NULL, matteFrameRect);
      }
      else
      {
        // Points define rectangle from top-left corner in clockwise direction
        CGPoint P1;
        CGPoint P2;
        CGPoint P3;
        CGPoint P4;
        
        // Scale the bounding rectangle that contains the rotated snapshot
        // rectangle by the calculated required scaling factor
        CGSize scaledBoudingRectSize = CGSizeMake ((m_snapshotPositions[shotIdx].boundingRectSize.width * requiredScaling),
                                                   (m_snapshotPositions[shotIdx].boundingRectSize.height * requiredScaling));
        
        CGFloat halfScaledBoundingRectWidth = (scaledBoudingRectSize.width / 2.0);
        CGFloat halfScaledBoundingRectHeight = (scaledBoudingRectSize.height / 2.0);
        CGFloat adjacentOnXAxis = scaledBoudingRectSize.height * sin (angleRotation);    
        CGFloat adjacentOnYAxis = scaledBoudingRectSize.width * sin (angleRotation);
        
        // Calculate position of rotated rectangle points P1 to P4,
        // using trigonometry and the triangles made by the points against
        // the sides of the bounding rectangle
        if (angleRotation < 0.0)
        {
          // Counter-clockwise rotation

          P1 = CGPointMake (viewCenter.x - halfScaledBoundingRectWidth, 
                            viewCenter.y - halfScaledBoundingRectHeight - adjacentOnYAxis);
          P2 = CGPointMake (viewCenter.x + halfScaledBoundingRectWidth + adjacentOnXAxis,
                            viewCenter.y - halfScaledBoundingRectHeight);
          P3 = CGPointMake (viewCenter.x + halfScaledBoundingRectWidth, 
                            viewCenter.y + halfScaledBoundingRectHeight + adjacentOnYAxis);         
          P4 = CGPointMake (viewCenter.x - halfScaledBoundingRectWidth - adjacentOnXAxis, 
                            viewCenter.y + halfScaledBoundingRectHeight);
        }
        else
        {
          // Clockwise rotation
          
          P1 = CGPointMake (viewCenter.x - halfScaledBoundingRectWidth + adjacentOnXAxis,
                            viewCenter.y - halfScaledBoundingRectHeight);
          P2 = CGPointMake (viewCenter.x + halfScaledBoundingRectWidth,
                            viewCenter.y - halfScaledBoundingRectHeight + adjacentOnYAxis);
          P3 = CGPointMake (viewCenter.x + halfScaledBoundingRectWidth - adjacentOnXAxis, 
                            viewCenter.y + halfScaledBoundingRectHeight);
          P4 = CGPointMake (viewCenter.x - halfScaledBoundingRectWidth,
                            viewCenter.y + halfScaledBoundingRectHeight - adjacentOnYAxis);
        }
        
        // Create path to define the matte frame of the rotated snapshot
        CGPathMoveToPoint (matteFramePath, NULL, P1.x, P1.y);
        CGPathAddLineToPoint (matteFramePath, NULL, P2.x, P2.y);
        CGPathAddLineToPoint (matteFramePath, NULL, P3.x, P3.y);
        CGPathAddLineToPoint (matteFramePath, NULL, P4.x, P4.y);
        CGPathCloseSubpath (matteFramePath);
      }

      CGContextSaveGState (context);
      
      // Draw the snapshot shadow using the matte frames path, offset
      // slightly. Still not 100% happy with the shadow drawing, plan
      // to tweak eventually to get better end effect
      colour = [UIColor colorWithRed:0 green:0 blue:0.0 alpha:0.4];
      CGContextSetShadowWithColor (context, CGSizeMake (0.0, (SWSnapshotStackViewStackShadowYOffset * m_shadowDirSign)),
                                   SWSnapshotStackViewStackShadowRadius, colour.CGColor);
      CGContextAddPath (context, matteFramePath); 
      CGContextFillPath (context);
      
      CGContextRestoreGState (context);

      // Draw the matte frame
      CGContextAddPath (context, matteFramePath);   
      CGContextDrawPath (context, kCGPathFillStroke);
      CGPathRelease (matteFramePath);
      
      CGContextRestoreGState (context);
    }
    
  }

  // Calculate frame for the actual image within the top snapshot, centered
  // within the already drawn matte frame. Unlike the stroked matte
  // frame outline the image must reside on integer point values,
  // to avoid aliasing across points/pixels. 
  // Hence conversion of the matte frame rectangle (calculated to perform
  // innser stroke at 0.5 offset) requires subtraction of the offsets and
  // increasing size in both dimension by 1 point to compensate.
  CGRect imageFrame = matteFrameRect;
  imageFrame.origin.x += SWSnapshotStackViewMatteWidth - 0.5;
  imageFrame.origin.y += SWSnapshotStackViewMatteWidth - 0.5;
  imageFrame.size.width -= MatteWidthTotal - 1;
  imageFrame.size.height -= MatteWidthTotal - 1;

  // Draw the image without manipulation other than correct scaling,
  // could have used CGContextDrawImage() if further drawing required
  [m_image drawInRect:imageFrame];
}


// ********************************************************************** //

// METHOD: calculateScalingToFitStack
/*!
    Calculates the snapshot within the stack which requires the most
    scaling, due to the rotation of the rectangle the points protrude
    outside of their original dimensions. Hence a bounding rectangle
    must be calculated that contains entirely the rotated rectangle.
    The dimensions of the bounding rectangle can then be used to calculate
    the required scaling to fit the bounding rectangle within the views
    frame.
    
    As the size of the views frame may change at anytime, the outcome
    of this method is to store the snapshot in the stack which requires
    the most scaling (minimum scaling factor) via it's index 
    (m_minScaleShotIdx) into the snapshot position array 
    (m_snapshotPositions) and the dimension (width or height) that    
    should be used to calculate scaling (m_scaledUsingWidth).
    
    The output of this method remains constant as long as the image
    remains constant, re-calculation is required when the image
    is changed.  Hence avoiding the need to perform these calculations
    each time the view is drawn.
*/
- (void)calculateScalingToFitStack
{
  CGFloat requiredScaling = 1.0;
  
  for (NSInteger idx = 0; idx < SWSnapshotStackViewSnapshotsPerStack; idx++)
  {
    // Calculate bounding rectangle of rotated snapshot/image rectangle
    // Direction of rotation is not important given symmetry, only aiming
    // to calculate size, not location after rotation
    CGSize imageSize = m_image.size;
    CGFloat angleRotation = 
      (fabs(m_snapshotPositions[idx].angleRotation) * (M_PI / 180.0));
    CGSize boundingRect = CGSizeMake ((imageSize.width * cos (angleRotation)) +
                                      (imageSize.height * sin (angleRotation)),
                                      (imageSize.width * sin (angleRotation)) +
                                      (imageSize.height * cos (angleRotation)));
    m_snapshotPositions[idx].boundingRectSize = boundingRect;
    
    // Calculated required scaling for each dimension to fit the bounding
    // rectangle within the views frame
    CGFloat requiredWidthScaling = self.frame.size.width / boundingRect.width;
    CGFloat requiredHeightScaling = self.frame.size.height / boundingRect.height;
    
    // Determine if the scaling required for either dimension is the
    // largest (smallest scaling factor) required for any of the snapshots
    // processed thus far
    if (requiredWidthScaling < requiredScaling)
    {
      requiredScaling = requiredWidthScaling;
      m_minScaleShotIdx = idx;
      m_scaledUsingWidth = YES;
    }
    if (requiredHeightScaling < requiredScaling)
    {
      requiredScaling = requiredHeightScaling;
      m_minScaleShotIdx = idx;   
      m_scaledUsingWidth = NO;
    }
  }
}


// ********************************************************************** //

@end  // @SWSnapshotStackView

// ********************************************************************** //

// End of File
