//
//  NetworkServiceProtocol.h
//  FlickerHomework
//
//  Created by Gagik on 23/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

@protocol NetworkServiceOutputProtocol <NSObject>
@optional

- (void)loadingPhotoContinuesWithProgress:(double)progress;
- (void)loadingPhotoIsDoneWithData:(NSData *)data  forIndexPathNumber:(NSInteger)num;

- (void)searchingIsDoneWithResult:(NSDictionary *)searchResult;

@end

@protocol NetworkServiceIntputProtocol <NSObject>
@optional

- (void)configureUrlSessionWithParams:(NSDictionary *)params;

- (void)findFlickrPhotoWithSearchString:(NSString *)searcSrting;

- (void)downloadPhotoWithParams:(NSDictionary *)params forIndexPathNumber:(NSInteger) num;

@end




