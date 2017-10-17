#import <Cordova/CDV.h>
#import <Appodeal/Appodeal.h>

@interface AppodealPlugin : CDVPlugin <AppodealBannerDelegate, APDBannerViewDelegate, AppodealInterstitialDelegate, AppodealRewardedVideoDelegate, AppodealNonSkippableVideoDelegate>

@property (nonatomic, copy) NSString* interstitialCallbackID;
@property (nonatomic, copy) NSString* bannerCallbackID;
@property (nonatomic, copy) NSString* nonSkippbaleCallbackID;
@property (nonatomic, copy) NSString* rewardedCallbackID;

- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) show:(CDVInvokedUrlCommand*)command;
- (void) showWithPlacement:(CDVInvokedUrlCommand*)command;
- (void) isLoaded:(CDVInvokedUrlCommand*)command;
- (void) cache:(CDVInvokedUrlCommand*)command;
- (void) hide:(CDVInvokedUrlCommand*)command;
- (void) setAutoCache:(CDVInvokedUrlCommand*)command;
- (void) isPrecache:(CDVInvokedUrlCommand*)command;

- (void) setBannerBackground:(CDVInvokedUrlCommand*)command;
- (void) setBannerAnimation:(CDVInvokedUrlCommand*)command;
- (void) setSmartBanners:(CDVInvokedUrlCommand*)command;
- (void) set728x90Banners:(CDVInvokedUrlCommand*)command;
- (void) setBannerOverLap:(CDVInvokedUrlCommand*)command;
- (void) setLogLevel:(CDVInvokedUrlCommand*)command;
- (void) setTesting:(CDVInvokedUrlCommand*)command;
- (void) setChildDirectedTreatment:(CDVInvokedUrlCommand*)command;
- (void) setTriggerOnLoadedOnPrecache:(CDVInvokedUrlCommand*)command;
- (void) disableNetwork:(CDVInvokedUrlCommand*)command;
- (void) disableNetworkType:(CDVInvokedUrlCommand*)command;
- (void) disableLocationPermissionCheck:(CDVInvokedUrlCommand*)command;
- (void) disableWriteExternalStoragePermissionCheck:(CDVInvokedUrlCommand*)command;
- (void) muteVideosIfCallsMuted:(CDVInvokedUrlCommand*)command;
- (void) showTestScreen:(CDVInvokedUrlCommand*)command;
- (void) getVersion:(CDVInvokedUrlCommand*)command;
- (void) setPluginVersion:(CDVInvokedUrlCommand*)command;
- (void) isInitalized:(CDVInvokedUrlCommand*)command;

- (void) canShow:(CDVInvokedUrlCommand*)command;
- (void) canShowWithPlacement:(CDVInvokedUrlCommand*)command;
- (void) setCustomDoubleRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomIntegerRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomStringRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomBooleanRule:(CDVInvokedUrlCommand*)command;
- (void) getRewardParameters:(CDVInvokedUrlCommand*)command;
- (void) getRewardParametersForPlacement:(CDVInvokedUrlCommand*)command;

- (void) setAge:(CDVInvokedUrlCommand*)command;
- (void) setGender:(CDVInvokedUrlCommand*)command;
- (void) setUserId:(CDVInvokedUrlCommand*)command;
- (void) trackInAppPurchase:(CDVInvokedUrlCommand*)command;

- (void) setInterstitialCallbacks:(CDVInvokedUrlCommand*)command;
- (void) setBannerCallbacks:(CDVInvokedUrlCommand*)command;
- (void) setRewardedVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) setNonSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command;

@end
