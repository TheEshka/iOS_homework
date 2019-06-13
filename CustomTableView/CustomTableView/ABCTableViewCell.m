//
//  ABCTableViewCell.m
//  CustomTableView
//
//  Created by Gagik on 12/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "ABCTableViewCell.h"

@interface ABCTableViewCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@end


@implementation ABCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //self.frame = CGRectZero;
        _coverImageView = [UIImageView new];
        
        _coverImageView.backgroundColor = [UIColor blueColor];
        //_coverImageView.image = [UIImage imageNamed:@"rocket"];
        [self.contentView addSubview:_coverImageView];
        
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor yellowColor];
        _titleLabel.numberOfLines = 1;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [UILabel new];
        _subtitleLabel.numberOfLines = 0;
        _subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _subtitleLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_subtitleLabel];
//
        
        
        _coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSArray<NSLayoutConstraint *> *constraints =
        @[
            [_coverImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10.f],
            [_coverImageView.topAnchor constraintEqualToAnchor:_titleLabel.topAnchor],
            [_coverImageView.heightAnchor constraintEqualToConstant:50.f],
            [_coverImageView.widthAnchor constraintEqualToConstant:50.f],

            [_titleLabel.leadingAnchor constraintEqualToAnchor:_coverImageView.trailingAnchor constant:10.f],
            [_titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10.f],
            [_titleLabel.heightAnchor constraintEqualToConstant:20.f],
            [_titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10.f],

            [_subtitleLabel.leadingAnchor constraintEqualToAnchor:_titleLabel.leadingAnchor],
            [_subtitleLabel.topAnchor constraintEqualToAnchor:_titleLabel.bottomAnchor constant:10.f],
            //[_subtitleLabel.heightAnchor constraintLessThanOrEqualToConstant:40.f],
            [_subtitleLabel.trailingAnchor constraintEqualToAnchor:_titleLabel.trailingAnchor],
            [_subtitleLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8.f]
            
        ];
        [NSLayoutConstraint activateConstraints:constraints];
        
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    self.coverImageView.image = image;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
