//
//  TweetsViewController.m
//  twitter
//
//  Created by Sameer Shah on 2/7/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweets.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "TweetDetailViewController.h"


@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>

@property (strong, nonatomic) NSArray *tweets;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TweetCell *prototypeCell;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeTweet)];
    self.navigationItem.title = @"Home";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self; 
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
        for (Tweets *tweet in tweets) {
            NSLog(@" Tweet %@, created: %@", tweet.text, tweet.createdAt);
        }
    }];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0f green:172.0/255.0f blue:238.0/255.0f alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.tableView.rowHeight = UITableViewAutomaticDimension;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void) loadViewController:(UINavigationController *) viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.prototypeCell.tweet = self.tweets[indexPath.row];
    [self.prototypeCell layoutIfNeeded];

    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TweetDetailViewController *tdvc = [[TweetDetailViewController alloc] init];
    tdvc.tweet = self.tweets[indexPath.row];
    //tdvc.navigationController = self.navigationController;
    [self.navigationController pushViewController:tdvc animated:YES];
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
}

- (TweetCell *)prototypeCell {
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    }
    return _prototypeCell;
}

- (void)onLogout {
    [User logout];
}

- (void)onComposeTweet{
    ComposeViewController *cv = [[ComposeViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:cv];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
