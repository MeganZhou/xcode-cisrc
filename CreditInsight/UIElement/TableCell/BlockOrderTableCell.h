//
//  BlockOrderTableCell.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/4/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockOrderTableCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lblSaleOrderNO;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedDate;
@property (weak, nonatomic) IBOutlet UIImageView *unReadIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblSaleOrderNoTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAmountTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedDateTitle;

@end
