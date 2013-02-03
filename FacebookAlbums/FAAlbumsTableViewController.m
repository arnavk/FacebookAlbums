//
//  FAAlbumsTableViewController.m
//  FacebookAlbums
//
//  Created by Arnav Kumar on 30/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import "FAAlbumsTableViewController.h"
#import "FAViewController.h"
#import "FALoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FAFacebookFetcher.h"
#import "FAAlbumCell.h"
#import "FAAlbumPhotosCollectionViewController.h"

@interface FAAlbumsTableViewController () <LoginViewControllerDelegate>

@property (nonatomic, strong) NSArray *albums;

@end

@implementation FAAlbumsTableViewController

@synthesize albums = _albums;

- (void) setAlbums:(NSArray *)albums
{
    if (_albums != albums)
    {
        _albums = albums;
        [self.tableView reloadData];
    }
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)pull:(id)sender
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("facebook downloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *albums = [FAFacebookFetcher albums];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem = sender;
            self.albums = albums;
        });
    });
    
}

- (void) updateList
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("facebook refresh", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *albums = [FAFacebookFetcher albums];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.albums = albums;
            for (NSDictionary *album in self.albums)
            {
                NSLog(@"%@", [album objectForKey:FACEBOOK_ALBUM_TITLE]);
            }
        });
    });
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSDictionary *album = [self.albums objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    [segue.destinationViewController setAlbum:album];
    [segue.destinationViewController setTitle:[[sender albumName] text]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Yes, so just open the session (this won't display any UX).
        [self openSessionAndDismissViewController:nil];
    } else {
        // No, display the login page.
        [self showLoginView];
    }
    [self updateList];
    //[self showLoginView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)showLoginView
{
    NSLog(@"In showLoginView of TVC");
    
    FALoginViewController* loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    loginViewController.delegate = self;
    [self presentViewController:loginViewController animated:NO completion:nil];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
             loginViewController: (UIViewController *) topViewController

{
    NSLog(@"Session state changed");
    switch (state) {
        case FBSessionStateOpen: {
            if ([ topViewController isKindOfClass:[FALoginViewController class]]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSessionAndDismissViewController:(FALoginViewController *)fblvc
{
    NSLog(@"In the table view controller waiting to dismiss");
    NSArray *permissions = [NSArray arrayWithObjects:@"publish_actions", nil];
//    [FBSession openActiveSessionWithPublishPermissions:permissions
//                                       defaultAudience:FBSessionDefaultAudienceFriends
//                                          allowLoginUI:YES
//                                     completionHandler:
//     ^(FBSession *session,                                                                                                                                                        FBSessionState state, NSError *error) {
//        [self sessionStateChanged:session state:state error:error loginViewController:fblvc];
//    }];
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error loginViewController:fblvc];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%d", self.albums.count);

    return self.albums.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"album cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    FAAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    NSDictionary *album = [[self albums] objectAtIndex:indexPath.row];
    NSString *name = [album objectForKey:FACEBOOK_ALBUM_TITLE];
    NSString *count = [album objectForKey:FACEBOOK_ALBUM_PHOTOS_COUNT];
    NSString *coverPhoto = [album objectForKey:FACEBOOK_ALBUM_COVER_PHOTO];
    cell.albumName.text = name;
    cell.photoCount.text = [NSString stringWithFormat:@"%@ photos", count];
    cell.albumImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[FAFacebookFetcher urlStringForPhotoWithID:coverPhoto]]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end
