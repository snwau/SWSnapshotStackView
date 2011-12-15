//
//  ViewController.h
//  SWSnapshotStackViewDemo
//
//  Created by Scott White on 14/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SWSnapshotStackView.h"

@interface RootViewController : UIViewController
{
  UISwitch *m_displayStackSwitch;
  UISegmentedControl *m_imageSelection;
  UISlider *m_sizeSlider;
  SWSnapshotStackView *m_snapshotStackView;  
}



@property (nonatomic, retain) IBOutlet UISwitch *displayStackSwitch;
@property (nonatomic, retain) IBOutlet UISegmentedControl *imageSelection;
@property (nonatomic, retain) IBOutlet UISlider *sizeSlider;
@property (nonatomic, retain) IBOutlet SWSnapshotStackView *snapshotStackView;


#pragma mark Action Methods

- (IBAction)displayStackSwitchValueChanged:(id)sender;
- (IBAction)imageSelectionValueChanged:(id)sender;
- (IBAction)sizeSliderValueChanged:(id)sender;


@end
