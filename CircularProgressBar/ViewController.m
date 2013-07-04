//
//  ViewController.m
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft. All rights reserved.
//

#import "ViewController.h"
#import "CircularProgressBar.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet CircularProgressBar* progressBar;

@end

@implementation ViewController
{
    CGFloat currentProgressValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentProgressValue = 0.0;
    
    _progressBar.extent = 0.5;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doProgress:(id)sender
{
    if(currentProgressValue >= 1.0)
        currentProgressValue = 0.0;
    
    currentProgressValue += 0.01;
    
    [_progressBar setProgress:currentProgressValue animated:YES];
}
@end
