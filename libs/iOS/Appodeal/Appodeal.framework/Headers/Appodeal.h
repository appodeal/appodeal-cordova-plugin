//
//  Appodeal.h
//  Appodeal
//
//  Copyright (c) 2015 Appodeal, Inc. All rights reserved.
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
    AppodealAdTypeSkippableVideo    = 1 << 1,
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
typedef NS_ENUM(NSInteger, AppodealShowStyle) {
    /*!
     *  Show interstial ads
     */
    AppodealShowStyleInterstitial = 1,
    /*!
     *  Show skippable ads
     */
    AppodealShowStyleSkippableVideo,
    /*!
     *  - If both ready, show ad that eCPM heigher
     *  @discussion - If one of this types ready, show with ad
     *  @discussion - If no one ready, waiting for first ready
     */
    AppodealShowStyleVideoOrInterstitial,
    /*!
     *  Show banner at top of screen
     */
    AppodealShowStyleBannerTop,
    /*!
     *  Show banner at bottom of screen
     */
    AppodealShowStyleBannerBottom,
    /*!
     *  Show rewareded video
     */
    AppodealShowStyleRewardedVideo,
    /*!
     *  Show non skippable video
     */
    AppodealShowStyleNonSkippableVideo
};

typedef NS_ENUM(NSUInteger, AppodealUserGender) {
    AppodealUserGenderOther = 0,
    AppodealUserGenderMale,
    AppodealUserGenderFemale
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
 *  @brief Method called when banner did load and ready to show
 */
- (void)bannerDidLoadAd __attribute__((deprecated("Use -bannerDidLoadAdisPrecache:precache: instead")));

/*!
 *  Method called when banner refresh
 */
- (void)bannerDidRefresh;

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
 *  Nethod called if interstitial mediation failed
 */
- (void)interstitialDidFailToLoadAd;

/*!
 *  Method called when interstitial will diaplay on screen
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
- (void)rewardedVideoDidClick;

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
- (void)nonSkippableVideoDidClick;

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


/*!
 *  Appdoeal ads sdk
 */
@interface Appodeal : NSObject

+ (instancetype)alloc NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (void)disableNetworkForAdType:(AppodealAdType)adType name:(NSString *)networkName __attribute__((deprecated("Now you can simple delete unused adapter from project")));

/*!
 *  To disable location check use this method deprecated
 */
+ (void)disableLocationPermissionCheck __attribute__((deprecated("use method setLocationTracking:")));

/*!
 *  To disable location check use this method
 */
+ (void)setLocationTracking:(BOOL)enabled;

/*!
 *  Enable/disable autocache
 *  @discussion After initialization sdk start cache ads of those types that was enable as autocache
 *  Default autocache enabled for AppodealAdTypeInterstitial, AppodealAdTypeRewardedVideo
 *  Also you can do something like this to disable autocache:
 *  @code
    [Appodeal setAutocache: NO types: AppodealAdTypeInterstitial | AppodealAdTypeRewardedVideo]
 *  @endcode
 *  @param autocache Bolean flag
 *  @param types     AppodealAdTypeRewardedVideo, AppodealAdTypeInterstitial, AppodealAdTypeSkippableVideo
 */
+ (void)setAutocache:(BOOL)autocache types:(AppodealAdType)types;

/*!
 *  Getter of autocache enabling
 *
 *  @param types Type of ad
 *
 *  @return If enabled return YES or NO if not
 */
+ (BOOL)isAutocacheEnabled:(AppodealAdType)types;

/*!
 *  Initialize method. To initialize appodeal with several types you
 *  can do something like this:
 *  @code
 [Appodeal initializeWithApiKey:YOUR_API_KEY types: AppodealAdTypeInterstitial | AppodealAdTypeRewardedVideo]
 *  @endcode
 *  @param apiKey Your api key from Appodeal Dashboard
 *  @param types  Appodeal ad type
 */
+ (void)initializeWithApiKey:(NSString *)apiKey types:(AppodealAdType)types;

+ (void)deinitialize NS_UNAVAILABLE;

/*!
 *  Getter that sdk initialized
 *
 *  @return YES if sdk initialized or NO if not
 */
+ (BOOL)isInitalized;

/*!
 *  Set interstital delegate to get callbacks
 *
 *  @param interstitialDelegate Object that implement AppodealInterstitialDelegate protocol
 */
+ (void)setInterstitialDelegate:(id<AppodealInterstitialDelegate>)interstitialDelegate;

/*!
 *  Set banner delegate to get callbacks
 *
 *  @param bannerDelegate Object that implement AppodealBannerDelegate protocol
 */
+ (void)setBannerDelegate:(id<AppodealBannerDelegate>)bannerDelegate;

/*!
 *  Set skippable video delegate to get callbacks
 *
 *  @param videoDelegate Object that implement AppodealSkippableVideoDelegate protocol
 */
+ (void)setSkippableVideoDelegate:(id<AppodealSkippableVideoDelegate>)videoDelegate;

/*!
 *  Set rewarded video delegate to get callbacks
 *
 *  @param rewardedVideoDelegate Object that implement AppodealRewardedVideoDelegate protocol
 */
+ (void)setRewardedVideoDelegate:(id<AppodealRewardedVideoDelegate>)rewardedVideoDelegate;

/*!
 *  Set non skippable video delegate to get callbacks
 *
 *  @param nonSkippableVideoDelegate Object that implement AppodealNonSkippableVideoDelegate protocol
 */
+ (void)setNonSkippableVideoDelegate:(id<AppodealNonSkippableVideoDelegate>)nonSkippableVideoDelegate;

/*!
 *  Appodeal banner view to custom placement
 *  @warning We highly recommend to use APDSdk and APDBannerView if you want to get custom placement of banner ads in your app
 *
 *  @return View that contains banner ad
 */
+ (UIView *)banner;

/*!
 *  If ad of this type ready, ad show at once. But if not ad start caching and show after caching anyway if it have time to 3 seconds.
 *
 *  @param style              Show style
 *  @param rootViewController Controlled for present ads
 *
 *  @return YES if possible to show or NO if not
 */
+ (BOOL)showAd:(AppodealShowStyle)style rootViewController:(UIViewController *)rootViewController;

/*!
 *  @sa + (BOOL)showAd:(AppodealShowStyle)style rootViewController:(UIViewController *)rootViewController;
 *
 *  @param style              Show style
 *  @param placement          Placement name configured in segments settings on Appodeal Dashboard
 *  @param rootViewController Controller for present
 *
 *  @return YES if possible to show or NO if not
 */
+ (BOOL)showAd:(AppodealShowStyle)style forPlacement:(NSString *)placement rootViewController:(UIViewController *)rootViewController;

/*!
 *  Start cache ad for type if autocache disabled
 *  Ad will not be show after load
 *
 *  @param type Appodeal ad type
 */
+ (void)cacheAd:(AppodealAdType)type;

/*!
 *  Hide banner if it on screen
 */
+ (void)hideBanner;

/*!
 *  Enable debug mode
 *
 *  @param debugEnabled Bolean flag
 */
+ (void)setDebugEnabled:(BOOL)debugEnabled;

/*!
 *  Enable testing mode.
 *  In this mode your will get test ad with <b>eCPM = 0$</b>
 *
 *  @param testingEnabled Bolean flag
 */
+ (void)setTestingEnabled:(BOOL)testingEnabled;

/*!
 *  @brief Reset UUID for tracking/targeting ad
 */
+ (void)resetUUID;

/*!
 *  Get current sdk version
 *
 *  @return Current sdk version
 */
+ (NSString *)getVersion;

/*!
 *  Check that ad is ready to show
 *
 *  @param showStyle Show style
 *
 *  @return YES if ready or NO if not
 */
+ (BOOL)isReadyForShowWithStyle:(AppodealShowStyle)showStyle;

/*!
 *  You can set custom rule by usage this method.
 *  Configure rules for segments in <b>Appodeal Dashboard</b>.
 *  @discussion For example, you want to use segment, when user complete 20 or more levels
 *  You create rule in dashboard with name "completedLevels" of type Int,
 *  operator GreaterThanOrEqualTo and value 10, now you implement folowing code:
 *
 *  @code
 NSDictionary * customRule = {@"completedLevels" : CURRENT_NUMBER_OF_COMPLETED_LEVELS};
 [[APDSdk sharedSdk] setCustomRule: customRule];
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


+ (void)confirmUsage:(AppodealAdType)adTypes;

/*!
 *  @brief Autoresized banner suport. Default set to YES;
 *  Call this method before caching banners!
 *
 *  @param smartBannerEnabled If YES banner will resize it depend of screen size, If NO banner has fixed size (320x50 on iPhone and 728x90 on iPad)
 */
+ (void)setSmartBannersEnabled:(BOOL)smartBannerEnabled;

/*!
 *  @brief Banner background visibility setter. Default set to NO. 
 *  Call this method before caching banners!
 *
 *  @param bannerBackgroundVisible If YES banner will have background, if NO banner background will be transparent
 */
+ (void)setBannerBackgroundVisible:(BOOL)bannerBackgroundVisible;

/*!
 *  @brief Banner animation setter. Default set to YES
 *  Call this method before caching banners!
 *
 *  @param bannerAnimationEnabled If YES banner will refresh with animation (UIViewAnimationOptionTransitionCrossDissolve), if NO will refresh without animation;
 */
+ (void)setBannerAnimationEnabled:(BOOL)bannerAnimationEnabled;

@end

/*!
 *  Set user metada for right ad targeting
 */
@interface Appodeal (UserMetadata)

+ (void)setUserId:(NSString *)userId;
+ (void)setUserEmail:(NSString *)email;
+ (void)setUserBirthday:(NSDate *)birthday;
+ (void)setUserAge:(NSUInteger)age;
+ (void)setUserGender:(AppodealUserGender)gender;
+ (void)setUserOccupation:(AppodealUserOccupation)occupation;
+ (void)setUserRelationship:(AppodealUserRelationship)relationship;
+ (void)setUserSmokingAttitude:(AppodealUserSmokingAttitude)smokingAttitude;
+ (void)setUserAlcoholAttitude:(AppodealUserAlcoholAttitude)alcoholAttitude;
+ (void)setUserInterests:(NSString *)interests;

@end
