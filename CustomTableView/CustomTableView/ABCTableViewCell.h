//
//  ABCTableViewCell.h
//  CustomTableView
//
//  Created by Gagik on 12/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABCTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
