//
//  NetworkService.m
//  FlickerHomework
//
//  Created by Gagik on 23/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "NetworkService.h"
#import "NetworkHelper.h"

@class PhotoDetails;

@interface NetworkService ()

@property (nonatomic, strong) NSURLSession *urlSession;


@end

@implementation NetworkService


#pragma mark NetworkServiceIntputProtocol

- (void)configureUrlSessionWithParams:(NSDictionary *)params
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setAllowsCellularAccess:YES];
    [sessionConfiguration setHTTPAdditionalHeaders:params];
    self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
}


- (void)findFlickrPhotoWithSearchString:(NSString *)searchSrting forPage:(NSInteger) page
{
    NSString *urlString = [NetworkHelper URLForSearchString:searchSrting withPage:page];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; //не обязательно, пример настройки URLRequest
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15]; // если не успеет скачать didFinish (в случае с DataTask NSЕrror)
    
    
    NSURLSessionDataTask *sessionDataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.output searchingIsDoneWithResult:temp];
        });
    }];
    [sessionDataTask resume];
}



- (void)downloadPhotoWithParams:(PhotoDetails *)params forIndexPathNumber:(NSInteger) num
{
    NSURL *url = [NSURL URLWithString: [NetworkHelper URLForGettingPhoto:params]];
    NSURLSessionDownloadTask *sessionDownloadTask = [self.urlSession downloadTaskWithURL:url];
    sessionDownloadTask.taskDescription = [NSString stringWithFormat:(@"%ld"), num];
    [sessionDownloadTask resume];
}


#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSData *data = [NSData dataWithContentsOfURL:location];
    NSInteger num = [downloadTask.taskDescription intValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.output loadingPhotoIsDoneWithData:data  forIndexPathNumber:num];
    });
    //хз надо ли делать инфалидной, но тогда сессия закрывается
    //[session finishTasksAndInvalidate];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        //заготовка для щагрузки каждой картинки отдельно
        //[self.output loadingPhotoContinuesWithProgress:progress];
    });
}

@end
