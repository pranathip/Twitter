//
//  User.h
//  twitter
//
//  Created by Pranathi Peri on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profPicURL;
@property (nonatomic, strong) NSString *bannerPicURL;
@property (nonatomic, strong) NSNumber *followers;
@property (nonatomic, strong) NSNumber *following;

// Sets all properties based on the dictionary
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
