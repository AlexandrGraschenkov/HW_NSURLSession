//
//  ViewController.m
//  HW_NSURLSession
//
//  Created by Alexander on 13.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImgView;

@end

@implementation ViewController
{
    NSURLSessionDataTask *dataTask;
    UIActivityIndicatorView *downloadingActivityIndicator;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"Say Hello");
    
    if (self.dict[@"cachedImg"]) {
        [self.bigImgView setImage:self.dict[@"cachedImg"]];
    } else {
        downloadingActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        downloadingActivityIndicator.center = self.view.center;
        downloadingActivityIndicator.hidesWhenStopped = YES;
        [self.view addSubview:downloadingActivityIndicator];
        [downloadingActivityIndicator startAnimating];
        NSURL *imgUrl = [NSURL URLWithString:self.dict[@"img"]];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        dataTask = [session dataTaskWithURL:imgUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage *img = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [downloadingActivityIndicator stopAnimating];
                [self.bigImgView setImage:img];
                [self.dict setObject:img forKey:@"cachedImg"];
                NSLog(@"state in code block: %ld",dataTask.state);
            });
        }];
        
        NSLog(@"state before resume: %ld",dataTask.state);
        [dataTask resume];
        
        NSLog(@"state after resume: %ld",dataTask.state);
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    if (dataTask.state == 0) {
        NSLog(@"dataTask is active, so we try to stop it");
        [dataTask suspend];
    }
    NSLog(@"state when disappear: %ld",dataTask.state);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
