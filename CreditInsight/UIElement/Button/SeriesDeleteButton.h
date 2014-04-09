//
//  SeriesDeleteButton.h
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 1/31/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Series;

@interface SeriesDeleteButton : UIButton

@property (retain, nonatomic) Series *seriesToDelete;
@property (retain, nonatomic) NSString *categoryName;
@property (assign, nonatomic) NSUInteger currentCategoryIndex;

@end
