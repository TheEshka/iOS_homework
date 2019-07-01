//
//  SearchingViewCell.m
//  FlickerHomework
//
//  Created by Gagik on 23/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "SearchingViewCell.h"
#import "NetworkService.h"
#import "NetworkHelper.h"
#import "NetworkServiceProtocol.h"

@interface SearchingViewCell ()<NetworkServiceOutputProtocol>

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation SearchingViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
        
        self.layer.borderWidth = 3.f;
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
    return self;
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
}

//- (void)loadingPhotoContinuesWithProgress:(double)progress
//{
//    
//}
//
//- (void)loadingPhotoIsDoneWithData:(NSData *)data
//{
//    self.imageView.image = [UIImage imageWithData:data];
//}


- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}


@end
