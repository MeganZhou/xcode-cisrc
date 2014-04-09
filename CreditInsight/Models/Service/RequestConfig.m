//
//  RequestConfig.m
//  CreditInsight
//
//  Created by wang liang on 1/14/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "RequestConfig.h"

@implementation RequestConfig

- (void)configURL:(NSDictionary *)urlParamDict Body:(NSDictionary *)bodyParamDict {
  for (NSString *urlParamKey in [urlParamDict allKeys]) {
    self.uri = [NSMutableString stringWithString:[self.uri stringByReplacingOccurrencesOfString:urlParamKey withString:[urlParamDict objectForKey:urlParamKey]]];
  }
  for (NSString *bodyParamKey in [bodyParamDict allKeys]) {
    self.body = [NSMutableString stringWithString:[self.body stringByReplacingOccurrencesOfString:bodyParamKey withString:[bodyParamDict objectForKey:bodyParamKey]]];
  }
  
}


#pragma mark build NSURLRequest
-(NSMutableURLRequest *)generateURLRequest:(NSString *)hostURL
{
	//create request
  NSString *url = [NSString stringWithFormat:@"%@%@",hostURL,self.uri];
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                       cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                   timeoutInterval:60000];
  [req setHTTPShouldHandleCookies:YES];
  [req setHTTPMethod:self.method];
  NSLog(@"URL: %@", self.uri);
	
	//add the header info
	NSArray *keyArray = [self.head allKeys];
	for (int i = 0; i < [keyArray count]; ++i) {
		NSString *key = (NSString *)[keyArray objectAtIndex:i];
		NSString *value = [self.head objectForKey:key];
		[req addValue:value forHTTPHeaderField:key];
		NSLog(@"Head: key:%@ value:%@", key, value);
	}
    
    //add body
//    NSMutableString *data = [NSMutableString string];
//    for (NSString *key in [self.body allKeys]) {
//        NSString *value = [self.body objectForKey:key];
//        [data appendFormat:@"%@=%@&", key, value];
//    }
    if(self.body){
        [req setHTTPBody:[self.body dataUsingEncoding:NSUTF8StringEncoding]]; 
    }
	return req;
}

@end
