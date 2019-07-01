//
//  ModelProtocol.h
//  FlickerHomework
//
//  Created by Gagik on 24/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ModelOutputProtocol <NSObject>
@optional

- (void)startDownloadingCollectionView;
- (void)showDownloadedImageForIndexPathNumber:(NSInteger)num withData:(NSData *)data;

@end

@protocol ModelInputProtocol <NSObject>
@optional

- (NSInteger)getSearchingResultCount;
- (NSData *)photoForPathNumber:(NSInteger)num;
- (void)newSearchRequest:(NSString *)searchedText;
- (void)downloadNextPage;

@end
