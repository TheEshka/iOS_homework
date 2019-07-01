//
//  Presenter.m
//  FlickerHomework
//
//  Created by Gagik on 30/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "Presenter.h"
#import "ViewControllerProtocol.h"

@interface Presenter ()

@end

@implementation Presenter

- (instancetype)initWithModel:(id<ModelInputProtocol>)model andViewController:(id<ViewControllerInputProtocol>)viewController
{
    self = [super init];
    if (self) {
        _model = model;
        _viewController = viewController;
    }
    return self;
}

#pragma mark - ModelOutputProtocol

- (void)startDownloadingCollectionView
{
    [self.viewController triggerCollectionView];
}

- (void)showDownloadedImageForIndexPathNumber:(NSInteger)num withData:(NSData *)data
{
    [self.viewController setDownloadedImageForIndexPathNumber:num withData:data];
}

#pragma mark - ViewControllerOutputProtocol

- (void)newSearch:(NSString *)searchedText {
    [self.model newSearchRequest:searchedText];
}

- (NSInteger)findCollectinViewCellsCount {
    return [self.model getSearchingResultCount];
}

- (void)openNextPage
{
    [self.model downloadNextPage];
}

- (NSData *)openPhotoForPathNumber:(NSInteger)num
{
    return [self.model photoForPathNumber:num];
}


@end
