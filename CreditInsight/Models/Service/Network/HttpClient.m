//
//  HttpClient.m
//  CreditInsight
//
//  Created by wang liang on 1/25/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "HttpClient.h"
#import "SynthesizeSingleton.h"
#import "Notification.h"
#import "GlobalClass.h"
#import "Report.h"
#import "Customer.h"
#import "CreditEvents.h"
#import "ExternalRating.h"
#import "ScoreRating.h"
#import "FinancialRatio.h"
#import "Customer.h"
#import "SalesOrder.h"
#import "Filters.h"
#import "CreditRequest.h"
#import "EarlyWarning.h"
#import "DSODBT.h"
#import "AgingOfReceivables.h"
#import "DunningCollection.h"
#import "Profitability.h"

@implementation ConnectionHandler

-(id)init:(id<HttpResponseDelegate>)delegate httpClient:(HttpClient *)httpClient
httpMethod:(SEL)method
{
  self = [super init];
  if (self) {
    self.connection = nil;
    self.delegate = delegate;
    self.requestConfig = nil;
    self.responseString = nil;
    self.httpClient = httpClient;
    self.method = method;
    self.hasError = NO;
  }
  return self;
}

-(void)start:(RequestConfig *)requestConfig delegate:(id<HttpResponseDelegate>)delegate
{
  self.requestConfig = requestConfig;
  NSMutableURLRequest *request = [self.requestConfig generateURLRequest:[HttpClient sharedInstance].url];
  NSLog(@"[HttpClient sharedInstance].url == %@", [HttpClient sharedInstance].url);
  NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
  self.connection = connection;
  self.delegate = delegate;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
  self.response = [NSMutableData data];
  uint erroCode = [httpURLResponse statusCode];
  NSLog(@"connection:didReceiveResponse: erroCode/statusCode == %d", erroCode);
  if(erroCode > 300){
    self.hasError = YES;
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [self.response appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  [self.delegate stopServerInteraction];
  if ([error code] == kCFURLErrorNotConnectedToInternet || [error code] == kCFURLErrorCannotConnectToHost) {
    self.errorMessage = NSLocalizedString(@"NotConnectToServerMsg", nil);
  } else if ([error code] == kCFURLErrorTimedOut) {
    self.errorMessage = NSLocalizedString(@"TimedOutMsg", nil);
  } else {
    self.errorMessage = NSLocalizedString(@"OtherNetworkError", nil);
  }
  ErrorAlert(self.errorMessage, self.delegate, kOnlyCancelAlertTag);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  NSLog(@"Response received, its size = %d", [self.response length]);
	self.responseString = [[NSString alloc] initWithData:self.response encoding:NSUTF8StringEncoding];
  NSLog(@"connectionDidFinishLoading: self.responseString is %@", self.responseString);

    if (self.hasError) {
      self.responseString = nil;
      ErrorAlert(NSLocalizedString(@"DefaultErrorMsg", nil), self.delegate, kOnlyCancelAlertTag);
    } else {
      if ([self.httpClient respondsToSelector:self.method]) {
       #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.httpClient performSelector:self.method withObject:self.delegate withObject:self];
      }
   }
}


@end

@interface HttpClient()
@property (nonatomic, strong) NSMutableSet *handlers;
@end

@implementation HttpClient

#pragma mark - singleton

static HttpClient *sharedInstance = nil;

+ (HttpClient *)sharedInstance
{
  @synchronized(self)
  {
    if (sharedInstance == nil)
    {
      sharedInstance = [[self alloc] init];
      //init handlers array
      sharedInstance.handlers = [NSMutableSet set];
    }
    
    //load RestAPI.plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RestAPI" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    sharedInstance.url = [dict objectForKey:@"url"];
    NSArray *requests = [dict objectForKey:@"requests"];
    sharedInstance.requestConfigs = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in requests) {
      RequestConfig *config = [[RequestConfig alloc] init];
      config.name = [NSMutableString stringWithString:[dict objectForKey:@"name"]];
      config.demoResponse = [dict objectForKey:@"demoResponse"];
      config.body = [dict objectForKey:@"body"];
      config.head = [dict objectForKey:@"head"];
      config.method = [dict objectForKey:@"method"];
      config.uri = [NSMutableString stringWithString:[dict objectForKey:@"uri"]];
      [sharedInstance.requestConfigs setObject:config forKey:config.name];
    }
  }
  return sharedInstance;
}

#pragma mark invoke an http method with specified request configuration
- (void)invoke:(id<HttpResponseDelegate>)delegate
   httpMethod:(NSString *)methodName
requestConfigName:(NSString *)requestConfigName
{
  [self sendRequest:delegate httpMethod:methodName requestConfigName:requestConfigName urlParameter:nil bodyParameter:nil];
}

- (void)invoke:(id<HttpResponseDelegate>)delegate
    httpMethod:(NSString *)methodName
requestConfigName:(NSString *)requestConfigName
  urlParameter:(NSDictionary *)urlParamDict
 bodyParameter:(NSDictionary *)bodyParamDict {
  [self sendRequest:delegate httpMethod:methodName requestConfigName:requestConfigName urlParameter:urlParamDict bodyParameter:bodyParamDict];
}

- (void)sendRequest:(id<HttpResponseDelegate>)delegate
httpMethod:(NSString *)methodName
requestConfigName:(NSString *)requestConfigName
urlParameter:(NSDictionary *)urlParamDict
 bodyParameter:(NSDictionary *)bodyParamDict {
  //selector method
  SEL method = NSSelectorFromString(methodName);
  
  //handler
  ConnectionHandler *handler = [[ConnectionHandler alloc] init:delegate httpClient:self httpMethod:method];
  [self.handlers addObject:handler];
  //request config
  RequestConfig *requestConfig = (RequestConfig *)[self.requestConfigs objectForKey:requestConfigName];  
  [requestConfig configURL:urlParamDict Body:bodyParamDict];
  
  //invoke handler
  if (GlobalClassUtil.applicationMode == DemoApplication) {
    //runtime for demo
    handler.requestConfig = requestConfig;
    handler.responseString = requestConfig.demoResponse;
    if ([self respondsToSelector:method]) {
      #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      [self performSelector:method withObject:delegate withObject:handler];
    }
  }else{
    //runtime for real network
    [handler start:requestConfig delegate:delegate];
    [delegate startServerInteraction];
  }
}

#pragma mark -- demo data handle
-(void)login:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler
{
   [delegate stopServerInteraction];
    int length = [handler.responseString rangeOfString:@"<loggedIn>true</loggedIn>"].length;
    if ( length > 0 ) {
        [delegate succeed:nil requestConfig:handler.requestConfig];
    }else{
        [delegate failed:nil requestConfig:handler.requestConfig];
    }
    [self.handlers removeObject:handler];
}

- (void)retrieveNotifications:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [Notification convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)retrieveReports:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [Report convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)retrieveFilters:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [Filters convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  }else{
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)searchCustomers:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [Customer convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)customerDetailInfo:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [Customer convertJSON2Object:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)retrieveBlockedOrderList:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [SalesOrder convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)searchDetailSalesOrderInfo:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [SalesOrder convertJSON2Object:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)retrieveCreditRequestList:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [CreditRequest convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}


- (void)searchDetailCreditRequestInfo:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [CreditRequest convertJSON2Object:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }
   
  [self.handlers removeObject:handler];
}
// TODO: About fail excetion handle need refine
- (void)customerOverview:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [FinancialRatio convertJSON2Dictionary:handler.responseString];
  if (length > 0) {
    NSString *jsonResponse = handler.responseString;
    ScoreRating *scoreRating = [ScoreRating convertJSON2Objects:jsonResponse];
    NSArray *externalRatingArray = [ExternalRating convertJSON2Objects:jsonResponse];
    NSDictionary *finacialRatioDict = [FinancialRatio convertJSON2Dictionary:jsonResponse];
    CreditEvents *creditEvents = [CreditEvents convertJSON2Objects:jsonResponse];
    NSDictionary *customerOverviewDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          scoreRating, @"scoreRating",
                                          externalRatingArray, @"externalRating",
                                          finacialRatioDict, @"finacialRatio",
                                          creditEvents, @"creditEvents",
                                          nil];
  
    [delegate succeed:customerOverviewDict requestConfig:handler.requestConfig];
  } else {
    [delegate failed:response requestConfig:handler.requestConfig];
  }

  [self.handlers removeObject:handler];
}

- (void)retrieveEarlyWarningList:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [Warning convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  }else{
    [delegate failed:response requestConfig:handler.requestConfig];
  }
   
  [self.handlers removeObject:handler];
}


- (void)retrieveEarlyWarningDetail:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [WarningDetail convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  }else{
    [delegate failed:response requestConfig:handler.requestConfig];
  }
   
  [self.handlers removeObject:handler];
}

- (void)retrieveDSOReports:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [DSODBT convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  }else{
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)retrieveARReports:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [AgingOfReceivables convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  }else{
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)retrieveDCReports:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [DunningCollection convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  }else{
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)retrievePRFReports:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  id response = [Profitability convertJSON2Objects:handler.responseString];
  if (length > 0) {
    [delegate succeed:response requestConfig:handler.requestConfig];
  }else{
    [delegate failed:response requestConfig:handler.requestConfig];
  }
  [self.handlers removeObject:handler];
}

- (void)retrieveFavoriteReports:(id<HttpResponseDelegate>)delegate handler:(ConnectionHandler *)handler {
  [delegate stopServerInteraction];
  int length = [handler.responseString rangeOfString:@"success"].length;
  if (length > 0) {
    // The responseString is '{"message":"success to get Data from Backend!","status":"success"}'
    [delegate succeed:handler.responseString requestConfig:handler.requestConfig];
  }else{
    [delegate failed:nil requestConfig:handler.requestConfig];
  }
   
  [self.handlers removeObject:handler];
}

@end
