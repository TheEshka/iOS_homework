//
//  MasterContainerButton.m
//  CustomContainerController
//
//  Created by Gagik on 17/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "MasterContainerButton.h"

@interface MasterContainerButton ()

@property (nonatomic, strong)UIViewController *targetViewController;

@end

@implementation MasterContainerButton

- (void)addTargerViewController:(UIViewController *) viewController
{
    self.targetViewController = viewController;
}

- (UIViewController *)targetViewController
{
    return _targetViewController;
}

@end
