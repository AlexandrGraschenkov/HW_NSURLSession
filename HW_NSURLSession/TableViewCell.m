//
//  TableViewCell.m
//  HW_NSURLSession
//
//  Created by Daniil Novoselov on 24.12.14.
//  Copyright (c) 2014 Alexander. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
{
    UIImage *cachedImage;
    NSMutableDictionary *currDic;
}
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

-(void)setContentFromDictionary:(NSMutableDictionary*)dic
{
    currDic = dic;
    self.label.text = dic[@"title"];
    
    if (dic[@"cached"]) {
        self.img.image = dic[@"cachedThumb"];
    } else {
        NSURL *url = [NSURL URLWithString:dic[@"thumb"]];
        NSURLSession *imgDownload = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        self.img.image = nil;
        [[imgDownload dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            UIImage *urlImg = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([currDic[@"thumb"] isEqual:dic[@"thumb"]]) {
                    [self.img setImage:urlImg];
                    currDic[@"cachedThumb"] = urlImg;
                }
            });
        }] resume];
    }
}

@end
