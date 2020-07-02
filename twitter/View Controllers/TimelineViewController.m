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
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate>

@property (nonatomic, strong) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

//ADDED SO THAT SELECTED ROW UNSELECTS AFTER RETURNING TO VIEW
-(void)viewWillAppear:(BOOL)animated {
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

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
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Tweet *tweet = self.tweets[indexPath.row];
    
    if ([segue.identifier isEqualToString:@"detailsSegue"]) {
        NSLog(@"detailing");
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.tweet = tweet;
        
    } else if ([segue.identifier isEqualToString:@"composeSegue"]){
        NSLog(@"composing");
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
        composeController.tweet = tweet;
        
    } else if ([segue.identifier isEqualToString:@"profileSegue"]) {
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.user = sender;
        
    }
    
    
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.delegate = self;
    Tweet *tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    cell.tweetLabel.text = tweet.text;
    NSString *profPicURLString = tweet.user.profPicURL;
    NSURL *profPicURL = [NSURL URLWithString:profPicURLString];
    [cell.profileImageView setImageWithURL:profPicURL];
    cell.profileImageView.layer.cornerRadius = 6;
    /*cell.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.retweenCountLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];*/
    [cell.favoriteButton setTitle:[NSString stringWithFormat: @"%d", cell.tweet.favoriteCount] forState:UIControlStateNormal];
    [cell.retweetButton setTitle:[NSString stringWithFormat: @"%d", cell.tweet.retweetCount] forState:UIControlStateNormal];
    cell.nameLabel.text = tweet.user.name;
    cell.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    cell.createdAtLabel.text = tweet.createdAtString;
    
    if (cell.tweet.favorited == YES) {
        cell.favoriteButton.selected = YES;
    }
    
    if (cell.tweet.retweeted == YES) {
        cell.retweetButton.selected = YES;
    }
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
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    // TODO: Perform segue to profile view controller
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

@end
