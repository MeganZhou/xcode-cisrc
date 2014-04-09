//
//  EarlyWarning.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 2/1/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "EarlyWarning.h"
#import "RequestConfig.h"

@implementation EarlyWarning

@end

@implementation Warning

+ (id)convertJSON2Objects:(NSString *)jsonString {
  NSDictionary *dict =  [self covertJSON2Dict:jsonString];
  BaseObject *baseObject = [[BaseObject alloc] init];
  baseObject.status = [dict objectForKey:@"status"];
  baseObject.message = [dict objectForKey:@"message"];
  if (![baseObject.status isEqualToString:@"success"]) return baseObject;
  
  NSMutableArray *dataArray = [NSMutableArray array];
  NSDictionary *data = [dict objectForKey:@"data"];
  
  NSDictionary *warningArray = [data objectForKey:@"warning"];  
  for (NSDictionary *warningDict in warningArray) {
    Warning *warning = [[Warning alloc] init];
    if ([[warningDict allKeys] count] > 0) {
      NSString *warningId = [[warningDict allKeys] objectAtIndex:0];
      warning.warningId = warningId;
      
      NSDictionary *subWarningDict = [warningDict objectForKey:warningId];
      warning.priority = [subWarningDict objectForKey:@"priority"];
      warning.warningType = [subWarningDict objectForKey:@"warningType"];
      warning.customerId = [subWarningDict objectForKey:@"customerId"];
      warning.customerName = [subWarningDict objectForKey:@"customerName"];
      warning.isRead = [[subWarningDict objectForKey:@"read"] intValue];
    }
    [dataArray addObject:warning];
  }
  
  return dataArray;
}

@end

@implementation WarningDetail

+ (WarningDetail *)convertJSON2Objects:(NSString *)jsonString {
  NSDictionary *dict = [self covertJSON2Dict:jsonString];
  NSDictionary *data = [dict objectForKey:@"data"];
  WarningDetail *warningDetail = [[WarningDetail alloc] init];
  warningDetail.status = [dict objectForKey:@"status"];
  warningDetail.message = [dict objectForKey:@"message"];
  if (![warningDetail.status isEqualToString:@"success"]) return warningDetail;
  
  warningDetail.customerId = [data objectForKey:@"customerId"];
  warningDetail.customerName = [data objectForKey:@"customerName"];
  
  NSDictionary *generalInfoDict = [data objectForKey:@"generalInformation"];
  GeneralInfo *generalInfo = [[GeneralInfo alloc] init];
  generalInfo.priority = [generalInfoDict objectForKey:@"priority"];
  
  NSDictionary *matrixDict = [generalInfoDict objectForKey:@"matrix"];
  Matrix *matrix = [[Matrix alloc] init];
  matrix.locationArray = [matrixDict objectForKey:@"location"];
  matrix.valueArray = [matrixDict objectForKey:@"value"];
  matrix.xLabelArray = [matrixDict objectForKey:@"x"];
  matrix.yLabelArray = [matrixDict objectForKey:@"y"];
  
  generalInfo.matrix = matrix;
  warningDetail.generalInfo = generalInfo;
  warningDetail.warningId = [data objectForKey:@"id"];
  warningDetail.warningReason = [data objectForKey:@"reason"];
  
  return warningDetail;

}


@end

@implementation GeneralInfo

@end

@implementation Matrix

@end