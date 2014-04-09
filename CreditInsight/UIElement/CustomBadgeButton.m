//
//  CustomBadgeButton.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 12/27/12.
//  Copyright (c) 2012 wang liang. All rights reserved.
//

#import "CustomBadgeButton.h"
#import "QuartzCore/QuartzCore.h"

@implementation CustomBadgeButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CustomBadgeButton" owner:self options:nil];
        
        if (nibs) {
            self = [nibs objectAtIndex:0];
            [self initControls];
        }
    }
    
    return self;
}

- (void)initControls {
    self.badgeImgBkg.layer.borderWidth = 1.0;
    self.badgeImgBkg.layer.borderColor = [UIColor whiteColor].CGColor;
    self.badgeImgBkg.layer.cornerRadius = 8;
    self.btnWorkItem.backgroundColor = [UIColor darkGrayColor];

}

@end
