//
//  CustomLinkButton.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/2/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CustomLinkButton.h"

@implementation CustomLinkButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
  CGRect textRect = self.titleLabel.frame;
  CGFloat descender = self.titleLabel.font.descender;
  CGContextRef contextRef = UIGraphicsGetCurrentContext();
  CGFloat shadowHeight = self.titleLabel.shadowOffset.height;
  descender += shadowHeight;
  CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
  CGContextSetLineWidth(contextRef, 0.5);
  CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + 2);
  CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y  + textRect.size.height + descender + 2);
  CGContextClosePath(contextRef);
  CGContextDrawPath(contextRef, kCGPathStroke);
}


@end
