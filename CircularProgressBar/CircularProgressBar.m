//
//  CircularProgressBar.m
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft. All rights reserved.
//

#import "CircularProgressBar.h"
#import "AnimatingArcLayer.h"
#import "MathUtilities.h"



@implementation CircularProgressBar
{
    AnimatingArcLayer *arcLayer;
    AnimatingArcLayer *toBeFilledLayer;
    AnimatingArcLayer *maskProgressLayer;
    CAShapeLayer *maskLayer;
    CALayer* containerLayer;
}


-(void)setUp
{
    
    _thickness = 0.8;
    _startAngle = 2 *M_PI/3.0;
    
    //Layer hierarchy - First container>trackingLayer><progress layer>mask layer>
    //Animating the mask layer will reveal a crisp progress in progress layer.
    containerLayer= [CALayer layer];
	[self.layer addSublayer:containerLayer];
    containerLayer.frame = self.bounds;
    
    //Create and add the to be used represent the tracking layer
    toBeFilledLayer = [[AnimatingArcLayer alloc]init];
    //Create the arc layer and add it on top of the view.
    CGRect frameForLayer = self.bounds;
    
    toBeFilledLayer.frame = frameForLayer;
    toBeFilledLayer.animationsEnabled = NO;
    toBeFilledLayer.fillColor = [UIColor grayColor];
    arcLayer.strokeColor = [UIColor grayColor];
     
    toBeFilledLayer.startAngle = DegreesToRadians(0.0);
    toBeFilledLayer.endAngle = DegreesToRadians(360.0);
    toBeFilledLayer.name = @"trackingLayer";
    [containerLayer addSublayer:toBeFilledLayer];

    
    //Create and add the layer that has drawing for the progress
    arcLayer = [[AnimatingArcLayer alloc]init];
    //Create the arc layer and add it on top of the view.
     
    arcLayer.frame = frameForLayer;
    arcLayer.animationsEnabled = NO;
    
    arcLayer.fillColor = [UIColor redColor];
    arcLayer.strokeColor = [UIColor clearColor];
     
    arcLayer.startAngle = DegreesToRadians(0.0);
    arcLayer.endAngle = DegreesToRadians(360.0);
    
    arcLayer.name = @"arcLayer";
    [containerLayer addSublayer:arcLayer];
    
    maskProgressLayer = [[AnimatingArcLayer alloc]init];
    //Create the arc layer and add it on top of the view.
    
    maskProgressLayer.frame = frameForLayer;
    
    maskProgressLayer.animationsEnabled = NO;
    
    maskProgressLayer.fillColor = [UIColor redColor];
    maskProgressLayer.strokeColor = [UIColor clearColor];
    
    maskProgressLayer.startAngle = DegreesToRadians(0.0);
    maskProgressLayer.endAngle = DegreesToRadians(0.0);
    
    arcLayer.mask = maskProgressLayer;
    maskProgressLayer.name = @"maskProgress";
    
    //Start progress from North, and not from the east. this can also be made a configurable property
    [containerLayer setAffineTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUp];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setUp];
    }
    
    return self;
}

#pragma mark- Public interface

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    //Pin the progress value if it is outside of 0.0 and 1.0
    if(progress < 0.0)
    {
        progress = 0.0;
    }
    else if(progress > 1.0)
    {
        progress = 1.0;
    }
    
    maskProgressLayer.animationsEnabled = animated;
    arcLayer.animationsEnabled = animated;
    
    CGFloat endAngle = UnitValueToRadians(progress);
    
    maskProgressLayer.endAngle = endAngle;
    [maskProgressLayer setNeedsDisplay];
}

-(void)setThickness:(float)thickness
{
    //Pin the thickness to be within 0.0 and 1.0
    if (thickness < 0.0)
    {
        thickness = 0.0;
    }
    else if(thickness > 1.0)
    {
        thickness = 1.0;
    }
    
    _thickness = thickness;
    
    //We shall mask to reveal only the portion of the arc that is guided by the thickness.
    if(nil == maskLayer)
    {
        maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor blackColor].CGColor;
        self.layer.mask = maskLayer;
    }
    
    CGRect frameForLayer = self.bounds;
    maskLayer.frame = frameForLayer;
    
    CGFloat  radius = MIN(frameForLayer.size.width, frameForLayer.size.height)/2;
    
    
    CGPoint center;
    
    center.x = frameForLayer.size.width/2;
    center.y = frameForLayer.size.height/2;
    
    //Observe using 0.99 of actual radius, this is to smooth out
    //the drawings at edges. Otherwise, you will see jagged drawing in the periphery of your progress wheel.
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius*0.99 startAngle:0.0 endAngle:2*M_PI clockwise:YES];
    
    //The radius of inner unfilled circle path, that masks out the contents in the center again guided by extent set. 
    radius = radius * (1.0 - _thickness);
    
    
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI *2 clockwise:YES];
    
    path.usesEvenOddFillRule = YES;
    maskLayer.fillRule = @"even-odd"; //This rule does the trick of creating a mask with a unfilled circle in center and a filled one covering it.
    maskLayer.path = [path CGPath];
     
}

-(void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    
    arcLayer.fillColor = _progressTintColor;
    [arcLayer setNeedsDisplay];
}

-(void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor = trackTintColor;
    
    toBeFilledLayer.fillColor = _trackTintColor;
    [toBeFilledLayer setNeedsDisplay];
}

-(void)setStartAngle:(float)startAngle
{
    _startAngle = startAngle;
    
    [containerLayer setAffineTransform:CGAffineTransformMakeRotation(startAngle)];
    
}
@end
