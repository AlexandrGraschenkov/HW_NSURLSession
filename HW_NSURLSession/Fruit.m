//
//  Fruit.m
//  HW_NSURLSession
//
//  Created by Гена on 15.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "Fruit.h"

@implementation Fruit

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.thumbURL = [NSURL URLWithString:dict[@"thumb"]];
        self.imageURL = [NSURL URLWithString:dict[@"img"]];
    }
    return self; 
}

@end
