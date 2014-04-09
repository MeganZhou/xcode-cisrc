//
//  HttpResponseDelegate.h
//  CreditInsight
//
//  Created by wang liang on 1/25/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestConfig.h"

@protocol HttpResponseDelegate <NSObject>

-(void)succeed:(id)response requestConfig:(RequestConfig *)requestConfig;

-(void)failed:(id)response requestConfig:(RequestConfig *)requestConfig;

@optional
- (void)startServerInteraction;
- (void)stopServerInteraction;

@end
