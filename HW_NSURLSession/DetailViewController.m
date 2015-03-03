//
//  DetailViewController.m
//  HW_NSURLSession
//
//  Created by Евгений Сергеев on 27.02.15.
//  Copyright (c) 2015 Alexander. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    NSURLSession *backgroundSession;
    NSURLSessionDownloadTask *getImage;
}

@property (nonatomic, weak) IBOutlet UIImageView *detailImg;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadImage];
}


- (void)loadImage {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    backgroundSession = [NSURLSession sessionWithConfiguration:sessionConfig
                                                      delegate:self
                                                 delegateQueue:[NSOperationQueue mainQueue]];
    getImage = [backgroundSession downloadTaskWithURL:self.detailImageURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async (dispatch_get_main_queue(), ^{
            self.detailImg.image = downloadedImage;
        });
    }];
    [getImage resume];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
