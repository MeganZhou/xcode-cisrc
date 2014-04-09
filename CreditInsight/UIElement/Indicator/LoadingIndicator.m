//
//  LoadingIndicator.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 2/6/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "LoadingIndicator.h"

@implementation LoadingIndicator

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  
  UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 163, 130)];
  [centerView setBackgroundColor:[UIColor blackColor]];
  centerView.layer.cornerRadius = 8;
  _indicator.frame = CGRectMake(centerView.center.x - _indicator.frame.size.width / 2, 35, _indicator.frame.size.width, _indicator.frame.size.height);
  [centerView addSubview:_indicator];

  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(centerView.center.x - 165/2, _indicator.frame.origin.y +_indicator.frame.size.height + 10, 165, 24)];
  label.adjustsFontSizeToFitWidth = NO;
  label.textAlignment = UITextAlignmentCenter;
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [UIColor whiteColor];
  label.font = [UIFont boldSystemFontOfSize:20.0];
  label.text = NSLocalizedString(@"Loading", nil);
  [centerView addSubview:label];
  centerView.center = self.center;
  [self addSubview:centerView];
  
  [_indicator startAnimating];
  [_indicator hidesWhenStopped];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
  [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
  
  [self setBackgroundColor:[UIColor blackColor]];
  [self setAlpha:0.5];
  
  return self;
}

@end
