#import <Cordova/CDV.h>
#import <Appodeal/Appodeal.h>
//#import <Appodeal/AppodealNativeAd.h>
//#import <Appodeal/AppodealNativeAdService.h>

@interface AppodealPlugin : CDVPlugin <AppodealBannerDelegate, AppodealInterstitialDelegate, AppodealBannerDelegate, AppodealRewardedVideoDelegate, AppodealNonSkippableVideoDelegate, AppodealSkippableVideoDelegate>

//@property (nonatomic, strong) AppodealNativeAdViewAttributes* attributes;
//@property (nonatomic, strong) AppodealNativeAdService* adService;
//@property (nonatomic, strong) AppodealNativeAd* ad;
//@property (nonatomic, strong) AppodealNativeAdView* adView;
//@property (nonatomic, strong) UIView* myView;
//@property (nonatomic) NSInteger adViewType;
//@property (nonatomic) CGFloat x;
//@property (nonatomic) CGFloat y;

//- (void)attachToView:(CDVInvokedUrlCommand*)command;
//- (void)detachFromView:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_width_height:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_roundedIcon:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_sponsored:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_titleFont:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_descriptionFont:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_subtitleFont:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_buttonTitleFont:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_titleFontColor:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_descriptionFontColor:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_subtitleColor:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_buttonColor:(CDVInvokedUrlCommand*)command;
//- (void)setNativeAdAttributes_starRatingColor:(CDVInvokedUrlCommand*)command;
//- (void) loadNativeAd:(CDVInvokedUrlCommand*)command;

- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) enableInterstitialCallbacks:(CDVInvokedUrlCommand*)command;
- (void) show:(CDVInvokedUrlCommand*)command;
- (void) disableNetworkType:(CDVInvokedUrlCommand*)command;
- (void) disableLocationCheck:(CDVInvokedUrlCommand*)command;
- (void) setAutoCache:(CDVInvokedUrlCommand*)command;
- (void) isAutocacheEnabled:(CDVInvokedUrlCommand*)command;
- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) isInitalized:(CDVInvokedUrlCommand*)command;
- (void) enableInterstitialCallbacks:(CDVInvokedUrlCommand*)command;
- (void) enableBannerCallbacks:(CDVInvokedUrlCommand*)command;
- (void) enableSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) enableRewardedVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) enableNonSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) show:(CDVInvokedUrlCommand*)command;
- (void) showWithPlacement:(CDVInvokedUrlCommand*)command;
- (void) cacheBanner:(CDVInvokedUrlCommand*)command;
- (void) hide:(CDVInvokedUrlCommand*)command;
- (void) setDebugEnabled:(CDVInvokedUrlCommand*)command;
- (void) setTesting:(CDVInvokedUrlCommand*)command;
- (void) resetUUID:(CDVInvokedUrlCommand*)command;
- (void) getVersion:(CDVInvokedUrlCommand*)command;
- (void) isReadyForShowWithStyle:(CDVInvokedUrlCommand*)command;
- (void)setCustomRule:(CDVInvokedUrlCommand*)command;
- (void)confirm:(CDVInvokedUrlCommand*)command;
- (void) setSmartBanners:(CDVInvokedUrlCommand*)command;
- (void) setBannerBackgroundVisible:(CDVInvokedUrlCommand*)command;
- (void) setBannerAnimationEnabled:(CDVInvokedUrlCommand*)command;
- (void) setUserEmail:(CDVInvokedUrlCommand*)command;
- (void) setUserBirthday:(CDVInvokedUrlCommand*)command;
- (void) setUserAge:(CDVInvokedUrlCommand*)command;
- (void) setUserGender:(CDVInvokedUrlCommand*)command;
- (void) setUserOccupation:(CDVInvokedUrlCommand*)command;
- (void) setUserRelationship:(CDVInvokedUrlCommand*)command;
- (void) setUserSmokingAttitude:(CDVInvokedUrlCommand*)command;
- (void) setUserAlcoholAttitude:(CDVInvokedUrlCommand*)command;
- (void) setUserInterests:(CDVInvokedUrlCommand*)command;

@end