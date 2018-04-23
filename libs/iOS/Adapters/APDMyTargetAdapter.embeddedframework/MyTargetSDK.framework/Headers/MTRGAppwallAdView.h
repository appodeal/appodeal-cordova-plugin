//
//  MTRGAppwallAdView.h
//  myTargetSDK 4.6.22
//
//  Created by Anton Bulankin on 16.01.15.
//  Copyright (c) 2015 Mail.ru Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MyTargetSDK/MTRGNativeAppwallBanner.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTRGAppwallAdViewDelegate <NSObject>

- (void)appwallAdViewOnClickWithBanner:(MTRGNativeAppwallBanner *)banner;

- (void)appwallAdViewOnShowWithBanner:(MTRGNativeAppwallBanner *)banner;

@end

@interface MTRGAppwallAdView : UIView

@property(nonatomic, weak, nullable) id <MTRGAppwallAdViewDelegate> delegate;

- (nullable instancetype)initWithBanners:(nullable NSArray *)banners;

@end

NS_ASSUME_NONNULL_END
