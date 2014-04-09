//
//  Rectangle.m
//  TestDrawMatrix
//
//  Created by Zhou, Megan (external - Partner) on 1/31/13.
//  Copyright (c) 2013 Zhou, Megan (external - Partner). All rights reserved.
//

#import "Rectangle.h"
#import <QuartzCore/QuartzCore.h>

@implementation Rectangle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
 
  // Set fillColor
  if ([_colorSymbol isEqualToString:@"0"]) {
    // greenColor
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
  } else if ([_colorSymbol isEqualToString:@"1"]){
    // orangeColor
    CGContextSetRGBFillColor(context, 1.0, 0.5, 0.0, 1.0);
  } else if ([_colorSymbol isEqualToString:@"2"]){
    // redColor
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
  }
  
  if (_isWarning) {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"EarlyWarningIcon_highlight"]];
    imageView.frame = CGRectMake((self.frame.size.width - imageView.frame.size.width)/2, (self.frame.size.height - imageView.frame.size.height)/2, imageView.frame.size.width, imageView.frame.size.height);
    [self addSubview:imageView];
  }
  
  CGContextFillRect(context, rect);
  
  // Add line
  CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
  CGContextSetLineWidth(context, 1.0);  
  CGContextAddRect(context, rect);
  
  CGContextStrokePath(context);
}



@end
