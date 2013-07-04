//
//  CircularProgressBar.m
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft. All rights reserved.
//

#import "CircularProgressBar.h"
#import "AnimatingArcLayer.h"


CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees *  0.0174532925;
}

CGFloat UnitValueToRadians(CGFloat unitValue)
{
    //assert(unitValue >= 0.0 && unitValue <= 1.0);
    
    if(unitValue > 0.0)
    {
        return  unitValue * M_PI * 2;
    }
    else
        return 0.0;
}

@implementation CircularProgressBar
{
    AnimatingArcLayer *arcLayer;
    AnimatingArcLayer *toBeFilledLayer;

    CAShapeLayer *maskLayer;
}

-(void)setUp
{
    
    //Add To be filled layer first
    
    toBeFilledLayer = [[AnimatingArcLayer alloc]init];
    //Create the arc layer and add it on top of the view.
    CGRect frameForLayer = self.bounds;
    
    toBeFilledLayer.frame = frameForLayer;
    
    //Defaults
    toBeFilledLayer.animationsEnabled = NO;
    
    toBeFilledLayer.fillColor = [UIColor grayColor];
    arcLayer.strokeColor = [UIColor grayColor];
    self.extent = 0.1;
    
    toBeFilledLayer.startAngle = DegreesToRadians(0.0);
    toBeFilledLayer.endAngle = DegreesToRadians(360.0);
   
    [self.layer addSublayer:toBeFilledLayer];

    
    arcLayer = [[AnimatingArcLayer alloc]init];
    //Create the arc layer and add it on top of the view.
     
    arcLayer.frame = frameForLayer;
    
    //Defaults
    arcLayer.animationsEnabled = NO;
    
    arcLayer.fillColor = [UIColor redColor];
    arcLayer.strokeColor = [UIColor clearColor];
    self.extent = 0.1;
    
    arcLayer.startAngle = arcLayer.endAngle = DegreesToRadians(0.0);
    
    [self.layer addSublayer:arcLayer];
    

    [self.layer setAffineTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    
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


- (void)setProgress:(float)progress animated:(BOOL)animated
{
    //assert(progress >= 0.0 && progress <= 1.0);
    
    arcLayer.animationsEnabled = animated;
    
    //Compute end angle from the progress
    
    CGFloat endAngle = UnitValueToRadians(progress);
    
    NSLog(@"EndAngle = %lf", endAngle);
    
    arcLayer.endAngle = endAngle;
    
    [arcLayer setNeedsDisplay];
}

-(void)setExtent:(float)extent
{
    _extent = extent;
    
    if(nil == maskLayer)
    {
        maskLayer = [CAShapeLayer layer];
        self.layer.mask = maskLayer;
    }
    
    CGRect frameForLayer = self.bounds;

    maskLayer.frame = frameForLayer;
    
    CGFloat  radius = MIN(frameForLayer.size.width, frameForLayer.size.height)/2;
    
    
    CGPoint center;
    
    center.x = frameForLayer.size.width/2;
    center.y = frameForLayer.size.height/2;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius*0.99 startAngle:0.0 endAngle:2*M_PI clockwise:YES];
    
    radius = radius * (1.0 - _extent);
    
    
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI *2 clockwise:YES];
    
    path.usesEvenOddFillRule = YES;
    maskLayer.fillRule = @"even-odd";
    maskLayer.path = [path CGPath];
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    
}

@end
