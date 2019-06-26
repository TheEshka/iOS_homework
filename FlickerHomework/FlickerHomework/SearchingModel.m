//
//  SearchingModel.m
//  FlickerHomework
//
//  Created by Gagik on 24/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "SearchingModel.h"
#import "NetworkService.h"
#import "NetworkServiceProtocol.h"

@interface SearchingModel ()<NetworkServiceOutputProtocol>

@property (nonatomic, strong)NetworkService *networkService;
@property (nonatomic, strong)NSDictionary *currentDic; ////
@property (nonatomic, strong)NSMutableArray *allPhotosParams;
@property (nonatomic, strong)NSMutableDictionary<NSString *,NSData * > *allPhotos;

@end

@implementation SearchingModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allPhotos = [[NSMutableDictionary alloc] init];
        self.allPhotosParams = [[NSMutableArray alloc] init];
        
        self.networkService = [NetworkService new];
        self.networkService.output = self;
        [self.networkService configureUrlSessionWithParams:@{ @"Accept" : @"application/json" }];
    }
    return self;
}


-(NSInteger)getSearchingResultCount
{
    if (self.currentDic)
    {
        NSInteger page = [(NSNumber *)[self.currentDic valueForKeyPath:@"photos.page"] integerValue];
        NSInteger perpage = [(NSNumber *)[self.currentDic valueForKeyPath:@"photos.perpage"] integerValue];
        NSInteger curPage = [(NSArray *)[self.currentDic valueForKeyPath:@"photos.photo"] count];
        return (page - 1) * perpage + curPage;
    }
    return 0;
}

-(NSData *)getPhotoForPathNumber:(NSInteger)num
{
    NSString *key = [NSString stringWithFormat:@"%ld",num];
    NSData *data =[self.allPhotos valueForKey:key];
    if (!data)
    {
        NSLog(@"moooooodel go to download %@", key);
        NSArray *params = [self.currentDic valueForKeyPath:[NSString stringWithFormat:@"photos.photo"]];
        [self.networkService downloadPhotoWithParams:params[num] forIndexPathNumber:num];
        [self.allPhotos setObject:[NSNull null] forKey:key];
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

-(void)newSearch:(NSString *)searchedText
{
    //проверка не было ли уже такого запроса
    [self.allPhotos removeAllObjects];
    [self.networkService findFlickrPhotoWithSearchString:searchedText];
}


#pragma mark - NetworkServiceOutput

- (void)searchingIsDoneWithResult:(NSDictionary *)searchResult
{
    self.currentDic = searchResult;
    [self.changeDelegate startDownloadingCollectionView];
}

- (void)loadingPhotoIsDoneWithData:(NSData *)data  forIndexPathNumber:(NSInteger)num
{
    [self.allPhotos setObject:data forKey:[NSString stringWithFormat:@"%ld",num]];
    [self.changeDelegate setDownloadedImageForIndexPathNumber:num withData:data];
}

- (void)loadingPhotoContinuesWithProgress:(double)progress
{
    //передать действие ячейки для отображения загрузки
}


@end
