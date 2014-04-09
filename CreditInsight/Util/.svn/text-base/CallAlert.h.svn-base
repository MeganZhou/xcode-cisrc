//
//  CallAlert.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 2/26/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#define WarningAlert(message,delegate,tag) [[CallAlert instance] warningAlert:message withDelegate:delegate andTag:tag]
#define ErrorAlert(message,delegate,tag) [[CallAlert instance] errorAlert:message withDelegate:delegate andTag:tag]

#import <Foundation/Foundation.h>
#define kOnlyCancelAlertTag 0

@interface CallAlert : NSObject


- (void)warningAlert:(NSString *)message  withDelegate:(id)object andTag:(NSInteger)tag;
- (void)errorAlert:(NSString *)message withDelegate:(id)object andTag:(NSInteger)tag;

+ (CallAlert *)instance;

@end
