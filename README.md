# Project 3 - *Twitter*

Twitter is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: ~4 days spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign in using OAuth login flow
- [x] User can Logout
- [x] User can view last 20 tweets from their home timeline
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [x] User can pull to refresh.
- [x] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] Using AutoLayout, the Tweet cell should adjust its layout for iPhone 11, Pro and SE device sizes as well as accommodate device rotation.
- [x] User should display the relative timestamp for each tweet "8m", "7h"
- [x] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **stretch** features are implemented:

- [x] User can view their profile in a *profile tab*
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
  - [ ] Profile view should include that user's timeline
- [x] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [x] User can tap the profile image in any tweet to see another user's profile
  - Contains the user header view: picture and tagline
  - Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [x] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 280) (**1 point**)
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available
- [ ] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

- [x] Countdown number turns red when 20 characters are remaining in tweet.
- [x] Profile picture, name, and screen name are displayed when composing a tweet.
- [x] Placeholder text and animated fade in and fade out when composing a tweet.
- [x] Number of likes, followers, and retweets is shown in truncated form (i.e. 12K instead of 12345)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I never got around to being able to implement infinite scroll, I would like to explore this functionality in the future.
2. I had a bit of trouble trying to implement a "half screen" scrollview, where tweets show up on the bottom of the profile screen. I would like to talk about this implementation as well. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://recordit.co/sCXDwxNTO1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://recordit.co/67bWCoztCv.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://recordit.co/2beSVIhwxu.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with RecordIt.

## Notes

This app was definitely more challenging to make than the other two - there was a lot of involvement in doing network requests, transferring data from page to page, and more. The most challenging part for me, was definitely being able to accurately implement the transition from the tableview to the detailsview, as well as a more complicated series of components to factor with autolayout. Overall, I learned a great deal from this project and am excited to dive into Instagram next week!

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - Date and time library

## License

    Copyright 2020 Pranathi Peri

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
