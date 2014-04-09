//
//  LeftExpandableView.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/3/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "LeftExpandableView.h"
#import "QuartzCore/CoreAnimation.h"

@implementation LeftExpandableView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"LeftExpandableView" owner:self options:nil];
    
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
    }
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  if (_isHiddenSelf) {
    self.frame = CGRectMake(0, 0, 45, 748);
    _btnExpand.frame = CGRectMake(0, 0, 42, 748);
    [_leftContentView setHidden:YES];
  }
}

- (IBAction)onClickSwitchButton:(id)sender {
  if (_isHiddenSelf) {
    self.frame = CGRectMake(0, 0, 365, 748);
    CATransition *transition =[CATransition animation];
    transition.duration= 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.delegate = self;
    [self.layer addAnimation:transition forKey:nil];
    [_leftContentView setHidden:NO];
    _btnExpand.frame = CGRectMake(328, 0, 42, 748);
    _isHiddenSelf= NO;
  } else {
    CATransition *transition =[CATransition animation];
    transition.duration= 0.1f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.layer addAnimation:transition forKey:nil];
    [_leftContentView setHidden:YES];
    _btnExpand.frame = CGRectMake(0, 0, 42, 748);
    _isHiddenSelf = YES;
    self.frame = CGRectMake(0, 0, 45, 748);
  }
}


@end
