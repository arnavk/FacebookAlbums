//
//  FAAlbumCell.h
//  FacebookAlbums
//
//  Created by Arnav Kumar on 31/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAAlbumCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *albumImage;
@property (strong, nonatomic) IBOutlet UILabel *albumName;
@property (strong, nonatomic) IBOutlet UILabel *photoCount;

@end
