//
//  FAPhotoViewController.m
//  FacebookAlbums
//
//  Created by Arnav Kumar on 2/2/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import "FAPhotoViewController.h"
#import "FAFacebookFetcher.h"

@interface FAPhotoViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FAPhotoViewController

@synthesize picture = _picture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) update
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("facebook refresh", NULL);
    dispatch_async(downloadQueue, ^{
        NSURL *url = [FAFacebookFetcher urlStringForPhotoWithID:[self.picture objectForKey:@"id"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL: url]];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self update];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView.image.size;
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
