//
//  TwitterClient.h
//  twitter
//
//  Created by Sameer Shah on 2/4/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openUrl:(NSURL *)url;
- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)updateStatus:(NSString *)status completion:(void (^)(NSDictionary *response , NSError *error))completion;
- (void)retweetForId:(NSInteger)Id completion:(void (^)(NSDictionary *response , NSError *error))completion;
- (void)favoriteForId:(NSInteger)Id completion:(void (^)(NSDictionary *response , NSError *error))completion;
- (void)userTimelineWithParams:(NSString *)screenName completion:(void (^)(NSArray *tweets, NSError *error))completion;

@end
