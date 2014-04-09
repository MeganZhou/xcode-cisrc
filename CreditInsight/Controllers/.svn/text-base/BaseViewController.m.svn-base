//
//  BaseViewController.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import "BaseViewController.h"
#import "Color.h"
#import "BaseObject.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initNavigationBar];
  [self initView];
  _indicator = [[LoadingIndicator alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

- (void)initView {
  // Do nothing, just for subclass to overide
}

- (void)initNavigationBar {
  // Do nothing, just for subclass to overide
}

- (void)setBarTitle:(NSString *)title {
  UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 24)];
  titleLabel.text = title;
  [titleLabel setBackgroundColor:[UIColor clearColor]];
  [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
  [titleLabel setTextColor:NAVIGATION_BAR_TITLE_COLOR];
  [titleLabel sizeToFit];
  self.navigationItem.titleView = titleLabel;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
}

- (void)closeCurrentPopover {
  if(_currentPopover && _currentPopover.popoverVisible) {
    [_currentPopover dismissPopoverAnimated:YES];
  }
}

- (void)popoverTableView:(UIView *)view arrayContent:(NSArray *)array title:(NSString *)title {
  [self closeCurrentPopover];
  CommonTableViewPopoverContent *comonTableViewPopoverContent = [[CommonTableViewPopoverContent alloc] initWithNibName:@"CommonTableViewPopoverContent" bundle:nil];
  comonTableViewPopoverContent.optionsArray = array;
  comonTableViewPopoverContent.delegate = self;
  _popoverNavigationController = [[UINavigationController alloc] initWithRootViewController:comonTableViewPopoverContent];
  [comonTableViewPopoverContent.navigationItem setTitle:title];
  self.currentPopover = [[UIPopoverController alloc] initWithContentViewController:_popoverNavigationController];
  [self.currentPopover setPopoverContentSize:comonTableViewPopoverContent.view.frame.size];
  [self.currentPopover presentPopoverFromRect:view.frame
                                       inView:view.superview
                     permittedArrowDirections:UIPopoverArrowDirectionUp
                                     animated:YES];
}


- (void)commonTableViewPopoverWithSelectRowAtIndexPath:(NSIndexPath *)indexPath {
// Do nothing
}

- (void)startServerInteraction {
  [self.view endEditing:YES];
  [self.view setUserInteractionEnabled:NO];
  [self.view addSubview:_indicator];
}

- (void)stopServerInteraction {
  if (GlobalClassUtil.applicationMode == ProductApplication) {
     sleep(1);
     [_indicator removeFromSuperview];
     [self.view setUserInteractionEnabled:YES];
  }
}

- (void)logout {
  LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController"
                                                                                   bundle:nil];
  [[[UIApplication sharedApplication]delegate]window].rootViewController = loginViewController;
}

#pragma mark -AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (alertView.tag == 1) {
    [self logout];
  }
}

#pragma mark - interface orientation
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


#pragma mark - http response delegate
-(void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig {
    
}



-(void)failed:(id)response requestConfig:(RequestConfig *)requestConfig {
  BaseObject *baseObject = (BaseObject *)response;
  if ([baseObject.status isEqualToString:@"expire"]) {
    WarningAlert(@"SessionExpireMsg", self, 1);
  } else {
  // Do nothing
  }
  
}


@end
