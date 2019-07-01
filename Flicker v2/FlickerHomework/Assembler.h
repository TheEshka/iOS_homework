//
//  Assembler.h
//  FlickerHomework
//
//  Created by Gagik on 30/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Assembler : NSObject

+ (void)configureArchitectureForViewController:(id<ViewControllerInputProtocol>)viewController;

@end

NS_ASSUME_NONNULL_END
