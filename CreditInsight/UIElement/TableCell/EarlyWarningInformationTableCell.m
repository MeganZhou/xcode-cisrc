//
//  EarlyWarningInformationTableCell.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/31/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "EarlyWarningInformationTableCell.h"
#import "Rectangle.h"
#import "EarlyWarning.h"
#import "NSMutableArray+Stack.h"

@implementation EarlyWarningInformationTableCell

- (void)awakeFromNib {
  [self trasformYAxies];
  [self internationalizeLabels];
  self.warningReportView.layer.borderWidth = 2.0;
  self.warningReportView.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

- (void)drawMatrixRectangle:(Matrix *)matrix {
//  NSLog(@" _matrix.valueArray == %@, _matrix.locationArray == %@", matrix.valueArray, matrix.locationArray);
  int locationX = [[matrix.locationArray objectAtIndex:0] intValue];
  int locationY = [[matrix.locationArray objectAtIndex:1] intValue];
  
  NSMutableArray *newMatrixArray = [NSMutableArray array];
  NSArray *matrixValueArray = [matrix.valueArray mutableCopy];
  
  // Revert the valueArray.
  for (NSArray *array in matrixValueArray) {
    [newMatrixArray addObject:[matrix.valueArray pop]];
  }
 
  for (int indexOfArray = 0; indexOfArray < [newMatrixArray count]; indexOfArray++) {
    NSArray *currentArray = [newMatrixArray objectAtIndex:indexOfArray];
    CGFloat newOrignY = kRectangleHeight * indexOfArray;
    for (int indexOfXArray = 0; indexOfXArray < [currentArray count]; indexOfXArray++) {
      CGFloat newOrignX = kRectangleWidth * indexOfXArray;
      NSString *xValue = [NSString stringWithFormat:@"%@", [currentArray objectAtIndex:indexOfXArray]];
      CGRect rect = CGRectMake(newOrignX, newOrignY, kRectangleWidth, kRectangleHeight);
      Rectangle *rectangle = [[Rectangle alloc] initWithFrame:rect];
      rectangle.colorSymbol = xValue;
      
      if (indexOfXArray == locationX && indexOfArray == locationY) {
        rectangle.isWarning = YES;
      }
      
      [self.warningReportView addSubview:rectangle];
    }
  }
  
}

- (void)trasformYAxies {
  _lblYAxiesName.transform = CGAffineTransformMakeRotation(-M_PI_2);
  _lblYAxiesName.frame = CGRectMake(20.0, (self.warningReportView.frame.size.height - _lblYAxiesName.frame.size.height)/2, _lblYAxiesName.frame.size.width, _lblYAxiesName.frame.size.height);
}

- (void)internationalizeLabels {
  _lblYAxiesName.text = NSLocalizedString(@"Profitability", nil);
  _lblXAxiesName.text = NSLocalizedString(@"Impact", nil);
  _lblRemote.text = NSLocalizedString(@"Remote", nil);
  _lblUnlikely.text = NSLocalizedString(@"Unlikely", nil);
  _lblLikely.text = NSLocalizedString(@"Likely", nil);
  _lblHighLikely.text = NSLocalizedString(@"HighLikely", nil);
  _lblNearCertain.text = NSLocalizedString(@"NearCertain", nil);
  _lblInsignificant.text = NSLocalizedString(@"Insignificant", nil);
  _lblMinor.text = NSLocalizedString(@"Minor", nil);
  _lblModerate.text = NSLocalizedString(@"Moderate", nil);
  _lblMajor.text = NSLocalizedString(@"Major", nil);
  _lblCatastrophic.text = NSLocalizedString(@"Catastrophic", nil);
}

@end
