//
//  TableViewCell.h
//  HW_NSURLSession
//
//  Created by Daniil Novoselov on 24.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSURL *bigImgUrl;

-(void)setContentFromDictionary:(NSMutableDictionary*)dic;

@end
