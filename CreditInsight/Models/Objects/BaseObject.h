//
//  BaseObject.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 3/4/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *status;

+ (NSDictionary *)covertJSON2Dict:(NSString *)jsonString;

@end
