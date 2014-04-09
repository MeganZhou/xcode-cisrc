//
//  RequestConfig.h
//  CreditInsight
//
//  Created by wang liang on 1/14/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestConfig : NSObject

@property (nonatomic, strong) NSMutableString* name;
@property (nonatomic, strong) NSMutableString* uri;
@property (nonatomic, strong) NSMutableString* method;
@property (nonatomic, strong) NSDictionary* head;
@property (nonatomic, strong) NSMutableString * body;
@property (nonatomic, strong) NSString *demoResponse;

- (void)configURL:(NSDictionary *)urlParamDict Body:(NSDictionary *)bodyParamDict;
- (NSMutableURLRequest *)generateURLRequest:(NSString *)hostURL;
@end