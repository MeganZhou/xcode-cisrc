//
//  WorkListTableCell.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WorkListTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCustomer;
@property (weak, nonatomic) IBOutlet UILabel *lblItemProperty1;
@property (weak, nonatomic) IBOutlet UILabel *lblItemProperty2;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCustomerName;
@property (weak, nonatomic) IBOutlet UILabel *lblItemPropertyValue1;
@property (weak, nonatomic) IBOutlet UILabel *lblItemPropertyValue2;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedDateValue;
@property (weak, nonatomic) IBOutlet UIImageView *unReadIconImageView;

@end
