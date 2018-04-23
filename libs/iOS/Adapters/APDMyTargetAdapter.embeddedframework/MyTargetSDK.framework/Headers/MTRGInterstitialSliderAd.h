//
//  MTRGInterstitialSliderAd.h
//  myTargetSDK 4.6.22
//
//  Created by Andrey Seredkin on 10.11.16.
//  Copyright © 2016 Mail.ru Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MyTargetSDK/MTRGCustomParams.h>

NS_ASSUME_NONNULL_BEGIN

@class MTRGInterstitialSliderAd;

@protocol MTRGInterstitialSliderAdDelegate <NSObject>

- (void)onLoadWithInterstitialSliderAd:(MTRGInterstitialSliderAd *)interstitialSliderAd;

- (void)onNoAdWithReason:(NSString *)reason interstitialSliderAd:(MTRGInterstitialSliderAd *)interstitialSliderAd;

@optional

- (void)onClickWithInterstitialSliderAd:(MTRGInterstitialSliderAd *)interstitialSliderAd;

- (void)onCloseWithInterstitialSliderAd:(MTRGInterstitialSliderAd *)interstitialSliderAd;

- (void)onDisplayWithInterstitialSliderAd:(MTRGInterstitialSliderAd *)interstitialSliderAd;

- (void)onLeaveApplicationWithInterstitialSliderAd:(MTRGInterstitialSliderAd *)interstitialSliderAd;

@end

@interface MTRGInterstitialSliderAd : NSObject

@property(nonatomic, weak, nullable) id <MTRGInterstitialSliderAdDelegate> delegate;
@property(nonatomic, readonly, nullable) MTRGCustomParams *customParams;
@property(nonatomic) BOOL trackEnvironmentEnabled;

+ (void)setDebugMode:(BOOL)enabled;

+ (BOOL)isDebugMode;

- (nullable instancetype)initWithSlotId:(NSUInteger)slotId;

- (void)load;

- (void)showWithController:(UIViewController *)controller;

- (void)showModalWithController:(UIViewController *)controller;

- (void)close;

@end

NS_ASSUME_NONNULL_END
