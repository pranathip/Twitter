//
//  ComposeViewController.m
//  twitter
//
//  Created by Pranathi Peri on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *composeTweetView;
@property (weak, nonatomic) IBOutlet UIImageView *profPicImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composeTweetView.delegate = self;
    [self.composeTweetView addSubview:self.placeholderLabel];
    
    // Set prof pic
    NSString *profPicURLString = self.tweet.user.profPicURL;
    NSURL *profPicURL = [NSURL URLWithString:profPicURLString];
    [self.profPicImage setImageWithURL:profPicURL];
    self.profPicImage.layer.cornerRadius = 6;
    
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.name];
    self.screenNameLabel.text = self.tweet.user.screenName;
    
}
- (IBAction)tweetButtonTapped:(id)sender {
    NSLog(@"tapped");
    [[APIManager shared]postStatusWithText:self.composeTweetView.text completion:^(Tweet *tweet, NSError *error) {
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

- (void) textViewDidChange:(UITextView *)theTextView
{
    if(![self.composeTweetView hasText]) {
        NSLog(@"no text");
        [UIView animateWithDuration:0.15 animations:^{
            [self.composeTweetView addSubview:self.placeholderLabel];
            self.placeholderLabel.alpha = 1.0;
        }];
    } else if ([[self.composeTweetView subviews] containsObject:self.placeholderLabel]) {
        [UIView animateWithDuration:0.15 animations:^{
            self.placeholderLabel.alpha = 0.0;
            
    } completion:^(BOOL finished) {
        //[self.placeholderLabel removeFromSuperview];
    }];
  }
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
