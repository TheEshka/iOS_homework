//
//  HeaderView.m
//  AnimationLesson
//
//  Created by Kaplan Deniz on 05/06/2019.
//  Copyright © 2019 Kaplan Deniz. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@end



@implementation HeaderView

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		self.backgroundColor = UIColor.grayColor;
		[self setupUI];
	}
	return self;
}


- (void)setupUI
{
	self.imageView = [UIImageView new];
	self.imageView.image = [UIImage imageNamed:@"img"];
	self.imageView.layer.cornerRadius = 50.;
	self.imageView.contentMode = UIViewContentModeScaleAspectFill;
	self.imageView.clipsToBounds = YES;
	self.imageView.layer.borderWidth = 3.;
	self.imageView.layer.borderColor = UIColor.darkGrayColor.CGColor;
	[self addSubview:self.imageView];
	
	self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
	NSArray<NSLayoutConstraint *> *constraints =
  		@[
		  [self.imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
		  [self.imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
		  [self.imageView.widthAnchor constraintEqualToConstant:100.],
		  [self.imageView.heightAnchor constraintEqualToConstant:100.],
		  ];
	
	[NSLayoutConstraint activateConstraints:constraints];
}


@end
