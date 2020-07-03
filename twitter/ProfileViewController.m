//
//  ProfileViewController.m
//  twitter
//
//  Created by Pranathi Peri on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profPicView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerPicView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set prof pic
    NSLog(@"Setting prof pic");
    NSString *profPicURLString = self.user.profPicURL;
    NSURL *profPicURL = [NSURL URLWithString:profPicURLString];
    [self.profPicView setImageWithURL:profPicURL];
    self.profPicView.layer.cornerRadius = 6;
    
    // Set banner pic
    NSString *bannerPicURLString = self.user.bannerPicURL;
    NSURL *bannerPicURL = [NSURL URLWithString:bannerPicURLString];
    [self.bannerPicView setImageWithURL:bannerPicURL];
    
    self.nameLabel.text = self.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.followerLabel.text = [NSString stringWithFormat:@"%@", [self suffixNumber:self.user.followers]];
    self.followingLabel.text = [NSString stringWithFormat:@"%@", [self suffixNumber:self.user.following]];
    self.bioLabel.text = self.user.bio;
    self.locationLabel.text = self.user.location;
    
    
}

- (NSString*) suffixNumber:(NSNumber*)number
{
    if (!number)
        return @"";

    long long num = [number longLongValue];

    int s = ( (num < 0) ? -1 : (num > 0) ? 1 : 0 );
    NSString* sign = (s == -1 ? @"-" : @"" );

    num = llabs(num);

    if (num < 1000)
        return [NSString stringWithFormat:@"%@%lld",sign,num];

    int exp = (int) (log10l(num) / 3.f); //log10l(1000));

    NSArray* units = @[@"K",@"M",@"G",@"T",@"P",@"E"];

    return [NSString stringWithFormat:@"%@%.1f%@",sign, (num / pow(1000, exp)), [units objectAtIndex:(exp-1)]];
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
