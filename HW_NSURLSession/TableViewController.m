//
//  TableViewController.m
//  HW_NSURLSession
//
//  Created by Гена on 16.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "TableViewController.h"
#import "Fruit.h"
#import "FruitCell.h"
#import "DetailFruitViewController.h"

@interface TableViewController () {
    NSURLSession *session;
    NSArray *fruitArray;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    
    [self.refreshControl addTarget:self
                            action:@selector(loadDataFromNet)
                  forControlEvents:UIControlEventValueChanged];
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self loadDataFromNet];
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
            fruitArray = appArray;
            if (fruitArray.count > 0) self.tableView.backgroundView = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                [self.tableView reloadData];
                if (self.refreshControl) {
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"MMM d, h:mm a"];
                    NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
                    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor lightGrayColor]
                                                                                forKey:NSForegroundColorAttributeName];
                    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
                    self.refreshControl.attributedTitle = attributedTitle;
                    
                    [self.refreshControl endRefreshing];
                }
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
    return fruitArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (fruitArray) {
        return 1;
    } else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No data is currently available. Please pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Arial" size:20];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FruitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Fruit *fruit = fruitArray[indexPath.row];
    cell.title.text = fruit.title;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator setHidesWhenStopped:YES];
    indicator.center = cell.imgView.center;
    [cell.imgView addSubview: indicator];
    
    if (fruit.cachedImage) {
        if ([indicator isAnimating]) [indicator stopAnimating];
        cell.imgView.image = fruit.cachedImage;
    } else {
        [indicator startAnimating];
        [[session dataTaskWithURL:fruit.thumbURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage *img = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [indicator stopAnimating];
                fruit.cachedImage = img;
                cell.imgView.image = img;
            });
        }] resume];
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DetailFruitViewController *detail = [segue destinationViewController];
    Fruit *fruit = fruitArray[indexPath.row];
    detail.detailImageURL = fruit.imageURL;
    detail.fruit = fruit;
}

@end
