//
//  MVInterstitialAdManager.h
//  MVSDK
//
//  Created by CharkZhang on 2016/11/8.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MVInterstitialAdCategory) {
    MVInterstitial_AD_CATEGORY_ALL  = 0,
    MVInterstitial_AD_CATEGORY_GAME = 1,
    MVInterstitial_AD_CATEGORY_APP  = 2,
};



#pragma mark - MVInterstitialAdManagerDelegate

/**
 *  This protocol defines a listener for ad Interstitial load events.
 */
@protocol MVInterstitialAdLoadDelegate <NSObject>

@optional
/**
 *  Sent when the ad is successfully load , and is ready to be displayed
 */
- (void) onInterstitialLoadSuccess;

/**
 *  Sent when there was an error loading the ad.
 *
 *  @param error An NSError object with information about the failure.
 */
- (void) onInterstitialLoadFail:(nonnull NSError *)error;

@end


/**
 *  This protocol defines a listener for ad Interstitial show events.
 */
@protocol MVInterstitialAdShowDelegate <NSObject>

@optional
/**
 *  Sent when the Interstitial success to open
 */
- (void) onInterstitialShowSuccess;

/**
 *  Sent when the Interstitial failed to open for some reason
 *
 *  @param error An NSError object with information about the failure.
 */
- (void) onInterstitialShowFail:(nonnull NSError *)error;

/**
 *  Sent when the Interstitial has been clesed from being open, and control will return to your app
 */
- (void) onInterstitialClosed;

/**
 *  Sent after the Interstitial has been clicked by a user.
 */
- (void) onInterstitialAdClick;



@end



@interface MVInterstitialAdManager : NSObject




/**
 *  Initialize the native ads manager.
 *
 *  @param unitId         The id of the ad unit. You can create your unit id from our Portal.
 *  @param adCategory     Decide what kind of ads you want to retrieve. Games, apps or all of them. The default is All.
 */
- (nonnull instancetype)initWithUnitID:(nonnull NSString *)unitId
                            adCategory:(MVInterstitialAdCategory)adCategory;

/**
 *  Called when load the Interstitial
 *
 *  @param unitId   the unitId string of the offer wall that was loaded.
 *  @param delegate reference to the object that implements MVInterstitialAdLoadDelegate protocol; will receive load events for the given unitId.
 */
- (void)loadWithDelegate:(nullable id <MVInterstitialAdLoadDelegate>) delegate;

/**
 *  Called when show the Interstitial
 *
 *  @param delegate       reference to the object that implements MVInterstitialAdShowDelegate protocol; will receive show events for the given unitId.
 
 *  @param viewController The UIViewController that will be used to present Interstitial Controller. If not set, it will be the root viewController of your current UIWindow. But it may failed to present our Interstitial controller if your rootViewController is presenting other view controller. So set this property is necessary.

 */
- (void)showWithDelegate:(nullable id <MVInterstitialAdShowDelegate>)delegate presentingViewController:(nullable UIViewController *)viewController;



@end
