//
//  MTRGStarsRatingLabel.h
//  myTargetSDK 4.6.22
//
//  Created by Andrey Seredkin on 27.01.17.
//  Copyright © 2017 Mail.ru Group. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTRGStarsRatingLabel : UILabel

- (nullable instancetype)initWithRating:(NSNumber *)rating; //rating in interval 0...5

@end

NS_ASSUME_NONNULL_END
