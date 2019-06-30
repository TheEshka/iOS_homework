//
//  Presenter.h
//  FlickerHomework
//
//  Created by Gagik on 30/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelProtocol.h"
#import "ViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Presenter : NSObject<ModelOutputProtocol, ViewControllerOutputProtocol>

@property (nonatomic, strong)id<ModelInputProtocol> model;
@property (nonatomic, weak)id<ViewControllerInputProtocol> viewController;

- (instancetype)initWithModel:(id<ModelInputProtocol>)model andViewController:(id<ViewControllerInputProtocol>)viewController;

@end

NS_ASSUME_NONNULL_END
