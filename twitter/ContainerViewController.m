//
//  ContainerViewController.m
//  twitter
//
//  Created by Sameer Shah on 2/16/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import "ContainerViewController.h"
#import "TweetsViewController.h"
#import "HamburgerViewController.h"
#import "ComposeViewController.h"
#import "ProfileViewController.h"
#import "MentionsViewController.h"

@interface ContainerViewController () <UIGestureRecognizerDelegate, HamburgerViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UINavigationController *unvc;
@property (strong, nonatomic) HamburgerViewController *hamburgerViewController;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hamburgerViewController = [[HamburgerViewController alloc] init];
    self.hamburgerViewController.delegate = self;
    self.hamburgerViewController.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.hamburgerViewController.view];
    
    self.unvc = [[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] init]];
    self.unvc.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.unvc.view];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(showHamburgerMenu:)];
    [self.contentView addGestureRecognizer:recognizer];
    recognizer.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showHamburgerMenu:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    
    CGRect frame = self.unvc.view.frame;
    frame.origin.x = translation.x;
    self.unvc.view.frame = frame;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Container Gesture began at: %@", NSStringFromCGPoint(translation));
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Container Gesture changed: %@", NSStringFromCGPoint(translation));
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Container Gesture ended: %@", NSStringFromCGPoint(translation));
        if (velocity.x > 0) {
            CGRect frame = self.unvc.view.frame;
            frame.origin.x = 150;
            [UIView animateWithDuration:0.5 animations:^{
                self.unvc.view.frame = frame;
            }];
        } else {
            CGRect frame = self.unvc.view.frame;
            frame.origin.x = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.unvc.view.frame = frame;
            }];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return TRUE;
}

- (void) loadViewController: (NSInteger)viewController {
    
    if (viewController == 0) {
        ProfileViewController *pvc = [[ProfileViewController alloc] init];
        pvc.user = [User currentUser];
        self.unvc = [[UINavigationController alloc] initWithRootViewController:pvc];
        self.unvc.view.frame = self.contentView.frame;
        [self.contentView addSubview:self.hamburgerViewController.view];
        [self.contentView addSubview:self.unvc.view];
    } else if (viewController == 1) {
        self.unvc = [[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] init]];
        self.unvc.view.frame = self.contentView.frame;
        [self.contentView addSubview:self.hamburgerViewController.view];
        [self.contentView addSubview:self.unvc.view];
    } else if (viewController == 2) {
        MentionsViewController *mvc = [[MentionsViewController alloc] init];
        self.unvc.view.frame = self.contentView.frame;
        self.unvc = [[UINavigationController alloc] initWithRootViewController:mvc];
        [self.contentView addSubview:self.hamburgerViewController.view];
        [self.contentView addSubview:self.unvc.view];
    }
}

@end
