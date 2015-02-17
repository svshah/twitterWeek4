//
//  LoginViewController.m
//  twitter
//
//  Created by Sameer Shah on 2/4/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"
#import "ContainerViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance]loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // modally present the tweets view
            NSLog(@"user name = %@", user.name);
            [self presentViewController:[[ContainerViewController alloc] init] animated:YES completion:nil];
        } else {
            // present error view
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0f green:172.0/255.0f blue:238.0/255.0f alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
