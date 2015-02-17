//
//  TweetCell.m
//  twitter
//
//  Created by Sameer Shah on 2/8/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "TTTTimeIntervalFormatter.h"
#import "ComposeViewController.h"
#import "TwitterClient.h"
#import "ProfileViewController.h"

@interface TweetCell()

@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *twitterHandleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (strong, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (strong, nonatomic) IBOutlet UIImageView *favoriteImageView;
@property (strong, nonatomic) IBOutlet UIImageView *replyImageView;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width;
    self.profileImageView.layer.cornerRadius = 3;
    self.profileImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width;
}

- (void)setTweet:(Tweets *)tweet {
    _tweet = tweet;
    
    self.tweetTextLabel.text = self.tweet.text;
    self.usernameLabel.text = self.tweet.user.name;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    
    [self.profileImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *profileTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileImageClick)];
    [profileTap setNumberOfTapsRequired:1];
    [self.profileImageView addGestureRecognizer:profileTap];
    
    self.twitterHandleLabel.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    NSTimeInterval timeInterval = [self.tweet.createdAt timeIntervalSinceNow];
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    [timeIntervalFormatter usesAbbreviatedCalendarUnits];
    [timeIntervalFormatter setPastDeicticExpression:nil];
    [timeIntervalFormatter setPresentDeicticExpression:nil];
    [timeIntervalFormatter setFutureDeicticExpression:nil];
    [timeIntervalFormatter setUsesAbbreviatedCalendarUnits:YES];
    [timeIntervalFormatter setSuffixExpressionFormat:NSLocalizedStringWithDefaultValue(@"Suffix Expression Format String", @"FormatterKit", [NSBundle mainBundle], @"%@%@", @"Suffix Expression Format (#{Time}#{unit})")];
    self.timeLabel.text = [timeIntervalFormatter stringForTimeInterval:-timeInterval];
    //NSLog(@"\n----\ntweet: %@",self.tweet.text);
    
    
    [self.replyImageView setImageWithURL:[NSURL URLWithString:@"https://g.twimg.com/dev/documentation/image/reply.png"]];
    [self.replyImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *replyTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onReplyClick)];
    [replyTap setNumberOfTapsRequired:1];
    [self.replyImageView addGestureRecognizer:replyTap];
    
    [self.favoriteImageView setImageWithURL:[NSURL URLWithString:@"https://g.twimg.com/dev/documentation/image/favorite.png"]];
    [self.favoriteImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onFavoriteClick)];
    [singleTap setNumberOfTapsRequired:1];
    [self.favoriteImageView addGestureRecognizer:singleTap];
    
    [self.retweetImageView setImageWithURL:[NSURL URLWithString:@"https://g.twimg.com/dev/documentation/image/retweet.png"]];
    [self.retweetImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *retweetTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRetweetClick)];
    [retweetTap setNumberOfTapsRequired:1];
    [self.retweetImageView addGestureRecognizer:retweetTap];
}

- (void)onReplyClick {
    ComposeViewController *cv = [[ComposeViewController alloc] init];
    cv.replyText = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:cv];
    [self.delegate loadViewController:nvc];
}

- (void)onFavoriteClick {
    [[TwitterClient sharedInstance]favoriteForId:self.tweet.id completion:^(NSDictionary *response, NSError *error) {
        if (response != nil) {
            NSLog(@"response=%@",response);
            self.tweet.favoriteCount++;
            //self.favoriteLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.favoriteCount];
            [self.favoriteImageView setImageWithURL:[NSURL URLWithString:@"https://g.twimg.com/dev/documentation/image/favorite_on.png"]];
        }
    }];
}

- (void)onRetweetClick {
    [[TwitterClient sharedInstance]retweetForId:self.tweet.id completion:^(NSDictionary *response, NSError *error) {
        if (response != nil) {
            NSLog(@"response=%@",response);
            self.tweet.retweetCount++;
            //self.retweetLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.retweetCount];
            [self.retweetImageView setImageWithURL:[NSURL URLWithString:@"https://g.twimg.com/dev/documentation/image/retweet_on.png"]];
        }
    }];
}

- (void)onProfileImageClick {
    ProfileViewController *pvc = [[ProfileViewController alloc] init];
    pvc.user = self.tweet.user;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:pvc];
    [self.delegate loadViewController:nvc];
}

@end
