//
//  CallAlert.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 2/26/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "CallAlert.h"
#import "SynthesizeSingleton.h"

@implementation CallAlert

SYNTHESIZE_SINGLETON_FOR_CLASS(CallAlert);

#pragma mark singleton implementation
+(CallAlert *) instance {
  return [self sharedCallAlert];
}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}


- (void)errorAlert:(NSString *)message withDelegate:(id)object andTag:(NSInteger)tag {
  [self showAlert:message withTitle:NSLocalizedString(@"Error",nil) andDelegate:object andTag:tag];
}

- (void)warningAlert:(NSString *)message withDelegate:(id)object andTag:(NSInteger)tag {
  [self showAlert:message withTitle:NSLocalizedString(@"Warning",nil) andDelegate:object andTag:tag];
}

- (void)showAlert:(NSString *)message withTitle:(NSString *)title andDelegate:(id)object andTag:(NSInteger)tag {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                  message:NSLocalizedString(message, nil)
                                                 delegate:object
                                        cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                        otherButtonTitles:nil, nil];
  alert.tag = tag;
  [alert show];
}


@end
