//
//  CreditRequestView.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/30/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpResponseDelegate.h"
#import "CreditRequest.h"
#import "Customer.h"
#import "BaseViewController.h"

@protocol  CreditRequestViewDelegate <NSObject>

- (void)showPDFDocument;

@end

@interface CreditRequestView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (retain, nonatomic) CreditRequest *creditRequest;
@property (retain, nonatomic) Customer *selectedCustomer;
@property (retain, nonatomic) NSDictionary *lableNames;
@property (retain, nonatomic) NSArray *keys;
@property (weak, nonatomic) IBOutlet UITableView *creditRequestDetailTableView;
@property (weak, nonatomic) IBOutlet UITableView *creditRequestListTableView;
@property (retain, nonatomic) NSArray *creditRequests;
@property (retain, nonatomic) NSString *itemId;
@property (retain, nonatomic) UIImageView *unReadImageView;
@property (nonatomic) NSInteger lastRow;
@property (retain, nonatomic) id<CreditRequestViewDelegate,HttpResponseDelegate> delegate;

-(void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig;
- (void)initData;

@end
