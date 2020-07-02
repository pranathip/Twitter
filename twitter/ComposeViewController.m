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
@property (weak, nonatomic) IBOutlet UILabel *characterCount;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composeTweetView.delegate = self;
    [self.composeTweetView addSubview:self.placeholderLabel];
    
    [[APIManager shared] getProfileInfo:^(User *user, NSError *error) {
        if (user) {
            NSLog(@"😎😎😎 Successfully loaded profile");
            // Set prof pic
            NSString *profPicURLString = user.profPicURL;
            NSURL *profPicURL = [NSURL URLWithString:profPicURLString];
            [self.profPicImage setImageWithURL:profPicURL];
            self.profPicImage.layer.cornerRadius = 6;
            
            self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
            self.screenNameLabel.text = user.screenName;
        } else {
            NSLog(@"😫😫😫 Error getting profile: %@", error.localizedDescription);
        }
    }];
    
    
    
    
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
   // Allow or disallow the new text
    // Set the max character limit
    int characterLimit = 140;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.composeTweetView.text stringByReplacingCharactersInRange:range withString:text];

    // TODO: Update Character Count Label
    self.characterCount.text = [NSString stringWithFormat: @"%lu", 140 - newText.length];
    if (140 - newText.length <= 20) {
        self.characterCount.textColor = UIColor.redColor;
    } else {
        self.characterCount.textColor = UIColor.lightGrayColor;
    }

    // The new text should be allowed? True/False
    return newText.length < characterLimit;
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
