//
//  ViewController.m
//  SWSnapshotStackViewDemo
//
//  Created by Scott White on 14/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController


@synthesize displayStackSwitch = m_displayStackSwitch;
@synthesize imageSelection = m_imageSelection;
@synthesize sizeSlider = m_sizeSlider;
@synthesize snapshotStackView = m_snapshotStackView;


- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
	// Do any additional setup after loading the view, typically from a nib.

  //TODO: Set in Interface Builder?
  m_sizeSlider.minimumValue = 20.0;
  m_sizeSlider.maximumValue = 280.0;
  m_sizeSlider.value = 280.0;  
  
  m_displayStackSwitch.on = NO;
  
  m_snapshotStackView.contentMode = UIViewContentModeRedraw;
  m_snapshotStackView.displayAsStack = m_displayStackSwitch.on;
  m_snapshotStackView.image = [UIImage imageNamed:@"350D_IMG_3157_20071030w.jpg"];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
 
  // Release any retained subviews of the main view.
  self.displayStackSwitch = nil;
  self.imageSelection = nil;
  self.sizeSlider = nil;
  self.snapshotStackView = nil;
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


// ********************************************************************** //
// ACTION METHODS

#pragma mark Action Methods

- (IBAction)displayStackSwitchValueChanged:(id)sender
{
  m_snapshotStackView.displayAsStack = m_displayStackSwitch.on;
}


// ********************************************************************** //

- (IBAction)imageSelectionValueChanged:(id)sender
{
  switch (m_imageSelection.selectedSegmentIndex)
  {
    case 0:      
      m_snapshotStackView.image = [UIImage imageNamed:@"350D_IMG_3157_20071030w.jpg"];
      break;

    case 1:
      m_snapshotStackView.image = [UIImage imageNamed:@"IMG_5737_081229w7sq.jpg"];
      break;
     
    case 2:
      m_snapshotStackView.image = [UIImage imageNamed:@"IMG_2777_080216w6s.jpg"];
      break;
      
    default:
      m_snapshotStackView.image = nil;
  }
}


// ********************************************************************** //

- (IBAction)sizeSliderValueChanged:(id)sender
{
  CGFloat sizeDelta = m_sizeSlider.maximumValue - m_sizeSlider.value;
  CGRect newFrame = CGRectMake (20 + (sizeDelta / 2.0), 20 + (sizeDelta / 2.0), 
                             m_sizeSlider.value, m_sizeSlider.value);
  m_snapshotStackView.frame = newFrame; 
}


// ********************************************************************** //

@end  // @RootViewController

// End of file