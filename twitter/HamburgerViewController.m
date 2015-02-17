//
//  HamburgerViewController.m
//  twitter
//
//  Created by Sameer Shah on 2/16/15.
//  Copyright (c) 2015 Sameer Shah. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuCell.h"

@interface HamburgerViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:85.0/255.0f green:172.0/255.0f blue:238.0/255.0f alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    if (indexPath.row == 0) {
        cell.menuNameLabel.text = @"Profile";
    } else if (indexPath.row == 1) {
        cell.menuNameLabel.text = @"HomeTimeline";
    } else if (indexPath.row == 2) {
        cell.menuNameLabel.text = @"Mention";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate loadViewController:indexPath.row];
}


@end
