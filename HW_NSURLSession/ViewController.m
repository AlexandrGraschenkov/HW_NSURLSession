//
//  ViewController.m
//  HW_NSURLSession
//
//  Created by Alexander on 13.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppCell.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSURLSession *session;
    NSArray *presentTableArr;
}
@property (nonatomic, weak) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imgView];
    
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadDataFromNet];
}

- (void)reloadDataFromNet
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/Fructs.json"];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *appArr = [NSMutableArray new];
            for (NSDictionary *dic in arr) {
                [appArr addObject:[[AppInfo alloc] initWithDictionary:dic]];
            }
            presentTableArr = appArr;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        }
    }] resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return presentTableArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    AppInfo *info = presentTableArr[indexPath.row];
    
    cell.lab.text = info.title;
    [[session dataTaskWithURL:info.imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        UIImage *img = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgView.image = img;
        });
    }] resume];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
    DetailViewController *detail = [segue destinationViewController];
    AppInfo *api = presentTableArr[indexPath.row];
    detail.detailImageURL = api.imageURL;
    detail.apInf = api;
}


@end
