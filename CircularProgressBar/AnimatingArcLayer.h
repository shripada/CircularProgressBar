//
//  AnimatingArcLayer.h
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface AnimatingArcLayer : CALayer

//Angles should be in radians.
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

@property (nonatomic, strong) UIColor* fillColor;
@property (nonatomic, strong) UIColor* strokeColor;

@property (nonatomic, assign) BOOL  animationsEnabled;

@end
