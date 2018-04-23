//
//  MTRGChatListAdView.h
//  myTargetSDK 4.6.22
//
//  Created by Anton Bulankin on 05.12.14.
//  Copyright (c) 2014 Mail.ru Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MyTargetSDK/MTRGNativePromoBanner.h>
#import <MyTargetSDK/MTRGStarsRatingLabel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTRGChatListAdView : UIView

@property(nonatomic, nullable) MTRGNativePromoBanner *banner;
@property(nonatomic) UIColor *backgroundColor;

@property(nonatomic, readonly) UILabel *ageRestrictionsLabel;
@property(nonatomic, readonly) UILabel *adLabel;
@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UILabel *descriptionLabel;
@property(nonatomic, readonly) UIImageView *iconImageView;

@property(nonatomic, readonly, nullable) UILabel *domainLabel;
@property(nonatomic, readonly, nullable) UILabel *disclaimerLabel;
@property(nonatomic, readonly, nullable) MTRGStarsRatingLabel *ratingStarsLabel;
@property(nonatomic, readonly, nullable) UILabel *votesLabel;

@property(nonatomic) UIEdgeInsets contentMargins;
@property(nonatomic) UIEdgeInsets adLabelMargins;
@property(nonatomic) UIEdgeInsets ageRestrictionsMargins;
@property(nonatomic) UIEdgeInsets titleMargins;
@property(nonatomic) UIEdgeInsets domainMargins;
@property(nonatomic) UIEdgeInsets descriptionMargins;
@property(nonatomic) UIEdgeInsets disclaimerMargins;
@property(nonatomic) UIEdgeInsets iconMargins;
@property(nonatomic) UIEdgeInsets ratingStarsMargins;
@property(nonatomic) UIEdgeInsets votesMargins;

- (void)loadImages;

@end

NS_ASSUME_NONNULL_END
