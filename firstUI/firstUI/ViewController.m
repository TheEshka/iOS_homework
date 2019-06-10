//
//  ViewController.m
//  firstUI
//
//  Created by Тимур on 24/05/2019.
//  Copyright © 2019 Тимур. All rights reserved.
//

#import "ViewController.h"
#import "ABCPlatform.h"
#import "ABCColorControl.h"

const CGFloat viewSize = 20.f;

@interface ViewController ()

@property (weak, nonatomic) id<ABCDraggable> platform;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createABCView];
}


- (void) createABCView
{
    //create moving platform
    ABCPlatform *abcPlatform = [[ABCPlatform alloc] initWithFrame:CGRectMake(0, 0, viewSize, viewSize)];
    abcPlatform.center = self.view.center;
    [self.view addSubview: abcPlatform];
    self.platform = abcPlatform;
    
    //create change colour button
    ABCColorControl *abcColourController = [[ABCColorControl alloc] initWithFrame:CGRectMake(self.view.center.x-75, 50, 150, 30) withControlled:abcPlatform];
    [self.view addSubview:abcColourController];
}



//Methods for touches
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView: self.platform];
    if ([self.platform respondsToSelector:@selector(drag:)]) {
        [self.platform drag: touchPoint];
    }
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView: self.platform];
    if ([self.platform respondsToSelector:@selector(drag:)]) {
        [self.platform drag: touchPoint];
    }
}



//Print all coordinates and size
- (void) printAll: (UIView *) view{
    NSLog(@"FRAME %f, %f, %f, %f", view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    NSLog(@"BOUNDS %f, %f, %f, %f", view.bounds.origin.x, view.bounds.origin.y, view.bounds.size.width, view.bounds.size.height);
    NSLog(@"AFFIN %f, %f, %f, %f, %f, %f", view.transform.a, view.transform.b, view.transform.c, view.transform.d, view.transform.ty, view.transform.tx);
    NSLog(@"CENTER %f, %f \n\n\n", view.center.x, view.center.y);
}


@end
