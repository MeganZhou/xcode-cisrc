//
//  Notification.h
//  CreditInsight
//
//  Created by wang liang on 1/14/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"

typedef enum
{
    BLOCKED_ORDER = 1,
    CREDIT_REQUEST = 2,
    EARLY_WARNING = 3
}NotificationType;


@interface Notification : BaseObject

@property (nonatomic) NotificationType type;
@property (nonatomic) uint number;

+(id)convertJSON2Objects:(NSString *)jsonString;

@end
