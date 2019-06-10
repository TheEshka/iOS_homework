//
//  ABCColorControl.m
//  firstUI
//
//  Created by Тимур on 25/05/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

#import "ABCColorControl.h"
#import "ABCPlatform.h"

@implementation ABCColorControl

//конструктор, сразу задающий делегат
- (instancetype)initWithFrame:(CGRect)frame withControlled: (id<ABCColourful>) controlled
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor greenColor];
        self.controlled = controlled;
    }
    return self;
}


-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.controlled respondsToSelector:@selector(changeColour)]) {
        [self.controlled changeColour];
    }
}

//Для перехвата касаний приходящихся на кнопку, чтобы не не двигалась платформа
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}
-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

@end
