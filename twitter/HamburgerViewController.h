//
//  HamburgerViewController.h
//  twitter
//
//  Created by Sameer Shah on 2/16/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HamburgerViewController;

@protocol HamburgerViewDelegate <NSObject>

- (void) loadViewController: (NSInteger)viewController;

@end

@interface HamburgerViewController : UIViewController

@property (nonatomic, weak) id<HamburgerViewDelegate> delegate;

@end
