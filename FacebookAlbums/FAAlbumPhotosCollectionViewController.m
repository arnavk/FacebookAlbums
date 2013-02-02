//
//  FAAlbumPhotosCollectionViewController.m
//  FacebookAlbums
//
//  Created by Arnav Kumar on 31/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import "FAAlbumPhotosCollectionViewController.h"
#import "FAPhotoCollectionViewCell.h"
#import "FAFacebookFetcher.h"
#import "FAPhotoViewController.h"

@interface FAAlbumPhotosCollectionViewController ()
@property (nonatomic, strong) NSArray *photos;
@end

@implementation FAAlbumPhotosCollectionViewController

@synthesize album = _album;
@synthesize photos = _photos;

- (void) setPhotos:(NSArray *)photos {
    if (_photos != photos)
    {
        _photos = photos;
        [self.collectionView reloadData];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) updateList
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("facebook refresh", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *photos = [FAFacebookFetcher photosInAlbumWithAlbumID:[self.album valueForKey:FACEBOOK_ALBUM_ID]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photos = photos;
            for (NSDictionary *photo in self.photos)
            {
                NSLog(@"Fetched");
            }
        });
    });
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
    NSDictionary *photo = [self.photos objectAtIndex:selectedIndexPath.row];
    [segue.destinationViewController setPicture:photo];
    [segue.destinationViewController setTitle:@"Photo"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self updateList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FAPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    NSURL *photoURL = [NSURL URLWithString:[[[photo valueForKeyPath:@"images"] objectAtIndex:4] valueForKey:@"source"]];
    cell.photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:photoURL]];
    
    return cell;
}

@end
