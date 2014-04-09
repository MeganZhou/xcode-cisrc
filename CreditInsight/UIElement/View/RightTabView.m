//
//  RightTabView.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/11/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "RightTabView.h"

@implementation RightTabView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"RightTabView" owner:self options:nil];
      
      if (nibs) {
        self = [nibs objectAtIndex:0];
        self.frame = frame;
      }
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
  [self initView];
   
}

- (void)initView {
  [_lblFirst setTransform:CGAffineTransformMakeRotation(M_PI/2)];
  [_lblSecond setTransform:CGAffineTransformMakeRotation(M_PI/2)];
  [_lblThird setTransform:CGAffineTransformMakeRotation(M_PI/2)];
}


- (IBAction)onClickTabButton:(id)sender {
  UIButton *button = (UIButton *)sender;
  [self.delegate onClickTabButtonWithTag:button.tag];
  [self setActiveButtonLocation:button.tag];
  [self setButtonEnableWithCurrentButtonTag:button.tag];
}

- (void)setActiveButtonLocation:(NSInteger)tag {
  switch (tag) {
    case 1:
      [_activieImageView setFrame:CGRectMake(0, 14, 61, 184)];
      break;
    case 2:
      [_activieImageView setFrame:CGRectMake(0, 169, 61, 184)];
      break;
    case 3:
      [_activieImageView setFrame:CGRectMake(0, 323, 61, 184)];
      break;
      
    default:
      break;
  }
}

- (void)setButtonEnableWithCurrentButtonTag:(NSInteger)tag {
  for (int i = 1; i <= 3 ; i++ ) {
    UIButton *button = (UIButton *)[self viewWithTag:i];
    if (i == tag) {
      [button setEnabled:NO];
    } else {
      [button setEnabled:YES];
    }
  }
}

@end
