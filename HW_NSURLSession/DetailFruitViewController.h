//
//  DetailFruitViewController.h
//  HW_NSURLSession
//
//  Created by Гена on 15.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fruit.h"

@interface DetailFruitViewController : UIViewController

@property (nonatomic, strong) NSURL *detailImageURL;
@property (nonatomic, strong) Fruit *fruit;

@end
