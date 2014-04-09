//
//  ReportsViewerHeaderTableCell.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/9/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsViewerHeaderTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCategoryName;
@property (weak, nonatomic) IBOutlet UIScrollView *seriesScrollView;

@end
