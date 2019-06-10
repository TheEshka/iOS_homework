//
//  ABCColorControl.h
//  firstUI
//
//  Created by Тимур on 25/05/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ABCColourful <NSObject>

- (void)changeColour;

@end



@interface ABCColorControl : UIView

@property (weak, nonatomic) id<ABCColourful> controlled;

- (instancetype)initWithFrame:(CGRect)frame withControlled: (id<ABCColourful>) controlled;

@end

NS_ASSUME_NONNULL_END
