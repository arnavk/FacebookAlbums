//
//  FAFacebookFetcher.m
//  FacebookAlbums
//
//  Created by Arnav Kumar on 30/1/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import "FAFacebookFetcher.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation FAFacebookFetcher

+ (NSDictionary *)executeFacebookFetch:(NSString *)query
{
    NSString * accessToken = [[FBSession activeSession] accessToken];
    NSLog(@"In Fetch");
    query = [@"" stringByAppendingFormat:@"%@?access_token=%@", query, accessToken]; //https://graph.facebook.com/cec.ntu/albums
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    return results;
}  

+ (NSArray *) albums
{
    NSString *request = [NSString stringWithFormat:@"https://graph.facebook.com/cec.ntu/albums"];
    return [[self executeFacebookFetch:request] valueForKeyPath:@"data"];
             
}

//231073263619388

+ (NSURL *)urlStringForPhotoWithID:(NSString *)photoID
{
    NSString * accessToken = [[FBSession activeSession] accessToken];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?access_token=%@", photoID, accessToken]];
    return url;
}

+ (NSArray *) photosInAlbumWithAlbumID:(NSString *)albumID
{
    NSString *request = [NSString stringWithFormat:@"https://graph.facebook.com/%@/photos", albumID];
    return [[self executeFacebookFetch:request] valueForKeyPath:@"data"];
}

@end
