//
//  ViewCell.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 12/24/12.
//  Copyright (c) 2012 Zhou, Megan (external - Partner). All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewController;

#define kViewCellWidth 252
#define kViewCellHeight 210
#define kOffsetForKeyboard 360

@interface ViewCell : UIView <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteChart;
@property (weak, nonatomic) IBOutlet UITextField *fldChartName;
@property (weak, nonatomic) IBOutlet UIImageView *imgCellBkg;

@property (retain, nonatomic) NSString *chartName;
@property (retain, nonatomic) NSArray *reports;
@property (retain, nonatomic) HomeViewController *homeViewController;

@end
