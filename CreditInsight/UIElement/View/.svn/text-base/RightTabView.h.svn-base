//
//  RightTabView.h
//  CreditInsight
//
//  Created by Wang, William (external - Partner) on 1/11/13.
//  Copyright (c) 2013 wang liang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RightTabViewDelegate <NSObject>

@required
- (void)onClickTabButtonWithTag:(NSInteger)tag;

@end


@interface RightTabView : UIView

@property (assign, nonatomic) id<RightTabViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIImageView *activieImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblFirst;
@property (weak, nonatomic) IBOutlet UILabel *lblSecond;
@property (weak, nonatomic) IBOutlet UILabel *lblThird;

- (void)setActiveButtonLocation:(NSInteger)tag;
- (void)setButtonEnableWithCurrentButtonTag:(NSInteger)tag;

@end
