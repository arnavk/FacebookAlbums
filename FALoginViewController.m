//
//  FALoginViewController.m
//  FacebookAlbums
//
//  Created by Arnav Kumar on 30/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import "FALoginViewController.h"
#import "FAAppDelegate.h"
#import "FAAlbumsTableViewController.h"
@interface FALoginViewController ()
- (IBAction)perfromLogin:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation FALoginViewController
@synthesize spinner = _spinner;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)perfromLogin:(id)sender {
    [self.spinner startAnimating];
    [self.delegate openSessionAndDismissViewController:self];
}

- (void)loginFailed
{
    // User switched back to the app without authorizing. Stay here, but
    // stop the spinner.
    [self.spinner stopAnimating];
}

@end
