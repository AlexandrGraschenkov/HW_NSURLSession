//
//  DetailFruitViewController.m
//  HW_NSURLSession
//
//  Created by Гена on 15.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "DetailFruitViewController.h"

@interface DetailFruitViewController () {
    NSURLSession *session;
    UIActivityIndicatorView *indicator;
}

@property (nonatomic, weak) IBOutlet UIImageView *detailImage;

@end

@implementation DetailFruitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    indicator.center = self.view.center;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [indicator startAnimating];
    [indicator setHidesWhenStopped:YES];
    [self.view addSubview:indicator];
    [[session dataTaskWithURL:self.detailImageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        UIImage *img = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [indicator stopAnimating];
            self.detailImage.image = img;
        });
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
