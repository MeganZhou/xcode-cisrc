//
//  CreditInsightTests.m
//  CreditInsightTests
//
//  Created by wang liang on 11/30/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import "CreditInsightTests.h"
#import "SDMRequestBuilder.h"
#import "SDMODataCollection.h"
#import "SDMParser.h"
#import "SDMODataEntry.h"

@implementation CreditInsightTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in CreditInsightTests");
    
}

-(void)sendRequest:(NSString *)oDataURLStr onSuccess:(SEL)onSuccessSelector onFailure:(SEL)onFailureSelector
{
    [SDMRequestBuilder setRequestType:HTTPRequestType];
    self.request = [SDMRequestBuilder requestWithURL:[NSURL URLWithString:[oDataURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    // set additional request attributes
    [self.request setUseKeychainPersistence:NO];
    [self.request setUseSessionPersistence:NO];
    [self.request setUseCookiePersistence:NO];
    [self.request setShouldPresentCredentialsBeforeChallenge:NO];
    [self.request addRequestHeader:@"Accept" value:@"application/atom+xml,application/xml"];
    [self.request addRequestHeader:@"Content-Type" value:@"application/atom+xml"];
  //  [self.request addRequestHeader:@"X-Requested-With" value:@"SAPDataLibrary-ObjC"];
    
    [self.request setDelegate:self];
    [self.request setDidFailSelector:onFailureSelector];
    [self.request setDidFinishSelector:onSuccessSelector];
    [self.request setTimeOutSeconds:30];
    [self.request setRequestMethod:@"GET"];
    [self.request startSynchronous];
}

- (void)testRemoteOdataService
{
    STAssertEqualObjects(@"abc", @"abc", @"They are equal objects");
}

- (void)testLoadServiceDocument
{
    [self loadServiceDocument];
    [self loadMetadata];
    [self loadEntries];
}

- (void)loadServiceDocument
{
    NSString *url = @"http://10.58.150.200:8080/appui-0.0.1-SNAPSHOT/rest/";
    [self sendRequest:url onSuccess:@selector(oDataSucessful:) onFailure:@selector(oDataFailure:)];
}

- (void)loadMetadata
{
    NSString *url = @"http://10.58.150.200:8080/appui-0.0.1-SNAPSHOT/rest/$metadata";
    [self sendRequest:url onSuccess:@selector(oDataMetadataSuccessful:) onFailure:@selector(oDataFailure:)];
}

- (void)loadEntries
{
    NSString *url = @"http://10.58.150.200:8080/appui-0.0.1-SNAPSHOT/rest/Users";
    [self sendRequest:url onSuccess:@selector(oDataFeedSuccessful:) onFailure:@selector(oDataFailure:)];
}

#pragma mark - callback methods
-(void) oDataSucessful:(id<SDMRequesting>)theRequest
{
    NSLog(@"%@ %@ %d", [theRequest responseString], [theRequest responseStatusMessage], [theRequest responseStatusCode]);
    if([theRequest responseString] != nil && [theRequest responseStatusCode] < 300)
    {
        @try {
            self.serviceDocument = sdmParseODataServiceDocumentXML([theRequest responseData]);
            self.schema = [self.serviceDocument getSchema];
            NSLog(@"service document: %@",[self.serviceDocument description]);
            NSLog(@"schema: %@", [self.schema description]);
        }
        @catch (NSException *exception) {
            //
        }
        @finally {
            //
        }
    }
}

-(void) oDataFailure:(id<SDMRequesting>)theRequest
{
    NSLog(@"Failures");
}

-(void) oDataMetadataSuccessful:(id<SDMRequesting>)theRequest
{
    NSLog(@"%@ %@ %d", [theRequest responseString], [theRequest responseStatusMessage], [theRequest responseStatusCode]);
    if([theRequest responseString] != nil && [theRequest responseStatusCode] < 300)
    {
        @try {
            self.schema = sdmParseODataSchemaXML([theRequest responseData], self.serviceDocument);
        }
        @catch (NSException *exception) {
            //
        }
        @finally {
            //
        }
    }
}

-(void) oDataFeedSuccessful:(id<SDMRequesting>)theRequest
{
    NSLog(@"%@ %@ %d", [theRequest responseString], [theRequest responseStatusMessage], [theRequest responseStatusCode]);
    if([theRequest responseString] != nil && [theRequest responseStatusCode] < 300)
    {
        @try {
            SDMODataCollection *collection = [self.schema getCollectionByName:@"Users"];
            NSMutableArray *entries = sdmParseODataEntriesXML([theRequest responseData], collection.entitySchema, self.serviceDocument);
            for (SDMODataEntry *entry in entries) {
                NSDictionary *fields = entry.fields;
                NSLog(@"%@",[fields description]);
            }
        }
        @catch (NSException *exception) {
            //
        }
        @finally {
            //
        }
    }
}

@end
