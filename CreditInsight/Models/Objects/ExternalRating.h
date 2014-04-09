//
//  ExternalRating.h
//  CreditInsight
//
//  Created by wang liang on 1/11/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

@interface ExternalRating : BaseObject

@property (strong, nonatomic) NSString *org;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString  *updatedDate;
@property (strong, nonatomic) NSArray *levels;

+ (id)convertJSON2Objects:(NSString *)jsonString;

@end
