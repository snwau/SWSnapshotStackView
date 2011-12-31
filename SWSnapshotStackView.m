////////////////////////////////////////////////////////////////////////////
/*!
 ** \file SWSnapshotStackView.m
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
 ** \see SWSnapshotStackView.h
 */
// Documentation of the code is formatted for use with the documentation
// package Doxygen (see http://www.doxygen.org/).
//
// Project     : iOS Common Components
// Component   : GUI/Views
// Platform    : iOS 3.0+
//
////////////////////////////////////////////////////////////////////////////

#import "SWSnapshotStackView.h"


// ********************************************************************** //
// SNAPSHOT STACK VIEW CLASS (PRIVATE METHODS)
// ********************************************************************** //

#pragma mark Snapshot Stack View class (Private Methods)

@interface SWSnapshotStackView (Private)

- (void)commonInitialisation;
- (void)calculateRequiredStackScaling;

@end


// ********************************************************************** //
// SNAPSHOT STACK VIEW CLASS
// ********************************************************************** //

#pragma mark - Snapshot Stack View class

@implementation SWSnapshotStackView

// ********************************************************************** //
//  CONSTANTS

#pragma mark Constants

#define SWSnapshotStackViewMatteWidth        7.0


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
  [m_image release];
  m_image = [image retain];
  
  [m_imageView removeFromSuperview];
  [m_imageView release], m_imageView = nil;
 
  if (nil != m_image)
  {
    NSLog (@"SWSnapshotStackView:setImage - image.size={W:%.0f,H:%.0f}",
           m_image.size.width, m_image.size.height);
    m_imageAspect = m_image.size.width / m_image.size.height;

    if (YES == m_displayStack)
    {
      [self calculateRequiredStackScaling];
    }
  }
  
  [self setNeedsDisplay];
}


// ********************************************************************** //

- (BOOL)displayAsStack
{
  return (m_displayStack);
}

- (void)setDisplayAsStack:(BOOL)displayAsStack
{
  if (displayAsStack != m_displayStack)
  {
    m_displayStack = displayAsStack;
    
    [self calculateRequiredStackScaling];
    
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

- (void)commonInitialisation
{
  // Initialise the angle of rotation for each shot in the stack
  for (NSInteger idx = 0; idx < SWSnapshotStackViewSnapshotsPerStack; idx++)
  {
    m_snapshotPositions[idx].centre = CGPointMake(self.center.x, self.center.y);
  }
  m_snapshotPositions[0].angleRotation = 2.0;
  m_snapshotPositions[1].angleRotation = 4.0;
  m_snapshotPositions[2].angleRotation = 0.0;  
  
  //self.autoresizesSubviews = YES;  
}


// ********************************************************************** //

- (void)dealloc 
{
  [m_image release], m_image = nil;
  [m_imageView release], m_imageView = nil;
  
  [super dealloc];
}


// ********************************************************************** //

- (void)drawRect:(CGRect)rect 
{
  NSLog (@"SWSnapshotStackView:drawRect - rect={{X:%.0f,Y:%.0f},{W:%.0f,H:%.0f}}",
         rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
 
  if (nil != m_imageView)
  {
    [m_imageView removeFromSuperview];
    [m_imageView release], m_imageView = nil;
  }  
  
  if (nil == m_image)
  {
    return;
  }
  
  CGContextRef context = UIGraphicsGetCurrentContext ();
  
  if (NO == m_displayStack)
  {
    CGSize scaledImageSize;
    CGRect matteFrame;
    
    if (m_imageAspect > 1.0)
    {
      NSLog (@"SWSnapshotStackView:drawRect - Scale by Width");
      
      scaledImageSize = CGSizeMake (rect.size.width - (2 * SWSnapshotStackViewMatteWidth),
                                    (rect.size.width - (2 * SWSnapshotStackViewMatteWidth)) / m_imageAspect);
      
      matteFrame = CGRectMake (0.0, floorf ((rect.size.height - ((scaledImageSize.height) + 
                                                                 (2 * SWSnapshotStackViewMatteWidth))) / 2.0) + 0.5,
                               floorf (rect.size.width) - 0.5, 
                               floorf (scaledImageSize.height + (2 * SWSnapshotStackViewMatteWidth)));       
    }
    else
    {
      NSLog (@"SWSnapshotStackView:drawRect - Scale by Height");
      
      scaledImageSize = CGSizeMake ((rect.size.height - (2 * SWSnapshotStackViewMatteWidth) - 15.0) * m_imageAspect,
                                    (rect.size.height - (2 * SWSnapshotStackViewMatteWidth) - 15.0));
      
      matteFrame = CGRectMake (floorf ((rect.size.width - ((scaledImageSize.width) + (2 * SWSnapshotStackViewMatteWidth))) / 2.0) + 0.5,
                                        0.0, floorf (scaledImageSize.width + (2 * SWSnapshotStackViewMatteWidth)),
                                        floorf (scaledImageSize.height + (2 * SWSnapshotStackViewMatteWidth)) - 0.5);
    }
  
    
    NSLog (@"SWSnapshotStackView:drawRect - scaledImageSize={W:%.0f,H:%.0f}",
           scaledImageSize.width, scaledImageSize.height);
    
    NSLog (@"SWSnapshotStackView:drawRect - matteFrame={{X:%.1f,Y:%.1f},{W:%.1f,H:%.1f}}",
           matteFrame.origin.x, matteFrame.origin.y, matteFrame.size.width, matteFrame.size.height);     
    
    CGContextSaveGState (context);

    // SHADOW

    CGFloat xOffset = 5.0;
    CGFloat shadowHeight = 10.0;
      
    CGMutablePathRef shadowPath = CGPathCreateMutable ();
    CGPathMoveToPoint (shadowPath, NULL, matteFrame.origin.x + xOffset, matteFrame.origin.y + matteFrame.size.height - shadowHeight);
    CGPathAddLineToPoint (shadowPath, NULL, matteFrame.origin.x + matteFrame.size.width - xOffset, 
                          matteFrame.origin.y + matteFrame.size.height - shadowHeight);
    CGPathAddLineToPoint (shadowPath, NULL, matteFrame.origin.x + matteFrame.size.width - xOffset, 
                          matteFrame.origin.y + matteFrame.size.height);
    CGPathAddQuadCurveToPoint (shadowPath, NULL, (matteFrame.origin.x + matteFrame.size.width) / 2.0, 
                               matteFrame.origin.y + matteFrame.size.height - shadowHeight, 
                               matteFrame.origin.x + xOffset, matteFrame.origin.y + matteFrame.size.height);
    CGPathCloseSubpath (shadowPath);
      
    CGColorRef shadowColor = [UIColor colorWithRed:0 green:0 blue:0.0 alpha:0.6].CGColor;
    CGContextSetShadowWithColor (context, CGSizeMake(0, 5.0), 5.0, shadowColor);
    CGContextAddPath (context, shadowPath);      

    UIColor *dummyFill = [UIColor whiteColor];
    //UIColor *dummyFill = [UIColor blackColor];
    [dummyFill setFill];
    CGContextFillPath (context);
      
    CGPathRelease (shadowPath);
      
    CGContextRestoreGState (context);
      
    // MATTE FRAME

    CGPathRef matteFramePath = CGPathCreateWithRect (matteFrame, NULL);
     
    //TODO: can fill and stroke in one operation?
  
    UIColor *color = [UIColor whiteColor];
    [color setFill];
    CGContextAddPath (context, matteFramePath);
    CGContextFillPath (context);
      
    UIColor *outline = [UIColor grayColor];
    [outline setStroke];
    CGContextStrokeRect (context, matteFrame);
      
    m_imageView = [[UIImageView alloc] initWithImage:m_image];
    CGRect imageFrame = matteFrame;
    imageFrame.origin.x += SWSnapshotStackViewMatteWidth;
    imageFrame.origin.y += SWSnapshotStackViewMatteWidth;
    imageFrame.size.width -= (2 * SWSnapshotStackViewMatteWidth);
    imageFrame.size.height -= (2 * SWSnapshotStackViewMatteWidth);
    m_imageView.frame = imageFrame;
      
    //m_imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      
//    m_imageView.autoresizingMask = 
//      UIViewAutoresizingFlexibleLeftMargin |
//      UIViewAutoresizingFlexibleWidth |
//      UIViewAutoresizingFlexibleRightMargin |
//      UIViewAutoresizingFlexibleTopMargin |
//      UIViewAutoresizingFlexibleHeight |
//      UIViewAutoresizingFlexibleBottomMargin;

      
    [self addSubview:m_imageView];
      
    CGPathRelease (matteFramePath); 

  }
  else
  {
    //CGFloat xOffset = 5.0;
    CGFloat shadowRadius = 6.0;
    
    
    CGFloat requiredWidthScaling = (self.frame.size.width - 1 - (2 * shadowRadius)) / m_snapshotPositions[m_minScaleShotIdx].boundingRectSize.width;
    CGFloat requiredHeightScaling = (self.frame.size.height - 1 - (2 * shadowRadius)) / m_snapshotPositions[m_minScaleShotIdx].boundingRectSize.height;
    CGFloat requiredScaling = (requiredWidthScaling < requiredHeightScaling) ? requiredWidthScaling : requiredHeightScaling;

    //CGSize matteSize = CGSizeMake (m_image.size.width * m_requiredScaling, m_image.size.height * m_requiredScaling);
    CGSize matteSize = CGSizeMake (m_image.size.width * requiredScaling, m_image.size.height * requiredScaling);
    NSLog (@"Matte Size = {W:%.3f, H:%.3f}", matteSize.width, matteSize.height);
    
    CGPoint viewCenter = CGPointMake (CGRectGetMidX (self.frame) - CGRectGetMinX (self.frame), 
                                      CGRectGetMidY (self.frame) - CGRectGetMinY (self.frame));
    NSLog (@"View Center = {X:%.3f, Y:%.2f}", viewCenter.x, viewCenter.y);
    
    
    for (NSInteger shotIdx = 0; shotIdx < SWSnapshotStackViewSnapshotsPerStack; shotIdx++)
    //for (NSInteger shotIdx = 0; shotIdx < 1; shotIdx++)    
    {
      CGContextSaveGState (context);
      
      CGMutablePathRef matteFramePath = CGPathCreateMutable ();
      
      CGFloat angleRotation = (m_snapshotPositions[shotIdx].angleRotation) * (M_PI / 180.0);
      
      if (0.0 == angleRotation)
      {
        NSLog (@"0.0 Rotation");
        
        CGRect matteFrameRect = CGRectMake (floorf (viewCenter.x - (matteSize.width / 2.0)) + 0.5,
                                            floorf (viewCenter.y - (matteSize.height / 2.0)) + 0.5,
                                            floorf (matteSize.width), floorf (matteSize.height));
        NSLog (@"Matte Frame Rect = {{X:%.2f, Y:%.2f},{W:%.2f,H:%.3f}}",
               matteFrameRect.origin.x, matteFrameRect.origin.y, matteFrameRect.size.width, matteFrameRect.size.height);
        CGPathAddRect (matteFramePath, NULL, matteFrameRect);
      }
      else
      {
        // Points define rectangle from top-left corner in a clockwise direction
        CGPoint P1;
        CGPoint P2;
        CGPoint P3;
        CGPoint P4;
        
        //CGSize scaledBoudingRectSize = CGSizeMake ((m_snapshotPositions[shotIdx].boundingRectSize.width * m_requiredScaling),
        //                                           (m_snapshotPositions[shotIdx].boundingRectSize.height * m_requiredScaling));
        CGSize scaledBoudingRectSize = CGSizeMake ((m_snapshotPositions[shotIdx].boundingRectSize.width * requiredScaling),
                                                   (m_snapshotPositions[shotIdx].boundingRectSize.height * requiredScaling));
        
        NSLog (@"scaledBoundingRectSize = {W:%.0f,H:%.0f}", scaledBoudingRectSize.width, scaledBoudingRectSize.height);
        
        
        if (angleRotation < 0.0)
        //if (true)
        {
          // Counter-clockwise rotation
         
          NSLog (@"Counter-clockwise rotation");
          
          P1 = CGPointMake (viewCenter.x - (scaledBoudingRectSize.width / 2.0), viewCenter.y - (scaledBoudingRectSize.height / 2.0) + (scaledBoudingRectSize.width * sin (angleRotation)));
          NSLog (@"P1 = {X:%.3f,Y:%.3f}", P1.x, P1.y);
          P2 = CGPointMake (viewCenter.x + (scaledBoudingRectSize.width / 2.0) - (scaledBoudingRectSize.height * sin (angleRotation)), viewCenter.y - (scaledBoudingRectSize.height / 2.0));
          NSLog (@"P2 = {X:%.3f,Y:%.3f}", P2.x, P2.y);
          P3 = CGPointMake (viewCenter.x + (scaledBoudingRectSize.width / 2.0), viewCenter.y + (scaledBoudingRectSize.height / 2.0) - (scaledBoudingRectSize.width * sin (angleRotation)));
          NSLog (@"P3 = {X:%.3f,Y:%.3f}", P3.x, P3.y);          
          P4 = CGPointMake (viewCenter.x - (scaledBoudingRectSize.width / 2.0) + (scaledBoudingRectSize.height * sin (angleRotation)), viewCenter.y + (scaledBoudingRectSize.height / 2.0));
          NSLog (@"P4 = {X:%.3f,Y:%.3f}", P4.x, P4.y);
          
          
        }
        else
        {
          // Clockwise rotation
          
          NSLog (@"Clockwise Rotation");
          
          P1 = CGPointMake (viewCenter.x - (scaledBoudingRectSize.width / 2.0) + (scaledBoudingRectSize.width * sin (angleRotation)),
                            viewCenter.y - (scaledBoudingRectSize.height / 2.0));
          NSLog (@"P1 = {X:%.3f,Y:%.3f}", P1.x, P1.y);
          P2 = CGPointMake (viewCenter.x + (scaledBoudingRectSize.width / 2.0),
                            viewCenter.y - (scaledBoudingRectSize.height / 2.0) + (scaledBoudingRectSize.height * sin (angleRotation)));
          NSLog (@"P2 = {X:%.3f,Y:%.3f}", P2.x, P2.y);
          P3 = CGPointMake (viewCenter.x + (scaledBoudingRectSize.width / 2.0) - (scaledBoudingRectSize.width * sin (angleRotation)), 
                            viewCenter.y + (scaledBoudingRectSize.height / 2.0));
          NSLog (@"P3 = {X:%.3f,Y:%.3f}", P3.x, P3.y);          
          P4 = CGPointMake (viewCenter.x - (scaledBoudingRectSize.width / 2.0),
                            viewCenter.y + (scaledBoudingRectSize.height / 2.0) - (scaledBoudingRectSize.height * sin (angleRotation)));
          NSLog (@"P4 = {X:%.3f,Y:%.3f}", P4.x, P4.y);
        }

        P1.x = floorf (P1.x) + 0.5;
        P1.y = floorf (P1.y) + 0.5; 
        P2.x = floorf (P2.x) + 0.5;
        P2.y = floorf (P2.y) + 0.5; 
        P3.x = floorf (P3.x) + 0.5;
        P3.y = floorf (P3.y) + 0.5; 
        P4.x = floorf (P4.x) + 0.5;
        P4.y = floorf (P4.y) + 0.5;        

        
        // Create path to define the Matte Frame (defined clockwise from top-left corner)
        CGPathMoveToPoint (matteFramePath, NULL, P1.x, P1.y);
        CGPathAddLineToPoint (matteFramePath, NULL, P2.x, P2.y);
        CGPathAddLineToPoint (matteFramePath, NULL, P3.x, P3.y);
        CGPathAddLineToPoint (matteFramePath, NULL, P4.x, P4.y);
        CGPathCloseSubpath (matteFramePath);
      }

      CGContextSaveGState (context);
      
      CGColorRef shadowColor = [UIColor colorWithRed:0 green:0 blue:0.0 alpha:0.4].CGColor;
      CGContextSetShadowWithColor (context, CGSizeMake(0.0, 2.0), shadowRadius, shadowColor);
      UIColor *dummyFill = [UIColor whiteColor];
      [dummyFill setFill];
      CGContextAddPath (context, matteFramePath); 
      CGContextFillPath (context);
      
      //CGContextSetShadowWithColor (context, CGSizeMake(0, 0.0), 5.0, NULL);
      
      CGContextRestoreGState (context);


      UIColor *fillColor = [UIColor whiteColor];
      [fillColor setFill];
      UIColor *strokeColor = [UIColor grayColor];
      [strokeColor setStroke]; 
      
      CGContextAddPath (context, matteFramePath);   
      CGContextDrawPath (context, kCGPathFillStroke);
      //CGContextStrokePath (context);
       
      
      CGPathRelease (matteFramePath);
      
      CGContextRestoreGState (context);
    }
    
    m_imageView = [[UIImageView alloc] initWithImage:m_image];
    CGRect imageFrame = CGRectMake (viewCenter.x - (matteSize.width / 2.0) + SWSnapshotStackViewMatteWidth,
                                    viewCenter.y - (matteSize.height / 2.0) + SWSnapshotStackViewMatteWidth,
                                    matteSize.width - (2 * SWSnapshotStackViewMatteWidth),
                                    matteSize.height - (2 * SWSnapshotStackViewMatteWidth));
    m_imageView.frame = imageFrame;

    [self addSubview:m_imageView];
    
  }
  
}


// ********************************************************************** //

- (void)calculateRequiredStackScaling
{
  m_requiredScaling = 1.0;
  for (NSInteger idx = 0; idx < SWSnapshotStackViewSnapshotsPerStack; idx++)
  {
    CGSize imageSize = m_image.size;
    CGFloat angleRotation = ((m_snapshotPositions[idx].angleRotation) * (M_PI / 180.0));
    CGSize boundingRect = CGSizeMake ((imageSize.width * cos (angleRotation)) + (imageSize.height * sin (angleRotation)),
                                      (imageSize.width * sin (angleRotation)) + (imageSize.height * cos (angleRotation)));
    m_snapshotPositions[idx].boundingRectSize = boundingRect;
    NSLog (@"Bounding Rect [%d] = {W:%.3f,H:%.3f}",
           idx, boundingRect.width, boundingRect.height);
    
    CGFloat requiredWidthScaling = (self.frame.size.width - 1) / boundingRect.width;
    CGFloat requiredHeightScaling = (self.frame.size.height - 1) / boundingRect.height;
    
    if (requiredWidthScaling < m_requiredScaling)
    {
      m_requiredScaling = requiredWidthScaling;
      m_minScaleShotIdx = idx;
    }
    if (requiredHeightScaling < m_requiredScaling)
    {
      m_requiredScaling = requiredHeightScaling;
      m_minScaleShotIdx = idx;      
    }
  }
  
  NSLog (@"Required Scaling: %.3f", m_requiredScaling);  
}


// ********************************************************************** //

@end  // @SWSnapshotStackView

// ********************************************************************** //

// End of File
