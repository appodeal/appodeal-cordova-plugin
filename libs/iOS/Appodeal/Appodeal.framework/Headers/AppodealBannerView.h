//
//  AppodealBannerView.h
//  Appodeal
//
//  Created by Stas Kochkin on 22/08/16.
//  Copyright © 2016 Appodeal, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Appodeal/APDBannerView.h>
#import <Appodeal/APDMRECView.h>
#import <UIKit/UIKit.h>


@class AppodealBannerView;
/**
 *  Banner view delegate declaration
 */
@protocol AppodealBannerViewDelegate <NSObject>

@optional

/**
 *  Method called when banner did load firstly, after refresh this method not call
 *
 *  @param bannerView Nonnul, ready to show banner
 */
- (void)bannerViewDidLoadAd:(APDBannerView *)bannerView;

/**
 *  Method called in case that banner mediation failed
 *
 *  @param bannerView Nonnul failed banner view
 *  @param error      Error occured while mediation
 */
- (void)bannerView:(APDBannerView *)bannerView didFailToLoadAdWithError:(NSError *)error;

/**
 *  Method called when user tap on banner
 *
 *  @param bannerView Nonnul banner view
 */
- (void)bannerViewDidInteract:(APDBannerView *)bannerView;

@end

/*!
 *  Alias on APDBannerView.
 *  Need only for backward compatibility with Appodeal sdk version 0.10.8 and lower
 *  @warning If your integrate Appodeal at first time, we highly recomeded to use APDBannerView
 */
@interface AppodealBannerView : APDBannerView

/**
 *  Getter of banner availability
 */
@property (assign, nonatomic, readonly, getter=isReady) BOOL ready;

/**
 *  Set delegate to recive callbacks declared in AppodealBannerViewDelegate protocol
 *
 *  @param delegate Nullable delegate
 */
- (void)setDelegate:(id<AppodealBannerViewDelegate>)delegate;

/**
 *  Getter of object that you set by -setDelegate:
 *
 *  @return Nullable belegate
 */
- (id<AppodealBannerViewDelegate>)delegate;

/**
 *  Initializer
 *
 *  @param size               Appodeal valid size
 *  @param rootViewController Nonnul view controller
 *
 *  @return Instance of Appodeal banner view class
 */
- (instancetype)initWithSize:(CGSize)size rootViewController:(UIViewController *)rootViewController;

/**
 *  Start banner mediaition
 */
- (void)loadAd;

@end


@interface AppodealMRECView : APDMRECView

/**
 *  Set delegate to recive callbacks declared in AppodealBannerViewDelegate protocol
 *
 *  @param delegate Nullable delegate
 */
- (void)setDelegate:(id<AppodealBannerViewDelegate>)delegate;

/**
 *  Getter of object that you set by -setDelegate:
 *
 *  @return Nullable belegate
 */
- (id<AppodealBannerViewDelegate>)delegate;

/**
 *  Initializer
 *
 *  @param rootViewController Nonnul view controller
 *
 *  @return Instance of Appodeal mrec view class of size 300 x 250
 */
- (instancetype) initWithRootViewController: (UIViewController *) rootViewController;


@end
