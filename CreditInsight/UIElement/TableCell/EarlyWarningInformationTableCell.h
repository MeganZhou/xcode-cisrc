//
//  EarlyWarningInformationTableCell.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/31/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Matrix;

#define kRectangleWidth 85
#define kRectangleHeight 50

@interface EarlyWarningInformationTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *warningReportView;
@property (weak, nonatomic) IBOutlet UILabel *lblYAxiesName; // Profitability
@property (weak, nonatomic) IBOutlet UILabel *lblXAxiesName; // Impact
@property (weak, nonatomic) IBOutlet UILabel *lblRemote;
@property (weak, nonatomic) IBOutlet UILabel *lblUnlikely;
@property (weak, nonatomic) IBOutlet UILabel *lblLikely;
@property (weak, nonatomic) IBOutlet UILabel *lblHighLikely;
@property (weak, nonatomic) IBOutlet UILabel *lblNearCertain;
@property (weak, nonatomic) IBOutlet UILabel *lblInsignificant;
@property (weak, nonatomic) IBOutlet UILabel *lblMinor;
@property (weak, nonatomic) IBOutlet UILabel *lblModerate;
@property (weak, nonatomic) IBOutlet UILabel *lblMajor;
@property (weak, nonatomic) IBOutlet UILabel *lblCatastrophic;

- (void)drawMatrixRectangle:(Matrix *)matrix;

@end
