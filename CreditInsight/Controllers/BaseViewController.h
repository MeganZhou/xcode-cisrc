//
//  BaseViewController.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableViewPopoverContent.h"
#import "HttpResponseDelegate.h"
#import "LoadingIndicator.h"

@interface BaseViewController : UIViewController<CommonTableViewPopoverDelegate,HttpResponseDelegate>

@property (strong, nonatomic) UIPopoverController *currentPopover;
@property (strong, nonatomic) UINavigationController *popoverNavigationController;
@property (strong, nonatomic) LoadingIndicator *indicator;

- (void)initView;
- (void)initNavigationBar;
- (void)setBarTitle:(NSString *)title;
- (void)closeCurrentPopover;
- (void)popoverTableView:(UIView *)view arrayContent:(NSArray *)array title:(NSString *)title;

@end
