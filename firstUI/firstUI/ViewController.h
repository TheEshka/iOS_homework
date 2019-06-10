//
//  ViewController.h
//  firstUI
//
//  Created by Тимур on 24/05/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ABCDraggable <NSObject>

- (void)drag: (CGPoint) point;

@end

@interface ViewController : UIViewController

@end

