//
//  User.m
//  twitter
//
//  Created by Pranathi Peri on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profPicURL = dictionary[@"profile_image_url_https"];
        self.bannerPicURL = dictionary[@"profile_banner_url"];
        self.followers = dictionary[@"followers_count"];
        self.following = dictionary[@"friends_count"];
        // Init other properties
    }
    return self;
}

@end
