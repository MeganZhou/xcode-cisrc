//
//  HttpClient.h
//  CreditInsight
//
//  Created by wang liang on 1/25/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestConfig.h"
#import "HttpResponseDelegate.h"

@class HttpClient;
@class ConnectionHandler;

@interface ConnectionHandler: NSObject<NSURLConnectionDelegate>
@property (nonatomic, strong) NSMutableData *response;
@property (nonatomic, strong) NSString *responseString;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic) id<HttpResponseDelegate> delegate;
@property (nonatomic, strong) HttpClient *httpClient;
@property (nonatomic) SEL method;
@property (nonatomic) BOOL hasError;
@property (nonatomic, strong) NSString *errorMessage;
@property (nonatomic, strong) RequestConfig *requestConfig;
@end



@interface HttpClient : NSObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSMutableDictionary *requestConfigs;
@property (nonatomic, strong) id<HttpResponseDelegate> delegate;

+(HttpClient *)sharedInstance;

/*!
 When there is no parameter with url string.
 */
- (void)invoke:(id<HttpResponseDelegate>)delegate
    httpMethod:(NSString *)methodName
requestConfigName:(NSString *)requestConfigName;

/*!
 When there are parameters with url string.
 bodyParameter is used for post method.
 */

- (void)invoke:(id<HttpResponseDelegate>)delegate
    httpMethod:(NSString *)methodName
requestConfigName:(NSString *)requestConfigName
  urlParameter:(NSDictionary *)urlParamDict
 bodyParameter:(NSDictionary *)bodyParamDict;

@end
