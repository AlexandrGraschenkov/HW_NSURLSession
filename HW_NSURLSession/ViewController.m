//
//  ViewController.m
//  HW_NSURLSession
//
//  Created by Alexander on 13.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "Fruit.h"
#import "FruitCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSURLSession *session;
    NSArray *objectArray;
}

@property (nonatomic, weak) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/Fructs.json"];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSURLSessionDataTask *task = [session dataTaskWithURL:url];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadDataFromNet];
}

- (void)loadDataFromNet
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/Fructs.json"];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error, cant load data from net: %@", error.description);
        } else {
            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *appArray = [NSMutableArray new];
            for (NSDictionary *dict in arr) {
                [appArray addObject:[[Fruit alloc] initWithDictionary:dict]];
            }
            objectArray = appArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        }
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return objectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FruitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Fruit *fruit = objectArray[indexPath.row];
    cell.title.text = fruit.title;
    [[session dataTaskWithURL:fruit.thumbURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        UIImage *img = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgView.image = img;
        });
    }] resume];
    return cell;
}

@end
