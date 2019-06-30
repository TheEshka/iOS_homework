//
//  ViewControllerProtocol.h
//  FlickerHomework
//
//  Created by Gagik on 30/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewControllerOutputProtocol <NSObject>

- (void)newSearch:(NSString *)searchedText;
- (NSInteger)findCollectinViewCellsCount;
- (NSData *)openPhotoForPathNumber:(NSInteger)num;
- (void)openNextPage;

@end


@protocol ViewControllerInputProtocol <NSObject>

- (void)triggerCollectionView;
- (void)setDownloadedImageForIndexPathNumber:(NSInteger)num withData:(NSData *)data;

@end
