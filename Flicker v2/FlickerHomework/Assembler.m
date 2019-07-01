//
//  Assembler.m
//  FlickerHomework
//
//  Created by Gagik on 30/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "Assembler.h"
#import "Presenter.h"
#import "SearchingModel.h"
#import "ViewController.h"
#import "ModelProtocol.h"

@implementation Assembler

+ (void)configureArchitectureForViewController:(ViewController *)viewController
{
    SearchingModel *searchingModel = [[SearchingModel alloc] init];
    Presenter *presenter = [[Presenter alloc] initWithModel:searchingModel andViewController:viewController];
    searchingModel.changeDelegate = presenter;
    viewController.presenter = presenter;
}

@end
