//
//  MasterContainerButton.h
//  CustomContainerController
//
//  Created by Gagik on 17/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MasterContainerButton : UIButton

- (void)addTargerViewController:(UIViewController *) viewController;
- (UIViewController *)targetViewController;

@end

NS_ASSUME_NONNULL_END
