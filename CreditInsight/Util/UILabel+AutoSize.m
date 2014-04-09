//
//  UILabel+AutoSize.m
//  CreditInsight
//
//  Created by Zhou, Megan (external - Partner) on 2/28/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import "UILabel+AutoSize.h"

@implementation UILabel (AutoSize)

+ (UILabel *)autoSizeLabel:(NSString *)message font:(UIFont *)font color:(UIColor *)color defaultMixWidth:(CGFloat)defaultMixWidth {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];  
  CGSize size = CGSizeMake(600, 30);
  CGSize labelSize = [message sizeWithFont:font constrainedToSize:size];  
  CGFloat width = labelSize.width > defaultMixWidth ? labelSize.width : defaultMixWidth;
  
  label.frame = CGRectMake(0, 0, width, 30);
  label.textColor = color;
  label.text = message;
  label.font = font;
  label.backgroundColor = [UIColor clearColor];
  
  return label;
}

@end
