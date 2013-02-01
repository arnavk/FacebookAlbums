//
//  FAFacebookFetcher.h
//  FacebookAlbums
//
//  Created by Arnav Kumar on 30/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FACEBOOK_ALBUM_TITLE @"name"
#define FACEBOOK_ALBUM_PHOTOS_COUNT @"count"
#define FACEBOOK_ALBUM_COVER_PHOTO @"cover_photo"
#define FACEBOOK_ALBUM_ID @"id"

@interface FAFacebookFetcher : NSObject
+ (NSDictionary *)executeFacebookFetch:(NSString *)query;
+ (NSArray *) albums;
+ (NSURL *)urlStringForPhotoWithID:(NSString *)photoID;
+ (NSArray *) photosInAlbumWithAlbumID:(NSString *)albumID;
@end
