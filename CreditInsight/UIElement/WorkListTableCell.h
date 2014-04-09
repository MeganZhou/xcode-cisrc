//
//  WorkListTableCell.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WorkListTableCellDelegate <NSObject>

- (void)goCustomerViewController;

@end

@interface WorkListTableCell : UITableViewCell

@property (retain, nonatomic) id <WorkListTableCellDelegate> delegate;



@end
