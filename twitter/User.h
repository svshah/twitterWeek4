//
//  User.h
//  twitter
//
//  Created by Sameer Shah on 2/7/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagLine;
@property (nonatomic, assign) NSInteger noOfTweets;
@property (nonatomic, assign) NSInteger noOfFollowing;
@property (nonatomic, assign) NSInteger noOfFollowers;

- (id) initWithDictionary:(NSDictionary *)dictionary;
+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;
+ (void)logout;
@end
