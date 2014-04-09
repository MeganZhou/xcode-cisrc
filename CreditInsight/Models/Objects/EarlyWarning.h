//
//  EarlyWarning.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 2/1/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"
@class GeneralInfo;
@class Matrix;

@interface EarlyWarning : BaseObject

@end

@interface Warning : BaseObject

@property (strong, nonatomic) NSString *warningId;
@property (strong, nonatomic) NSString *customerId;
@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) NSString *priority;
@property (strong, nonatomic) NSString *warningType;
@property (assign, nonatomic) BOOL isRead;

+ (id)convertJSON2Objects:(NSString *)jsonString;

@end

@interface WarningDetail : BaseObject

@property (strong, nonatomic) NSString *warningId;
@property (strong, nonatomic) NSString *customerId;
@property (strong, nonatomic) NSString *customerName;
@property (strong, nonatomic) GeneralInfo *generalInfo;
@property (strong, nonatomic) NSString *warningReason;

+ (WarningDetail *)convertJSON2Objects:(NSString *)jsonString;

@end

@interface GeneralInfo : NSObject

@property (strong, nonatomic) Matrix *matrix;
@property (strong, nonatomic) NSString *priority;

@end

@interface Matrix : NSObject

@property (strong, nonatomic) NSArray *locationArray;
@property (strong, nonatomic) NSMutableArray *valueArray;
@property (strong, nonatomic) NSArray *xLabelArray;
@property (strong, nonatomic) NSArray *yLabelArray;

@end