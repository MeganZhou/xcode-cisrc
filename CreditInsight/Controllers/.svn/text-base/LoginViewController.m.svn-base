//
//  LoginViewController.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 12/24/12.
//  Copyright (c) 2012 Zhou, Megan (external - Partner). All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "HttpClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initView {
  [_lblSAPCreditInsight setText:NSLocalizedString(@"SAPCreditInsight", nil)];
  [_btnLogin setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
  [_btnTrySampleData setTitle:NSLocalizedString(@"TrySampleData", nil) forState:UIControlStateNormal];
  [_username setPlaceholder:NSLocalizedString(@"Username", nil)];
  [_passcode setPlaceholder:NSLocalizedString(@"Passcode", nil)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  UITextField *nextTextField = (UITextField *)[self.view viewWithTag:(textField.tag + 1)];
  if (textField.tag == 1) {
    [nextTextField becomeFirstResponder];
  } else {
    [textField resignFirstResponder];
  }
  return NO;
}


- (IBAction)onClickLoginScrollButton:(id)sender {
  GlobalClassUtil.applicationMode = ProductApplication;
  NSDictionary *bodyParamDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"CI_DEV", @"Ci_dev_123",
                                                                     @"EN", nil] forKeys:[NSArray arrayWithObjects:@"${username}",@"${password}", @"${language}", nil]];
  [[HttpClient sharedInstance] invoke:self httpMethod:@"login:handler:" requestConfigName:@"login" urlParameter:nil bodyParameter:bodyParamDict];

}

- (IBAction)onClickTrySampleDataButton:(id)sender{
  GlobalClassUtil.applicationMode = DemoApplication;
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  [appDelegate loadHomeView];
}

- (void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig
{
    if ([requestConfig.name isEqualToString:@"login"]) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate loadHomeView];
    }
}

- (void)failed:(id)response requestConfig:(RequestConfig *)requestConfig {
  ErrorAlert(@"LoginController.Error.Message", self, kOnlyCancelAlertTag);
}

- (void)viewDidUnload {
  [self setBtnLogin:nil];
  [self setBtnTrySampleData:nil];
  [self setLblSAPCreditInsight:nil];
  [super viewDidUnload];
}
@end
