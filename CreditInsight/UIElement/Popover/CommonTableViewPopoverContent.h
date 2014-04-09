//
//  CommonTableViewPopoverContent.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/8/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommonTableViewPopoverDelegate <NSObject>

@required
- (void)commonTableViewPopoverWithSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CommonTableViewPopoverContent : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSArray *optionsArray;
@property (strong, nonatomic) IBOutlet UITableView *commonTableView;
@property (assign, nonatomic) id<CommonTableViewPopoverDelegate> delegate;

@end
