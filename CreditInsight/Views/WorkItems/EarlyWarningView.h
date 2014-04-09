//
//  EarlyWarningView.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/31/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpResponseDelegate.h"

#define kEarlyWarningListTableView 10

@interface EarlyWarningView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *warningDetailTableView;
@property (weak, nonatomic) IBOutlet UITableView *warningListTableView;
@property (retain, nonatomic) NSString *itemId;
@property (retain, nonatomic) UIImageView *unReadImageView;
@property (retain, nonatomic) NSDictionary *lableNames;
@property (retain, nonatomic) NSArray *keys;
@property (nonatomic) NSInteger lastRow;
@property (retain, nonatomic) id<HttpResponseDelegate> delegate;
@property (strong, nonatomic) NSArray *warningList;


-(void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig;
- (void)initData;

@end

