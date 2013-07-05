//
//  AnimatingArcLayer.m
//  CircularProgressBar
//
//  Created by nsh on 02/07/13.
//  Copyright (c) 2013 Robosoft. All rights reserved.
//
//Based on: http://blog.pixelingene.com/2012/02/animating-pie-slices-using-a-custom-calayer/

#import "AnimatingArcLayer.h"

@implementation AnimatingArcLayer

//These custom animatable properties must be dynamic.
@dynamic startAngle, endAngle, fillColor, strokeColor;

-(CABasicAnimation *)makeAnimationForKey:(NSString *)key
{
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:key];
    //Presentation layer always will have most recent value for the key. The 'to' value
    //is implicitely set to the animation by QuartzCore to the value of the key that is set,
	anim.fromValue = [[self presentationLayer] valueForKey:key];
	anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	anim.duration = 0.5;
    
	return anim;
}

- (id)init
{
    self = [super init];
    if (self)
    {
		self.fillColor = [UIColor clearColor];
        self.strokeColor = [UIColor clearColor];
		[self setNeedsDisplay];
    }
	
    return self;
}

-(id<CAAction>)actionForKey:(NSString *)event
{
	if (([event isEqualToString:@"startAngle"] ||
		[event isEqualToString:@"endAngle"] ||
         [event isEqualToString:@"fillColor"] ||
         [event isEqualToString:@"strokeColor"]) && self.animationsEnabled)
    {
        
		return [self makeAnimationForKey:event];
	}
	
	return [super actionForKey:event];
}

- (id)initWithLayer:(id)layer
{
	if (self = [super initWithLayer:layer])
    {
		if ([layer isKindOfClass:[AnimatingArcLayer class]])
        {
			AnimatingArcLayer *other = (AnimatingArcLayer *)layer;
			self.startAngle = other.startAngle;
			self.endAngle = other.endAngle;
			self.fillColor = other.fillColor;
            
			self.strokeColor = other.strokeColor;
		}
	}
	
	return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
	if ([key isEqualToString:@"startAngle"] ||
        [key isEqualToString:@"endAngle"] ||
        [key isEqualToString:@"fillColor"] ||
        [key isEqualToString:@"strokeColor"])
    {
		return YES;
	}
	
	return [super needsDisplayForKey:key];
}


-(void)drawInContext:(CGContextRef)ctx
{
	
	CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
	CGFloat radius = MIN(center.x, center.y);
	
	CGContextBeginPath(ctx);
	CGContextMoveToPoint(ctx, center.x, center.y);
	
	CGPoint p1 = CGPointMake(center.x + radius * cosf(self.startAngle), center.y + radius * sinf(self.startAngle));
	CGContextAddLineToPoint(ctx, p1.x, p1.y);
    
    //This will decide how the arc will be filled inward or outward.
	int clockwise = fabs(self.startAngle) > fabs(self.endAngle);
	CGContextAddArc(ctx, center.x, center.y, radius, self.startAngle, self.endAngle, clockwise);
    
	CGContextClosePath(ctx);
    
	CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
	CGContextSetStrokeColorWithColor(ctx, self.strokeColor.CGColor);
	CGContextSetLineWidth(ctx, 1.0);
    CGContextSetShouldAntialias(ctx, YES);
    CGContextSetAllowsAntialiasing(ctx, YES);
	CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
