//
//  CircularProgressBar.h
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

//Th
@interface CircularProgressBar : UIView

@property(nonatomic) float progress;                        // 0.0 .. 1.0, default is 0.0. values outside are pinned. this will cause animation.

@property(nonatomic, strong) UIColor* progressTintColor ; //Color of the portion where progress is completed
@property(nonatomic, strong) UIColor* trackTintColor ; //Color for the remaining portion where progress is yet to be filled.

@property(nonatomic) float extent;  //0.0 to 1,0. Default is 0.1, meaning if radius is say 100 points, then thickness of the progress arc is 10 points. If you set it as 1.0, then the whole circle will be filled


//Call this to set the progress to a given value between 0.0 to 1.0, with or without animation.
- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
