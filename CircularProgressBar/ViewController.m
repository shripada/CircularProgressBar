//
//  ViewController.m
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft Technologies, Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CircularProgressBar.h"
#import "MathUtilities.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet CircularProgressBar* progressBar;
@property (weak, nonatomic) IBOutlet UISlider *startPointSlider;

@end

@implementation ViewController
{
    CGFloat currentProgressValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentProgressValue = 0.0;
     _progressBar.thickness = 0.1;
    _progressBar.startAngle = M_PI;
    _startPointSlider.transform = CGAffineTransformMakeRotation(-M_PI_2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doProgress:(id)sender
{
    if(currentProgressValue > 1.0)
    {
        currentProgressValue = 0.0;
        [_progressBar setProgress:currentProgressValue animated:NO];
    }
     
    currentProgressValue += 0.04;
    
    if(currentProgressValue < 0.2)
    {
        _progressBar.progressTintColor = [UIColor redColor];
    }
    else if(currentProgressValue > 0.2 && currentProgressValue < 0.6)
    {
        _progressBar.progressTintColor = [UIColor yellowColor];
    }
    else if(currentProgressValue > 0.6)
    {
        _progressBar.progressTintColor = [UIColor greenColor];
    }
    
    [_progressBar setProgress:currentProgressValue animated:YES];
}

-(IBAction)doChangingExtent:(id)sender
{
    UISlider* slider = (UISlider*)sender;
    
    CGFloat progress = slider.value;
    [_progressBar setThickness:progress];
}
- (IBAction)doChangeStartingPoint:(UISlider*)sender
{
    _progressBar.startAngle = UnitValueToRadians(sender.value);

}
@end
