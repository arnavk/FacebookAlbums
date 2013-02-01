//
//  FAAlbumCell.m
//  FacebookAlbums
//
//  Created by Arnav Kumar on 31/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import "FAAlbumCell.h"

@implementation FAAlbumCell

@synthesize photoCount = _photoCount;
@synthesize albumImage = _albumImage;
@synthesize albumName = _albumName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
