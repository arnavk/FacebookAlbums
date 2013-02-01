//
//  FAAppDelegate.h
//  FacebookAlbums
//
//  Created by Arnav Kumar on 30/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAViewController.h"
#import "FAAlbumsTableViewController.h"
#import "FALoginViewController.h"

@interface FAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) FAAlbumsTableViewController *albumsTableViewController;
@property (strong, nonatomic) FAViewController *mainViewController;
//- (void)openSession;
@end
