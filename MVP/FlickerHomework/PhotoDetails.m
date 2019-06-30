//
//  PhotoDetails.m
//  FlickerHomework
//
//  Created by Gagik on 26/06/2019.
//  Copyright © 2019 Gagik Avetisyan. All rights reserved.
//

#import "PhotoDetails.h"

@implementation PhotoDetails

- (instancetype)initWithDictionary:(NSDictionary *)params
{
    self = [super init];
    if (self) {
        self.owner = [params valueForKey:@"owner"];
        self.secret = [params valueForKey:@"secret"];
        self.server = [params valueForKey:@"server"];
        self.idNumber = [params valueForKey:@"id"];
        self.farm = [[params valueForKey:@"farm"] integerValue];
        self.title = [params valueForKey:@"title"];
        self.isFriend = [[params valueForKey:@"isfriend"] integerValue];
        self.isFamily = [[params valueForKey:@"isfamily"] integerValue];
        self.isPublic = [[params valueForKey:@"ispublic"] integerValue];
    }
    return self;
}

@end
