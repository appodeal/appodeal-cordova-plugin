#import <Cordova/CDV.h>
#import <Appodeal/Appodeal.h>

@interface AppodealPlugin : CDVPlugin <AppodealBannerDelegate, AppodealInterstitialDelegate, AppodealRewardedVideoDelegate, AppodealNonSkippableVideoDelegate>

@property (nonatomic, copy) NSString* interstitialCallbackID;
@property (nonatomic, copy) NSString* bannerCallbackID;
@property (nonatomic, copy) NSString* nonSkippbaleCallbackID;
@property (nonatomic, copy) NSString* rewardedCallbackID;

    
- (void) disableNetworkType:(CDVInvokedUrlCommand*)command;
- (void) disableLocationPermissionCheck:(CDVInvokedUrlCommand*)command;
- (void) setAutoCache:(CDVInvokedUrlCommand*)command;
- (void) isPrecache:(CDVInvokedUrlCommand*)command;
- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) isInitalized:(CDVInvokedUrlCommand*)command;
- (void) setInterstitialCallbacks:(CDVInvokedUrlCommand*)command;
- (void) setBannerCallbacks:(CDVInvokedUrlCommand*)command;
- (void) setRewardedVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) setNonSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) show:(CDVInvokedUrlCommand*)command;
- (void) canShow:(CDVInvokedUrlCommand*)command;
- (void) showWithPlacement:(CDVInvokedUrlCommand*)command;
- (void) cache:(CDVInvokedUrlCommand*)command;
- (void) hide:(CDVInvokedUrlCommand*)command;
- (void) setLogging:(CDVInvokedUrlCommand*)command;
- (void) setTesting:(CDVInvokedUrlCommand*)command;
- (void) getVersion:(CDVInvokedUrlCommand*)command;
- (void) isLoaded:(CDVInvokedUrlCommand*)command;
- (void) setCustomDoubleRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomIntegerRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomStringRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomBooleanRule:(CDVInvokedUrlCommand*)command;
- (void) setSmartBanners:(CDVInvokedUrlCommand*)command;
- (void) setBannerBackground:(CDVInvokedUrlCommand*)command;
- (void) setBannerAnimation:(CDVInvokedUrlCommand*)command;
- (void) setAge:(CDVInvokedUrlCommand*)command;
- (void) setGender:(CDVInvokedUrlCommand*)command;
- (void) setBannerOverLap:(CDVInvokedUrlCommand*)command;
    
@end