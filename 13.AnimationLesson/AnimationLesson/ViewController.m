//
//  ViewController.m
//  AnimationLesson
//
//  Created by Kaplan Deniz on 05/06/2019.
//  Copyright © 2019 Kaplan Deniz. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

@interface ViewController () <UIScrollViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) HeaderView *header;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *button;

@end


@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.bottomView = [UITableView new];
//    self.bottomView.delegate = self;
	[self.view addSubview:self.bottomView];
	
	self.header = [HeaderView new];
	[self.view addSubview:self.header];
	
    
    UIButton *button = [UIButton new];
    [button setTitle:@"Action" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonDidTap) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.button = button;
    
    
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
	self.header.translatesAutoresizingMaskIntoConstraints = NO;
	self.bottomView.translatesAutoresizingMaskIntoConstraints = NO;
	
	NSArray<NSLayoutConstraint *> *constraints =
		@[
		  [self.header.topAnchor constraintEqualToAnchor:self.view.topAnchor],
		  [self.header.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		  [self.header.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
		  [self.header.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor],
		  
		  [self.bottomView.topAnchor constraintEqualToAnchor:self.header.bottomAnchor],
		  [self.bottomView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
		  [self.bottomView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		  [self.bottomView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
          
          [self.button.centerXAnchor constraintEqualToAnchor:self.bottomView.centerXAnchor],
          [self.button.centerYAnchor constraintEqualToAnchor:self.bottomView.centerYAnchor],
          [self.button.widthAnchor constraintEqualToConstant:100.],
		  ];
	
	[NSLayoutConstraint activateConstraints:constraints];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}


// вторая анимация: пульсирование
-(void)buttonDidTap:(UIButton*) button
{
    CABasicAnimation *pulsingAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulsingAnimation.autoreverses = YES;
    pulsingAnimation.duration = 1.f;
    pulsingAnimation.repeatCount = INFINITY;
    pulsingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulsingAnimation.fillMode = kCAFillModeForwards;
    pulsingAnimation.fromValue =  @(1.);
    pulsingAnimation.toValue = @(1.5);
    pulsingAnimation.removedOnCompletion = NO;

    const CGFloat layerSize = 100.f;
    CALayer *roundLayer = [CALayer new];
    roundLayer.frame = CGRectMake((self.header.frame.size.width-layerSize)/2.f, (self.header.frame.size.height-layerSize)/2.f, layerSize, layerSize);
    roundLayer.contentsCenter = self.header.frame;
    roundLayer.cornerRadius = 50.;
    roundLayer.backgroundColor = UIColor.blackColor.CGColor;
    roundLayer.opacity = 0.7;

    [self.header.layer insertSublayer:roundLayer atIndex:0];
    [roundLayer addAnimation:pulsingAnimation forKey:@"pulsing"];

}

@end
