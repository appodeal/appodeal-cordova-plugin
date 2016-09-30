//
//  MTRGAppwallBannerAdView.h
//  myTargetSDK 4.5.3
//
//  Created by Anton Bulankin on 15.01.15.
//  Copyright (c) 2015 Mail.ru Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MyTargetSDK/MTRGNativeAppwallBanner.h>

@class MTRGAppwallBannerAdView;

@protocol MTRGAppwallBannerAdViewDelegate <NSObject>

- (void)appWallBannerAdViewOnClickWithView:(MTRGAppwallBannerAdView *)bannerAdView;

- (void)appWallBannerAdViewOnCancelSelectWithView:(MTRGAppwallBannerAdView *)bannerAdView;

@optional

- (BOOL)appWallBannerAdViewAllowStartSelect:(MTRGAppwallBannerAdView *)bannerAdView;

@end


@interface MTRGAppwallBannerAdView : UIView
@property(nonatomic) MTRGNativeAppwallBanner *appWallBanner;
@property(nonatomic) UIColor *activeBackgroundColor;
@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UILabel *descriptionLabel;
@property(nonatomic, readonly) UIImageView *iconImageView;

- (instancetype)initWithBanner:(MTRGNativeAppwallBanner *)appWallBanner delegate:(id <MTRGAppwallBannerAdViewDelegate>)delegate;

- (void)setFixedWidth:(CGFloat)width;

- (void)setPosition:(CGPoint)position;

- (CGSize)getSize;


@end
