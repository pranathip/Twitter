//
//  TweetCell.m
//  twitter
//
//  Created by Pranathi Peri on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    self.favoriteButton.selected = YES;
    [self refreshCell];
    
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
    
}

- (void)refreshCell {
    self.favoriteCountLabel.text = [NSString stringWithFormat: @"%d", self.tweet.favoriteCount];
    self.retweenCountLabel.text = [NSString stringWithFormat: @"%d", self.tweet.retweetCount];
}

@end
