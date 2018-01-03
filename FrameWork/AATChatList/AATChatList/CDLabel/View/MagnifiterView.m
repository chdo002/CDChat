//
//  MagnifiterView.m
//  CoreTextDemo
//
//  Created by tangqiao on 5/8/14.
//  Copyright (c) 2014 TangQiao. All rights reserved.
//

#import "MagnifiterView.h"

@implementation MagnifiterView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:CGRectMake(0, 0, 80, 80)]) {
		// make the circle-shape outline with a nice border.
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 1;
		self.layer.cornerRadius = 40;
		self.layer.masksToBounds = YES;
	}
	return self;
}

- (void)setTouchPoint:(CGPoint)touchPoint {
    _touchPoint = touchPoint;
    self.center = CGPointMake(touchPoint.x, touchPoint.y - 70);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
	CGContextScaleCTM(context, 1.5, 1.5);
	CGContextTranslateCTM(context, -1 * (_touchPoint.x), -1 * (_touchPoint.y));
	[self.viewToMagnify.layer renderInContext:context];
}

@end
