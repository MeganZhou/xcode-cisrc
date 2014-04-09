//
//  CreditInsightTests.h
//  CreditInsightTests
//
//  Created by wang liang on 11/30/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "SDMRequesting.h"
#import "SDMODataServiceDocument.h"
#import "SDMODataSchema.h"

@interface CreditInsightTests : SenTestCase

@property (weak) id<SDMRequesting> request;
@property (strong) SDMODataServiceDocument* serviceDocument;
@property (strong) SDMODataSchema *schema;

-(void)sendRequest:(NSString *)oDataURLStr onSuccess:(SEL)onSuccessSelector onFailure:(SEL)onFailureSelector;
@end
