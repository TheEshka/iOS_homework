//
//  SearchingModel.m
//  FlickerHomework
//
//  Created by Gagik on 24/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "SearchingModel.h"
#import "ViewController.h"
#import "PhotoDetails.h"
#import "NetworkService.h"
#import "NetworkServiceProtocol.h"

const NSString *searchesKey= @"allSearchesArray";

@interface SearchingModel ()<NetworkServiceOutputProtocol>

@property (nonatomic, strong)NetworkService *networkService;
@property (nonatomic, strong)NSMutableArray<PhotoDetails *> *allPhotosParams;
@property (nonatomic, strong)NSMutableDictionary<NSString *,NSData * > *allPhotos;

@property (nonatomic, strong)NSString *currentSearchText;
@property (nonatomic, assign)NSInteger currentPage;

@end

@implementation SearchingModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _allPhotos = [[NSMutableDictionary alloc] init];
        _allPhotosParams = [[NSMutableArray alloc] init];
        
        _networkService = [NetworkService new];
        _networkService.output = self;
        //self.changeDelegate = presenter;
        [_networkService configureUrlSessionWithParams:@{ @"Accept" : @"application/json" }];
    }
    return self;
}




- (NSInteger)getSearchingResultCount
{
    if (self.allPhotosParams)
    {
        return [self.allPhotosParams count];
    }
    return 0;
}

- (NSData *)photoForPathNumber:(NSInteger)num
{
    NSString *key = [NSString stringWithFormat:@"%ld",num];
    NSData *data =[self.allPhotos valueForKey:key];
    if (!data)
    {
        NSLog(@"moooooodel go to download %@", key);
        [self.networkService downloadPhotoWithParams:self.allPhotosParams[num] forIndexPathNumber:num];
        //[self.allPhotos setObject:[NSNull null] forKey:key];
        return nil;
    }
    if ([data isMemberOfClass:[NSNull class]])
    {
        NSLog(@"moooooodel already downloading %@", key);
        return nil;
    }
    NSLog(@"moooooodel return imediatly %@", key);
    return [self.allPhotos valueForKey:key];
}

- (void)newSearchRequest:(NSString *)searchedText
{
    //вставить проверку не было ли уже такого запроса
    self.currentSearchText = searchedText;
    self.currentPage = 1;
    
    [self.allPhotos removeAllObjects];
    [self.allPhotosParams removeAllObjects];
    [self.networkService findFlickrPhotoWithSearchString:searchedText forPage:self.currentPage];
}

- (void)downloadNextPage
{
    self.currentPage++;
    [self.networkService findFlickrPhotoWithSearchString:self.currentSearchText forPage:self.currentPage];
}




#pragma mark - NetworkServiceOutput

- (void)searchingIsDoneWithResult:(NSDictionary *)searchResult
{
    NSArray *photosArray = [searchResult valueForKeyPath:@"photos.photo"];
    for (NSDictionary *photo in photosArray)
    {
        [self.allPhotosParams addObject:[[PhotoDetails alloc] initWithDictionary:photo]];
    }
    [self.changeDelegate startDownloadingCollectionView];
}

- (void)loadingPhotoIsDoneWithData:(NSData *)data  forIndexPathNumber:(NSInteger)num
{
    [self.allPhotos setObject:data forKey:[NSString stringWithFormat:@"%ld",num]];
    [self.changeDelegate showDownloadedImageForIndexPathNumber:num withData:data];
}

- (void)loadingPhotoContinuesWithProgress:(double)progress
{
    //передать действие ячейки для отображения загрузки
}


@end
