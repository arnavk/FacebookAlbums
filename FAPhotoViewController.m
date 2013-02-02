//
//  FAPhotoViewController.m
//  FacebookAlbums
//
//  Created by Arnav Kumar on 2/2/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import "FAPhotoViewController.h"

@interface FAPhotoViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
