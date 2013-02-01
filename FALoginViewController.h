//
//  FALoginViewController.h
//  FacebookAlbums
//
//  Created by Arnav Kumar on 30/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FALoginViewController;
@protocol LoginViewControllerDelegate <NSObject>

-(void)openSessionAndDismissViewController:(FALoginViewController *)fblvc;

@end

@interface FALoginViewController : UIViewController
@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;
- (void)loginFailed;
@end
