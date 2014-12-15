//
//  Fruit.h
//  HW_NSURLSession
//
//  Created by Гена on 15.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fruit : NSObject

- (id)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *thumbURL;
@property (nonatomic, strong) NSURL *imageURL;

@end
