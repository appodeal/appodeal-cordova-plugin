//
//  Appodeal.h
//  Appodeal
//
//  AppodealSDK version 2.0.0-All
//
//  Copyright (c) 2017 Appodeal, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Appodeal/AppodealBannerView.h>
#import <Appodeal/APDDefines.h>
#import <Appodeal/APDSdk.h>

#import <Appodeal/APDInterstitialAd.h>
#import <Appodeal/APDRewardProtocol.h>
#import <Appodeal/APDSkippableVideo.h>
#import <Appodeal/APDRewardedVideo.h>

#import <Appodeal/APDMRECView.h>
#import <Appodeal/APDBannerView.h>

#import <Appodeal/APDNativeAdLoader.h>
#import <Appodeal/APDNativeAdQueue.h>
#import <Appodeal/APDNativeAd.h>
#import <Appodeal/APDImage.h>
#import <Appodeal/APDMediaView.h>


FOUNDATION_EXPORT const CGSize kAppodealUnitSize_320x50;
FOUNDATION_EXPORT const CGSize kAppodealUnitSize_300x250;
FOUNDATION_EXPORT const CGSize kAppodealUnitSize_728x90;

FOUNDATION_EXPORT NSArray * AppodealAvailableUnitSizes();

FOUNDATION_EXPORT BOOL AppodealIsUnitSizeSupported(const CGSize size, NSArray *supportedSizes);
FOUNDATION_EXPORT BOOL AppodealIsUnitSizeAvailable(const CGSize size);


FOUNDATION_EXPORT CGSize AppodealNearestUnitSizeForSize(CGSize size);

/*!
 *  Appodeal ads types
 */
typedef NS_OPTIONS(NSInteger, AppodealAdType) {
    /*!
     *  Interstitial
     */
    AppodealAdTypeInterstitial      = 1 << 0,
    /*!
     *  Skippable video (can be skipped by user after several seconds of watch)
     */
    AppodealAdTypeSkippableVideo __attribute__((deprecated("Use AppodealAdTypeInterstitial")))   = 1 << 1,
    /*!
     *  Banner ads
     */
    AppodealAdTypeBanner            = 1 << 2,
    /*!
     *  Native ads
     */
    AppodealAdTypeNativeAd          = 1 << 3,
    /*!
     *  Rewarded video (return reward parameter in finish callback, can not be skipped by user)
     */
    AppodealAdTypeRewardedVideo     = 1 << 4,
    /*!
     *  Rectangle banner of size 300 x 250
     */
    AppodealAdTypeMREC              = 1 << 5,
    /*!
     *  Non skippable video (does not return reward parameter in finish callback, can not be skipped by user)
     */
    AppodealAdTypeNonSkippableVideo = 1 << 6,
};

/*!
 *  Appodeal styles to show
 */
typedef NS_OPTIONS(NSInteger, AppodealShowStyle) {
    /*!
     *  Show interstial ads
     */
    AppodealShowStyleInterstitial       = 1 << 0,
    /*!
     *  Show skippable ads
     */
    AppodealShowStyleSkippableVideo     = 1 << 1,
    /*!
     *  - If both ready, show ad that eCPM heigher
     *  @discussion - If one of this types ready, show with ad
     *  @discussion - If no one ready, waiting for first ready
     */
    AppodealShowStyleVideoOrInterstitial __attribute__((deprecated("Use bit mask AppodealShowStyleInterstitial | AppodealShowStyleSkippableVideo"))) = AppodealShowStyleInterstitial | AppodealShowStyleSkippableVideo,
    /*!
     *  Show banner at top of screen
     */
    AppodealShowStyleBannerTop          = 1 << 2,
    /*!
     *  Show banner at bottom of screen
     */
    AppodealShowStyleBannerBottom       = 1 << 3,
    /*!
     *  Show rewareded video
     */
    AppodealShowStyleRewardedVideo      = 1 << 4,
    /*!
     *  Show non skippable video
     */
    AppodealShowStyleNonSkippableVideo  = 1 << 5
};

typedef NS_ENUM(NSUInteger, AppodealUserGender) {
    AppodealUserGenderOther = 0,
    AppodealUserGenderFemale,
    AppodealUserGenderMale
};

typedef NS_ENUM(NSUInteger, AppodealUserOccupation) {
    AppodealUserOccupationOther = 0,
    AppodealUserOccupationWork,
    AppodealUserOccupationSchool,
    AppodealUserOccupationUniversity
};

typedef NS_ENUM(NSUInteger, AppodealUserRelationship) {
    AppodealUserRelationshipOther = 0,
    AppodealUserRelationshipSingle,
    AppodealUserRelationshipDating,
    AppodealUserRelationshipEngaged,
    AppodealUserRelationshipMarried,
    AppodealUserRelationshipSearching
};

typedef NS_ENUM(NSUInteger, AppodealUserSmokingAttitude) {
    AppodealUserSmokingAttitudeNegative = 1,
    AppodealUserSmokingAttitudeNeutral,
    AppodealUserSmokingAttitudePositive
};

typedef NS_ENUM(NSUInteger, AppodealUserAlcoholAttitude) {
    AppodealUserAlcoholAttitudeNegative = 1,
    AppodealUserAlcoholAttitudeNeutral,
    AppodealUserAlcoholAttitudePositive
};

/*!
 *  Declaration of banner delegate
 */
@protocol AppodealBannerDelegate <NSObject>

@optional
/*!
 *  Method called when precache (cheap and fast load) or usual banner view did load
 *
 *  @param precache If precache is YES it's mean that precache loaded
 */
- (void)bannerDidLoadAdIsPrecache:(BOOL)precache;

/*!
 *  @discussion Method called when banner did load and ready to show
 */
- (void)bannerDidLoadAd __attribute__((deprecated("Use -bannerDidLoadAdisPrecache:precache: instead")));

/*!
 *  Method called when banner refresh
 */
- (void)bannerDidRefresh __attribute__((deprecated("Use -bannerDidShow instead")));

/*!
 *  Method called if banner mediation failed
 */
- (void)bannerDidFailToLoadAd;

/*!
 *  Method called when user tap on banner
 */
- (void)bannerDidClick;

/*!
 *  Method called when banner show first time
 *  @warniing After refresh this method not called
 */
- (void)bannerDidShow;

@end

/*!
 *  Interstital delegate declaration
 */
@protocol AppodealInterstitialDelegate <NSObject>

@optional

/*!
 *  Method called when usual interstitial view did load
 *
 */
- (void)interstitialDidLoadAd __attribute__((deprecated("Use -interstitialDidLoadAdisPrecache: instead")));

/*!
 *  Method called when precache (cheap and fast load) or usual interstitial view did load
 *  @warning If you want show only expensive ad, ignore this callback call with precache equal to YES
 *
 *  @param precache If precache is YES it's mean that precache loaded
 */
- (void)interstitialDidLoadAdisPrecache:(BOOL)precache;

/*!
 *  Method called if interstitial mediation failed
 */
- (void)interstitialDidFailToLoadAd;

/*!
 *  Method called if interstitial mediation was success, but ready ad network can't show ad or 
 *  ad presentation was to frequently according your placement settings
 */
- (void)interstitialDidFailToPresent;

/*!
 *  Method called when interstitial will display on screen
 */
- (void)interstitialWillPresent;

/*!
 *  Method called after interstitial leave screeen
 */
- (void)interstitialDidDismiss;

/*!
 *  Method called when user tap on interstitial
 */
- (void)interstitialDidClick;

@end


/*!
 *  Rewarded video delegate declaration
 */
@protocol AppodealRewardedVideoDelegate <NSObject>

@optional

/*!
 *  Method called when rewarded video did load
 */
- (void)rewardedVideoDidLoadAd;

/*!
 *  Mehtod called if rewarded video mediation failed
 */
- (void)rewardedVideoDidFailToLoadAd;

/*!
 *  Method called if interstitial mediation was success, but ready ad network can't show ad or
 *  ad presentation was to frequently according your placement settings
 */
- (void)rewardedVideoDidFailToPresent;

/*!
 *  Method called after rewarded video start displaying
 */
- (void)rewardedVideoDidPresent;

/*!
 *  Methof called before rewarded video leave screen
 */
- (void)rewardedVideoWillDismiss;

/*!
 *  Method called after fully watch of video
 *  @warning After call this method rewarded video can stay on screen and show postbanner
 *
 *  @param rewardAmount Amount of app curency tuned via Appodeal Dashboard
 *  @param rewardName   Name of app curency tuned via Appodeal Dashboard
 */
- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName;

/*!
 *  Method called after user tap on screen
 *  @warning Not all ad networks provides this callback!
 */
- (void)rewardedVideoDidClick __attribute__((deprecated("Not all ad networks return this action")));

@end


/*!
 *  Non skippable video delegate
 */
@protocol AppodealNonSkippableVideoDelegate <NSObject>

@optional

/*!
 *  Method called when non skippable video did load
 */
- (void)nonSkippableVideoDidLoadAd;

/*!
 *  Mehtod called if non skippable video mediation failed
 */
- (void)nonSkippableVideoDidFailToLoadAd;

/*!
 *  Method called after non skippable video start displaying
 */
- (void)nonSkippableVideoDidPresent;

/*!
 *  Method called if interstitial mediation was success, but ready ad network can't show ad or
 *  ad presentation was to frequently according your placement settings
 */
- (void)nonSkippableVideoDidFailToPresent;

/*!
 *  Methof called before non skippable video leave screen
 */
- (void)nonSkippableVideoWillDismiss;

/*!
 *  Method called after fully watch of video
 *  @warning After call this method non skippable video can stay on screen and show postbanner
 *
*/
- (void)nonSkippableVideoDidFinish;

/*!
 *  Method called after user tap on screen
 *  @warning Not all ad networks provides this callback!
 */
- (void)nonSkippableVideoDidClick __attribute__((deprecated("Not all ad networks return this action")));;

@end


/*!
 *  Skippable video delegate
 */
@protocol AppodealSkippableVideoDelegate <NSObject>

@optional

/*!
 *  Method called when skippable video did load
 */
- (void)skippableVideoDidLoadAd;

/*!
 *  Mehtod called if skippable video mediation failed
 */
- (void)skippableVideoDidFailToLoadAd;

/*!
 *  Method called after skippable video start displaying
 */
- (void)skippableVideoDidPresent;

/*!
 *  Methof called before skippable video leave screen
 */
- (void)skippableVideoWillDismiss;

/*!
 *  Method called after fully watch of video, if user skipp video this callback not called
 *  @warning After call this method skippable video can stay on screen and show postbanner
 *  @warning Not all ad networks provides this callback!
 *
 */
- (void)skippableVideoDidFinish;

/*!
 *  Method called after user tap on screen
 *  @warning Not all ad networks provides this callback!
 */
- (void)skippableVideoDidClick;

@end


@protocol AppodealNativeAdDelegate <NSObject>

/*!
 *  Method called after native ads did load
 */
- (void)didLoadNativeAds:(NSInteger)count;

/*!
 *  Method called if native ads get some error while loading
 */
- (void)didFailToLoadNativeAdsWithError:(NSError *)error;

@end

/*!
 *  Appdoeal ads sdk
 */
@interface Appodeal : NSObject

+ (instancetype)alloc NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/*!
 *  @discussion To disable network use this method
 *  @discussion Use method before initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal disableNetworkForAdType:AppodealAdTypeInterstitial name:@"YOUR_NETWORK_NAME"]; @endcode
 *  @discussion Swift
 *  @code Appodeal.disableNetworkForAdType(AppodealAdType.Interstitial, name: "YOUR") @endcode
 *  @param adType      AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo, AppodealAdTypeBanner, AppodealAdTypeNativeAd, AppodealAdTypeRewardedVideo, AppodealAdTypeMREC, AppodealAdTypeNonSkippableVideo
 *  @param networkName Use network name
 */
+ (void)disableNetworkForAdType:(AppodealAdType)adType name:(NSString *)networkName __attribute__((deprecated("Now you can simple delete unused adapter from project")));

/*!
 *  @discussion To disable location check use this method (deprecated), use setLocationTracking:
 *  @discussion Objective-C
 *  @code [Appodeal disableLocationPermissionCheck]; @endcode
 *  @discussion Swift
 *  @code Appodeal.disableLocationPermissionCheck() @endcode
 */
+ (void)disableLocationPermissionCheck __attribute__((deprecated("use method setLocationTracking:")));

/*!
 *  @discussion To disable location check use this method
 *  @discussion Use method before initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setLocationTracking:YES]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setLocationTracking(true) @endcode
 *  @param enabled Set flag NO if you have disabled locationTracking, and YES that enabled
 */
+ (void)setLocationTracking:(BOOL)enabled;

/*!
 *  @discussion Enable/disable autocache
 *  @discussion Use method before initializtion!
 *  @discussion After initialization sdk start cache ads of those types that was enable as autocache
 *  Default autocache enabled for AppodealAdTypeInterstitial, AppodealAdTypeRewardedVideo or AppodealAdTypeNonSkippableVideo
 *  Also you can do something like this to disable autocache:
 *  @discussion Objective-C
 *  @code
    [Appodeal setAutocache: NO types: AppodealAdTypeInterstitial | AppodealAdTypeRewardedVideo]
 *  @endcode
 *  @discussion Swift
 *  @code Appodeal.setAutocache(false, types: AppodealAdType.Interstitial) @endcode
 *  @param autocache Bolean flag
 *  @param types     AppodealAdTypeRewardedVideo or AppodealAdTypeNonSkippableVideo, AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo
 */
+ (void)setAutocache:(BOOL)autocache types:(AppodealAdType)types;

/*!
 *  @discussion Getter of autocache enabling
 *  @discussion after initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal isAutocacheEnabled:AppodealAdTypeInterstitial]; @endcode
 *  @discussion Swift
 *  @code Appodeal.isAutocacheEnabled(AppodealAdType.Interstitial) @endcode
 *  @param types AppodealAdTypeRewardedVideo, AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo
 *
 *  @return If enabled return YES or NO if not
 */
+ (BOOL)isAutocacheEnabled:(AppodealAdType)types;

/*!
 *  @discussion Initialize method. To initialize appodeal with several types you
 *  @discussion can do something like this:
 *  @discussion Objective-C
 *  @code [Appodeal initializeWithApiKey:YOUR_API_KEY types: AppodealAdTypeInterstitial | AppodealAdTypeRewardedVideo]; @endcode
 *  @discussion Swift
 *  @code 
    let adTypes: AppodealAdType = [.banner, .interstitial]
    Appodeal.initialize(withApiKey: "API_KEY", types: adTypes) @endcode
 *  @param apiKey Your api key from Appodeal Dashboard
 *  @param types  Appodeal ad type
 */
+ (void)initializeWithApiKey:(NSString *)apiKey types:(AppodealAdType)types;

+ (void)deinitialize NS_UNAVAILABLE;

/*!
 *  @discussion Getter that sdk initialized
 *  @discussion Use method after initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal isInitalized]; @endcode
 *  @discussion Swift
 *  @code Appodeal.isInitalized() @endcode
 *  @return YES if sdk initialized or NO if not
 */
+ (BOOL)isInitalized;

/*!
 *  Appodeal supports multiple log level for internal logging,
 *  and ONLY one (VERBOSE) log level for third party ad networks.
 *  To enable third party ad networks logging set log level to APDLogLevelVerbose.
 *  If log level other than APDLogLevelVerbose, all third party ad networks logging will be suppressed (if possible).
 *
 *  @param logLevel APDLogLevel value
 */
+ (void)setLogLevel:(APDLogLevel)logLevel;

/*!
 *  @discussion Set framework type before initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setFramework:APDFrameworkNative]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setFramework(APDFramework.native) @endcode
 *  @param framework Framework type, default is iOS Native SDK
 */
+ (void)setFramework:(APDFramework)framework;

/*!
 *  @discussion Set plugin version use before initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setPluginVersion:@"1.0.0"]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setPluginVersion("1.0.0") @endcode
 *  @param pluginVersion -  NSString value, default nil
 */
+ (void)setPluginVersion:(NSString *)pluginVersion;

/*!
 *  @discussion Set interstital delegate to get callbacks
 *  @discussion Use method before or after initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setInterstitialDelegate:self]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setInterstitialDelegate(self) @endcode
 *  @param interstitialDelegate Object that implement AppodealInterstitialDelegate protocol
 */
+ (void)setInterstitialDelegate:(id<AppodealInterstitialDelegate>)interstitialDelegate;

/*!
 *  @discussion Set banner delegate to get callbacks
 *  @discussion Use method before or after initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setBannerDelegate:self]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setBannerDelegate(self) @endcode
 *  @param bannerDelegate Object that implement AppodealBannerDelegate protocol
 */
+ (void)setBannerDelegate:(id<AppodealBannerDelegate>)bannerDelegate;

/*!
 *  @discussion Set skippable video delegate to get callbacks
 *  @discussion Use method before or after initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setSkippableVideoDelegate:self]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setSkippableVideoDelegate(self) @endcode
 *  @param videoDelegate Object that implement AppodealSkippableVideoDelegate protocol
 */
+ (void)setSkippableVideoDelegate:(id<AppodealSkippableVideoDelegate>)videoDelegate;

/*!
 *  @discussion Set rewarded video delegate to get callbacks
 *  @discussion Use method before or after initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setRewardedVideoDelegate:self]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setRewardedVideoDelegate(self) @endcode
 *  @param rewardedVideoDelegate Object that implement AppodealRewardedVideoDelegate protocol
 */
+ (void)setRewardedVideoDelegate:(id<AppodealRewardedVideoDelegate>)rewardedVideoDelegate;

/*!
 *  @discussion Set non skippable video delegate to get callbacks
 *  @discussion Use method before or after initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setNonSkippableVideoDelegate:self]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setNonSkippableVideoDelegate(self) @endcode
 *  @param nonSkippableVideoDelegate Object that implement AppodealNonSkippableVideoDelegate protocol
 */
+ (void)setNonSkippableVideoDelegate:(id<AppodealNonSkippableVideoDelegate>)nonSkippableVideoDelegate;

/*!
 *  @discussion Set native ad delegate to get callbacks
 *  @discussion Use method before or after initializtion!
 *  @discussion Objective-C
 *  @code [Appodeal setNativeAdDelegate:self]; @endcode
 *  @discussion Swift
 *  @code Appodeal.setNativeAdDelegate(self) @endcode
 *  @param nativeAdDelegate Object that implement AppodealNonSkippableVideoDelegate protocol
 */
+ (void)setNativeAdDelegate:(id<AppodealNativeAdDelegate>)nativeAdDelegate;

/*!
 *  @discussion Appodeal banner view to custom placement
 *  @discussion Use method before or after initializtion!
 *  @warning We highly recommend to use APDSdk and APDBannerView if you want to get custom placement of banner ads in your app
 *
 *  @discussion Objective-C
 *  @code [Appodeal banner]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.banner() @endcode
 *
 *  @return View that contains banner ad
 */
+ (UIView *)banner;

/*!
 *  @discussion If ad of this type ready, ad show at once. But if not ad start caching and show after caching anyway if it have time to 3 seconds.
 *
 *  @discussion Objective-C
 *  @code [Appodeal showAd:AppodealAdTypeInterstitial rootViewController:UIViewController]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.showAd(AppodealShowStyle.Interstitial, rootViewController: UIViewController!) @endcode
 *
 *  @param style              AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo, AppodealAdTypeBanner, AppodealAdTypeNativeAd, AppodealAdTypeRewardedVideo, AppodealAdTypeMREC, AppodealAdTypeNonSkippableVideo
 *  @param rootViewController Controlled for present ads
 *
 *  @return YES if possible to show or NO if not
 */
+ (BOOL)showAd:(AppodealShowStyle)style rootViewController:(UIViewController *)rootViewController;

/*!
 *  @discussion - @sa + (BOOL)showAd:(AppodealShowStyle)style rootViewController:(UIViewController *)rootViewController;
 *
 *  @discussion Objective-C
 *  @code [Appodeal showAd:AppodealAdTypeInterstitial forPlacement:@"PLACEMENT" rootViewController:UIViewController]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.showAd(AppodealShowStyle.Interstitial, forPlacement: String!, rootViewController: UIViewController!) @endcode
 *
 *  @param style              AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo, AppodealAdTypeBanner, AppodealAdTypeNativeAd, AppodealAdTypeRewardedVideo, AppodealAdTypeMREC, AppodealAdTypeNonSkippableVideo
 *  @param placement          Placement name configured in segments settings on Appodeal Dashboard
 *  @param rootViewController Controller for present
 *
 *  @return YES if possible to show or NO if not
 */
+ (BOOL)showAd:(AppodealShowStyle)style forPlacement:(NSString *)placement rootViewController:(UIViewController *)rootViewController;

/*!
 @discussion Checker for ad is ready and can be show by current placement
 *
 *  @discussion Objective-C
 *  @code [Appodeal canShowAd:AppodealShowStyleInterstitial forPlacement:MY_PLACEMENT]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.canShowAd(AppodealShowStyle.Interstitial, forPlacement:MY_PLACEMENT) @endcode
 *
 *  @param style              AppodealShowStyleInterstitial, AppodealShowStyleRewardedVideo, AppodealShowStyleBannerBottom, AppodealShowStyleBannerTop, AppodealShowStyleNnonSkippableVideo
 *  @param placement          String placement name from dashboard
 *
 *  @return YES if possible to show or NO if not
 */
+ (BOOL)canShowAd:(AppodealShowStyle)style forPlacement:(NSString *)placement;

/*!
 *  @discussion Return rewars object currencyName as NSString, and amount as NSUInteger
 */
+ (id<APDReward>)rewardForPlacement:(NSString *)placement;

/*!
 *  @discussion Start cache ad for type if autocache disabled
 *  start load for default placement
 *  @discussion Ad will not be show after load
 *
 *  @discussion Objective-C
 *  @code [Appodeal cacheAd:AppodealAdTypeInterstitial]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.cacheAd(AppodealAdType.Interstitial) @endcode
 *
 *  @param type AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo, AppodealAdTypeBanner, AppodealAdTypeNativeAd, AppodealAdTypeRewardedVideo, AppodealAdTypeMREC, AppodealAdTypeNonSkippableVideo
 */
+ (void)cacheAd:(AppodealAdType)type;

/*!
 *  @discussion Start cache ad for type if autocache disabled
 *  start load for default placement
 *  @discussion Ad will not be show after load
 *
 *  @discussion Objective-C
 *  @code [Appodeal cacheAd:AppodealAdTypeInterstitial forPlacement: @"YOUR_PLACEMENT"]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.cacheAd(AppodealAdType.Interstitial, for: "YOUR_PLACEMENT") @endcode
 *
 *  @param type AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo, AppodealAdTypeBanner, AppodealAdTypeNativeAd, AppodealAdTypeRewardedVideo, AppodealAdTypeMREC, AppodealAdTypeNonSkippableVideo
 *  @param placement String placement that you configure in Appodeal dashboard
 */
+ (void)cacheAd:(AppodealAdType)type forPlacement:(NSString *)placement;

/*!
 *  @discussion Hide banner if it on screen
 *
 *  @discussion Objective-C
 *  @code [Appodeal hideBanner]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.hideBanner() @endcode
 *
 */
+ (void)hideBanner;

/*!
 *  @discussion Enable debug mode
 *
 *  @discussion Objective-C
 *  @code [Appodeal setDebugEnabled:YES]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setDebugEnabled(true) @endcode
 *
 *  @param debugEnabled Bolean flag
 */
+ (void)setDebugEnabled:(BOOL)debugEnabled;

/*!
 *  @discussion Enable testing mode.
 *  @discussion In this mode your will get test ad with <b>eCPM = 0$</b>
 *  @discussion Use method before initializtion!
 *
 *  @discussion Objective-C
 *  @code [Appodeal setTestingEnabled:YES]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setTestingEnabled(true) @endcode
 *
 *  @param testingEnabled Bolean flag
 */
+ (void)setTestingEnabled:(BOOL)testingEnabled;

/*!
 *  @discussion Reset UUID for tracking/targeting ad
 *  @discussion Use method before initializtion!
 *
 *  @discussion Objective-C
 *  @code [Appodeal resetUUID]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.resetUUID() @endcode
 *
 */
+ (void)resetUUID NS_UNAVAILABLE;

/*!
 *  Get current sdk version
 *
 *  @discussion Objective-C
 *  @code [Appodeal getVersion]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.getVersion() @endcode
 *
 *  @return Current sdk version
 */
+ (NSString *)getVersion;

/*!
 *  @discussion Check that ad is ready to show
 *
 *  @discussion Objective-C
 *  @code [Appodeal isReadyForShowWithStyle:AppodealShowStyleInterstitial]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.isReadyForShowWithStyle(AppodealShowStyle.Interstitial) @endcode
 *
 *  @param showStyle AppodealShowStyleInterstitial, AppodealShowStyleSkippableVideo, AppodealShowStyleVideoOrInterstitial, AppodealShowStyleBannerTop, AppodealShowStyleBannerBottom, AppodealShowStyleRewardedVideo, AppodealShowStyleNonSkippableVideo
 *
 *  @return YES if ready or NO if not
 */
+ (BOOL)isReadyForShowWithStyle:(AppodealShowStyle)showStyle;

/*!
 *  @discussion You can set custom rule by usage this method.
 *  Configure rules for segments in <b>Appodeal Dashboard</b>.
 *  @discussion For example, you want to use segment, when user complete 20 or more levels
 *  You create rule in dashboard with name "completedLevels" of type Int,
 *  operator GreaterThanOrEqualTo and value 10, now you implement folowing code:
 *
 *  @discussion Objective-C
 *  @code
    NSDictionary * customRule = {@"completedLevels" : CURRENT_NUMBER_OF_COMPLETED_LEVELS};
    [[APDSdk sharedSdk] setCustomRule: customRule];
 *  @endcode
 *
 *  @discussion Swift
 *  @code
    let customRule = ["completedLevels" : CURRENT_NUMBER_OF_COMPLETED_LEVELS]
    APDSdk .sharedSdk().setCustomRule(customRule)
 *  @endcode
 *
 *  Call this method any time you want, segments change dynamically
 *
 *  @discussion And then CURRENT_NUMBER_OF_COMPLETED_LEVELS become 10 or greater
 *  You segments settings become available
 *
 *  @param customRule NSDictionary instance with keys that similar to  keys that you tune in Appodeal Dashboard's Segment settings block and values of similar types
 */
+ (void)setCustomRule:(NSDictionary *)customRule;

/*!
 *  @discussion -
 *
 *  @discussion Objective-C
 *  @code [Appodeal confirmUsage:AppodealAdTypeInterstitial]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.confirmUsage(AppodealAdType.Interstitial) @endcode
 *
 *  @param adTypes AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo, AppodealAdTypeBanner, AppodealAdTypeNativeAd, AppodealAdTypeRewardedVideo, AppodealAdTypeMREC, AppodealAdTypeNonSkippableVideo
 */
+ (void)confirmUsage:(AppodealAdType)adTypes;

/*!
 *  @discussion Autoresized banner suport. Default set to YES;
 *  Call this method before caching banners!
 *
 *  @discussion Objective-C
 *  @code [Appodeal setSmartBannersEnabled:YES]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setSmartBannersEnabled(true) @endcode
 *
 *  @param smartBannerEnabled If YES banner will resize it depend of screen size, If NO banner has fixed size (320x50 on iPhone and 728x90 on iPad)
 */
+ (void)setSmartBannersEnabled:(BOOL)smartBannerEnabled;

/*!
 *  @discussion Banner background visibility setter. Default set to NO.
 *  Call this method before caching banners!
 *
 *  @discussion Objective-C
 *  @code [Appodeal setBannerBackgroundVisible:YES]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setBannerBackgroundVisible(true) @endcode
 *
 *  @param bannerBackgroundVisible If YES banner will have background, if NO banner background will be transparent
 */
+ (void)setBannerBackgroundVisible:(BOOL)bannerBackgroundVisible;

/*!
 *  @discussion Banner animation setter. Default set to YES
 *  Call this method before caching banners!
 *
 *  @discussion Objective-C
 *  @code [Appodeal setBannerAnimationEnabled:YES]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setBannerAnimationEnabled(true) @endcode
 *
 *  @param bannerAnimationEnabled If YES banner will refresh with animation (UIViewAnimationOptionTransitionCrossDissolve), if NO will refresh without animation;
 */
+ (void)setBannerAnimationEnabled:(BOOL)bannerAnimationEnabled;

/*!
 *  @discussion Start loading native ads of count that 
 *  You specified. If Appodeal sdk already contains ads, 
 *  this method clear all cached ads before loading new ads.
 *  We recommend to call this method once.
 *  When you grap ready ads, ad queue start replenish automatically
 *
 *
 *  @discussion Objective-C
 *  @code [Appodeal loadNaitveAd:APDNativeAdTypeAuto capacity:4]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.loadNaitveAd(APDNativeAdTypeAuto, capacity: 4) @endcode
 *
 *  @param type Type of native ad. Identified in APDNativeAdType enum;
 *  @param capacity Desired count of stored in cache native ads. Maximum value is 11;
 */
+ (void)loadNaitveAd:(APDNativeAdType)type capacity:(NSInteger)capacity;

/*!
 *  @discussion Get current available ads
 *  @param count - Desired count of native ads. Real returned array count can be less that this parameter
 */
+ (NSArray *)getNativeAdsOfCount:(NSInteger)count;

/*!
 *  @discussion Get current available ads count
 */
+ (NSInteger)availableNativeAdsCount;

/*!
 *  @discussion disable user data for adNetwork name
 *  @param networkName - adNetwork name as NSString @"NETWORK_NAME"
 */
+ (void)disableUserData:(NSString *)networkName;

/*!
 *  @discussion Enable memory monitoring for ad type. If current memory consuming higher than requiered level all caching ad objects will be released
 *  @warning loaded ad will return and could not be shown
 *
 *  @param percentage Minimum percent of RAM is free from 1 to 100. If NSNotFound memory monitor is unactive
 *  @param type Type of ad to use
 */
+ (void)setMinimumFreeMemoryPercentage:(NSUInteger)percentage forAdType:(AppodealAdType)type __attribute__((deprecated("Use -setMinimumFreeMemoryPercentage:observeSystemWarnings:forAdType: instead")));

/*!
 *  @discussion Enable memory monitoring for ad type. If current memory consuming higher than requiered level all caching ad objects will be released
 *  @warning loaded ad will return and could not be shown
 *
 *  @param percentage Minimum percent of RAM is free from 1 to 100. If NSNotFound memory monitor is unactive
 *  @param observeSystemWarnings Enabled observing of system memory warnings
 *  @param type Type of ad to use
 */
+ (void)setMinimumFreeMemoryPercentage:(NSUInteger)percentage
                 observeSystemWarnings:(BOOL)observeSystemWarnings
                             forAdType:(AppodealAdType)type;

@end

/*!
 *  Set user metada for right ad targeting
 */
@interface Appodeal (UserMetadata)

/*!
 *  @discussion User id setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserId:@"USER_ID"]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserId("USER_ID") @endcode
 *
 *  @param userId Set userId as string
 */
+ (void)setUserId:(NSString *)userId;

/*!
 *  @discussion User email setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserEmail:@"USER_EMAIL"]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserEmail("USER_EMAIL") @endcode
 *
 *  @param email Set userEmail as string
 */
+ (void)setUserEmail:(NSString *)email;

/*!
 *  @discussion User birthday setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserBirthday:[NSDate date]]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserBirthday(Date() as Date!) @endcode
 *
 *  @param birthday Set userBirthday as NSDate
 */
+ (void)setUserBirthday:(NSDate *)birthday;

/*!
 *  @discussion User age setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserAge:25]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserAge(25) @endcode
 *
 *  @param age Set age as integer value
 */
+ (void)setUserAge:(NSUInteger)age;

/*!
 *  @discussion User gender setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserGender:AppodealUserGenderMale]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserGender(AppodealUserGender.male) @endcode
 *
 *  @param gender AppodealUserGenderOther, AppodealUserGenderMale, AppodealUserGenderFemale
 */
+ (void)setUserGender:(AppodealUserGender)gender;

/*!
 *  @discussion User occupdation setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserOccupation:AppodealUserOccupationWork]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserOccupation(AppodealUserOccupation.work) @endcode
 *
 *  @param occupation AppodealUserOccupationOther, AppodealUserOccupationWork, AppodealUserOccupationSchool, AppodealUserOccupationUniversity
 */
+ (void)setUserOccupation:(AppodealUserOccupation)occupation;

/*!
 *  @discussion User relationship setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserRelationship:AppodealUserRelationshipMarried]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserRelationship(AppodealUserRelationship.married) @endcode
 *
 *  @param relationship AppodealUserRelationshipOther, AppodealUserRelationshipSingle, AppodealUserRelationshipDating, AppodealUserRelationshipEngaged, AppodealUserRelationshipMarried, AppodealUserRelationshipSearching
 */
+ (void)setUserRelationship:(AppodealUserRelationship)relationship;

/*!
 *  @discussion User smoking attitude setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNeutral]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserSmokingAttitude(AppodealUserSmokingAttitude.neutral) @endcode
 *
 *  @param smokingAttitude AppodealUserSmokingAttitudeNegative, AppodealUserSmokingAttitudeNeutral, AppodealUserSmokingAttitudePositive
 */
+ (void)setUserSmokingAttitude:(AppodealUserSmokingAttitude)smokingAttitude;

/*!
 *  @discussion User alcohol attitude
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNeutral]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserAlcoholAttitude(AppodealUserAlcoholAttitude.neutral) @endcode
 *
 *  @param alcoholAttitude AppodealUserAlcoholAttitudeNegative, AppodealUserAlcoholAttitudeNeutral, AppodealUserAlcoholAttitudePositive
 */
+ (void)setUserAlcoholAttitude:(AppodealUserAlcoholAttitude)alcoholAttitude;

/*!
 *  @discussion User interests setter
 *
 *  @discussion Objective-C
 *  @code [Appodeal setUserInterests:@"USER_INTERESTS"]; @endcode
 *
 *  @discussion Swift
 *  @code Appodeal.setUserInterests("USER_INTERESTS") @endcode
 *
 *  @param interests Set user interests as string
 */
+ (void)setUserInterests:(NSString *)interests;

@end
