//
//  MTRGNativeAppwallAd.h
//  myTargetSDK 4.6.22
//
//  Created by Anton Bulankin on 13.01.15.
//  Copyright (c) 2015 Mail.ru Group. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MyTargetSDK/MTRGCustomParams.h>
#import <MyTargetSDK/MTRGNativeAppwallBanner.h>
#import <MyTargetSDK/MTRGAppwallAdView.h>

NS_ASSUME_NONNULL_BEGIN

@class MTRGNativeAppwallAd;

@protocol MTRGNativeAppwallAdDelegate <NSObject>

- (void)onLoadWithAppwallBanners:(NSArray *)appwallBanners appwallAd:(MTRGNativeAppwallAd *)appwallAd;

- (void)onNoAdWithReason:(NSString *)reason appwallAd:(MTRGNativeAppwallAd *)appwallAd;

@optional

- (void)onAdClickWithNativeAppwallAd:(MTRGNativeAppwallAd *)appwallAd appwallBanner:(MTRGNativeAppwallBanner *)appwallBanner;

@end


@interface MTRGNativeAppwallAd : NSObject

@property(nonatomic, weak, nullable) id <MTRGNativeAppwallAdDelegate> delegate;
@property(nonatomic, copy, nullable) NSString *appWallTitle;
@property(nonatomic, copy, nullable) NSString *closeButtonTitle;
@property(nonatomic) NSUInteger cachePeriodInSec;
@property(nonatomic, readonly, nullable) MTRGCustomParams *customParams;
@property(nonatomic, readonly, nullable) NSArray *banners;
@property(nonatomic) BOOL autoLoadImages;
@property(nonatomic) BOOL trackEnvironmentEnabled;

+ (void)setDebugMode:(BOOL)enabled;

+ (BOOL)isDebugMode;

+ (void)loadImage:(MTRGImageData *)imageData toView:(UIImageView *)imageView;

- (nullable instancetype)initWithSlotId:(NSUInteger)slotId;

- (void)load;

- (void)showWithController:(UIViewController *)controller onComplete:(nullable void (^)(void))onComplete onError:(nullable void (^)(NSError *error))onError;

- (void)registerAppWallAdView:(MTRGAppwallAdView *)appWallAdView withController:(UIViewController *)controller;

- (void)close;

- (BOOL)hasNotifications;

- (void)handleShow:(MTRGNativeAppwallBanner *)appWallBanner;

- (void)handleClick:(MTRGNativeAppwallBanner *)appWallBanner withController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
