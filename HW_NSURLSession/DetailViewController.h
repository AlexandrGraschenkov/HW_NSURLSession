//
//  DetailViewController.h
//  HW_NSURLSession
//
//  Created by Евгений Сергеев on 27.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppInfo.h"

@interface DetailViewController : UIViewController <NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURL *detailImageURL;
@property (nonatomic, strong) AppInfo *apInf;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *ActivityInd;
@property (nonatomic, weak) NSTimer *timer;

@end
