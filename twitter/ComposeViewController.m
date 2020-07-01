//
//  ComposeViewController.m
//  twitter
//
//  Created by Pranathi Peri on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "ComposeViewController.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeTweetView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)tweetButtonTapped:(id)sender {
    NSLog(@"tapped");
    [[APIManager shared]postStatusWithText:@"testing testing" completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Compose Tweet Success!");
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}
- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
