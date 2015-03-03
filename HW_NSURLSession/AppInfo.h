//
//  AppInfo.h
//  HW_NSURLSession
//
//  Created by Евгений Сергеев on 27.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

- (id)initWithDictionary:(NSDictionary *)dic;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *labelURL;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *detailImageURL;

@end
