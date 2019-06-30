//
//  ViewController.h
//  FlickerHomework
//
//  Created by Gagik on 22/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerProtocol.h"


@interface ViewController : UIViewController <ViewControllerInputProtocol>

@property (nonatomic, strong) id<ViewControllerOutputProtocol> presenter;

@end

