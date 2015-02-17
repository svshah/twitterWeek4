//
//  ProfileViewController.m
//  twitter
//
//  Created by Sameer Shah on 2/16/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *noOfTweetsLabel;
@property (strong, nonatomic) IBOutlet UILabel *noOfFollowingLabel;
@property (strong, nonatomic) IBOutlet UILabel *noOfFollowersLabel;
@property (strong, nonatomic) IBOutlet UIView *TopView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.userNameLabel.text = self.user.name;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0f green:172.0/255.0f blue:238.0/255.0f alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@",self.user.screenName];
    self.noOfTweetsLabel.text = [NSString stringWithFormat:@"%ld",self.user.noOfTweets];
    self.noOfFollowersLabel.text = [NSString stringWithFormat:@"%ld",self.user.noOfFollowers];
    self.noOfFollowingLabel.text = [NSString stringWithFormat:@"%ld",self.user.noOfFollowing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUser:(User *)user {
    _user = user;
}

- (void)onBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
