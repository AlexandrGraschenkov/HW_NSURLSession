//
//  AppInfo.m
//  HW_NSURLSession
//
//  Created by Евгений Сергеев on 27.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.labelURL = [NSURL URLWithString:dic[@"title"]];
        self.imageURL = [NSURL URLWithString:dic[@"img"]];
        self.detailImageURL = [NSURL URLWithString:dic[@"thumb"]];
    }
    return self;
}

@end
