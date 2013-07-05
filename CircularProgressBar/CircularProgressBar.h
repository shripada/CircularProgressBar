//
//  CircularProgressBar.h
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft Technologies, Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

//This view can be used in a nib or created dynamically within the code.
//Use this to display a progress just like a pie slice growing to take up full circle.
//Additionally this allows you to mask out cicular area whose center coincides with progress view's.
//The API of this class closely mimicks that of UIProgressView.

@interface CircularProgressBar : UIView

// 0.0 .. 1.0, default is 0.0. values outside are pinned. this will cause animation.
@property(nonatomic) float progress;

@property(nonatomic, strong) UIColor* progressTintColor ;
//Color of the portion where progress is completed

//Color for the remaining portion where progress is yet to be filled.
@property(nonatomic, strong) UIColor* trackTintColor ;

//0.0 to 1,0. Default is 0.1, meaning if radius is say 100 points, then thickness of the
//progress arc is 10 points. If you set it as 1.0, then the arc will be filled to cover
//full radius, that is from center to circumference. Values outside are pinned.
@property(nonatomic) float thickness;

//Set the angle in radians from where the progress should start. Eg, specifying 0 will start from east,
// M_PI_2, will start from south, M_PI will from west, and 2/3*M_PI from north. By default, this will be
// 2/3 *M_PI
@property(nonatomic) float startAngle;

//Call this to set the progress to a given value between 0.0 to 1.0,
//with or without animation.
- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
