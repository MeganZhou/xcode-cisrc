//
//  WorkListTableCell.m
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import "WorkListTableCell.h"

@implementation WorkListTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
  [super setSelected:selected animated:animated];

   
}

- (IBAction)onClickCustomer:(id)sender {
  [_delegate goCustomerViewController];
}


@end
