//
//  AnimatingArcLayer.h
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft Technologies, Pvt. Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

//This is a reusable layer, which basically abstracts an arc
//whose radius is derived from the bounds (radius = min(width, height)/2)
//you set to this layer. This custom layer demonstrates custom animatable properties
//and also custom drawing for a layer.

@interface AnimatingArcLayer : CALayer

//Angles should be in radians.
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;

@property (nonatomic, strong) UIColor* fillColor;
@property (nonatomic, strong) UIColor* strokeColor;

@property (nonatomic, assign) BOOL  animationsEnabled;

@end
