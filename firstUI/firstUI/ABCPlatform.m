//
//  ABCView.m
//  firstUI
//
//  Created by Тимур on 24/05/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

#import "ABCPlatform.h"
#import "ViewController.h"

@implementation ABCPlatform

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)drag: (CGPoint) point
{
    CGRect frame = self.frame;
    frame.origin.x += point.x - self.bounds.size.width/2;
    //frame.origin.y += point.y - self.bounds.size.width/2;;
    self.frame = frame;
}

- (void) changeColour
{
    int i = arc4random() % 5;
    switch (i) {
        case 0:
            self.backgroundColor = [UIColor blueColor];
            break;
        case 1:
            self.backgroundColor = [UIColor yellowColor];
            break;
        case 2:
            self.backgroundColor = [UIColor redColor];
            break;
        case 3:
            self.backgroundColor = [UIColor orangeColor];
            break;
        case 4:
            self.backgroundColor = [UIColor brownColor];
            break;
    }
}

@end
