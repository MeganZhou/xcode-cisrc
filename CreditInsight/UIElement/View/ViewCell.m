//
//  ViewCell.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 12/24/12.
//  Copyright (c) 2012 Zhou, Megan (external - Partner). All rights reserved.
//

#import "ViewCell.h"
#import "HomeViewController.h"
#import "HttpClient.h"

@implementation ViewCell

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ViewCell" owner:self options:nil];
    
    if (nibs) {
      self = [nibs objectAtIndex:0];
      self.frame = frame;
      self.btnDeleteChart.enabled = NO;
      self.btnDeleteChart.hidden = YES;
      self.fldChartName.enabled = NO;
      self.imgCellBkg.hidden = YES;
    }
  }
  
  return self;
}

- (IBAction)onClickDeleteChartButton:(id)sender {
//  NSLog(@"delete Favorite the name is == %@", self.fldChartName.text);
  NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.fldChartName.text, @"{name}", nil];
  [[HttpClient sharedInstance] invoke:_homeViewController httpMethod:@"retrieveFavoriteReports:handler:" requestConfigName:@"deletefavorite" urlParameter:urlParamDict bodyParameter:nil];
  
  [self removeFromSuperview];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  _chartName = textField.text;
  [[NSNotificationCenter defaultCenter] addObserver:_homeViewController selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:_homeViewController selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  if (![self.fldChartName.text isEqualToString:_chartName]) {
    NSMutableString *reportIdsString = nil;
    for (Report *report in self.reports) {
      if (0 == [self.reports indexOfObject:report]) {
        reportIdsString = [NSMutableString stringWithFormat:@"%@", report.reportId];
      } else {
        [reportIdsString appendFormat:@",%@", report.reportId];
      }
    }
    
    //  NSLog(@"modify Favorite the oldname is == %@, newname is == %@, reportIdsString is == %@", _chartName, self.fldChartName.text, reportIdsString);
    NSDictionary *urlParamDict = [NSDictionary dictionaryWithObjectsAndKeys:_chartName, @"{oldName}", self.fldChartName.text, @"{newName}", reportIdsString, @"{id,id,id}", nil];
    [[HttpClient sharedInstance] invoke:_homeViewController httpMethod:@"retrieveFavoriteReports:handler:" requestConfigName:@"modifyfavorite" urlParameter:urlParamDict bodyParameter:nil];
  }
  [[NSNotificationCenter defaultCenter] removeObserver:_homeViewController name:UIKeyboardWillShowNotification object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  if ([touch.view isEqual:self.btnDeleteChart]) {
    return NO;
  } else {
    return YES;
  }
}

@end
