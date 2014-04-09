//
//  GlobalClass.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/4/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Report.h"

@class CommonChart;

typedef enum {
  DemoApplication = 1,
  ProductApplication = 2,
} ApplicationMode;


@interface GlobalClass : NSObject 

+ (GlobalClass *)sharedGlobalClass;

@property (retain, nonatomic) NSMutableArray *tempChartNames;
@property (readwrite, nonatomic) ApplicationMode applicationMode;
@property (retain, nonatomic) NSMutableDictionary *settingValues;
@property (retain, nonatomic) NSMutableDictionary *isUnlockDict;

@property (retain, nonatomic) NSMutableDictionary *isReadDict;
@property (retain, nonatomic) NSMutableDictionary *currentBehaviourReportsDict;


@property (retain, nonatomic) NSMutableArray *tempReports;

- (CommonChart *)chartView:(CGRect)rect
                    report:(Report *)report;

- (NSDictionary *)reportTypeDict;

@end
