//
//  MentionsViewController.m
//  twitter
//
//  Created by Sameer Shah on 2/16/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import "MentionsViewController.h"
#import "TweetCell.h"
#import "TwitterClient.h"
#import "User.h"

@interface MentionsViewController () <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) TweetCell *prototypeCell;

@end

@implementation MentionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    User *user = [User currentUser];
    [[TwitterClient sharedInstance] userTimelineWithParams:user.screenName completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0f green:172.0/255.0f blue:238.0/255.0f alpha:1.0]];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (TweetCell *)prototypeCell {
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    }
    return _prototypeCell;
}

@end
