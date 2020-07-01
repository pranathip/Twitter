//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self getTimeline];
   
}

- (void) getTimeline {
    // Get timeline
       [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
           if (tweets) {
               NSLog(@"😎😎😎 Successfully loaded home timeline");
               self.tweets = [NSMutableArray arrayWithArray:tweets];
               [self.tableView reloadData];
               //NSLog(@"%@", tweets);
               /*for (NSDictionary *dictionary in tweets) {
                   NSString *text = dictionary[@"text"];
                   NSLog(@"%@", text);
               }*/
           } else {
               NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
           }
           [self.refreshControl endRefreshing];
       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    cell.tweetLabel.text = tweet.text;
    NSString *profPicURLString = tweet.user.profPicURL;
    NSURL *profPicURL = [NSURL URLWithString:profPicURLString];
    [cell.profileImageView setImageWithURL:profPicURL];
    cell.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.retweenCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    cell.nameLabel.text = tweet.user.name;
    cell.screenNameLabel.text = [NSString stringWithFormat:@"@%@ · %@", tweet.user.screenName, tweet.createdAtString];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (void)didTweet:(nonnull Tweet *)tweet {
    NSLog(@"adding tweet/updating");
    [self.tweets addObject:tweet];
    [self getTimeline];
    //[self.tableView reloadData];
}

- (IBAction)tappedLogOut:(id)sender {
    
}

@end
