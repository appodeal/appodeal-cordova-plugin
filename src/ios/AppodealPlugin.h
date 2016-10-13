#import <Cordova/CDV.h>
#import <Appodeal/Appodeal.h>

@interface AppodealPlugin : CDVPlugin <AppodealBannerDelegate, AppodealInterstitialDelegate, AppodealBannerDelegate, AppodealRewardedVideoDelegate, AppodealNonSkippableVideoDelegate, AppodealSkippableVideoDelegate>

- (void) disableNetworkType:(CDVInvokedUrlCommand*)command;
- (void) disableLocationPermissionCheck:(CDVInvokedUrlCommand*)command;
- (void) setAutoCache:(CDVInvokedUrlCommand*)command;
- (void) isPrecache:(CDVInvokedUrlCommand*)command;
- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) isInitalized:(CDVInvokedUrlCommand*)command;
- (void) enableInterstitialCallbacks:(CDVInvokedUrlCommand*)command;
- (void) enableBannerCallbacks:(CDVInvokedUrlCommand*)command;
- (void) enableSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) enableRewardedVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) enableNonSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command;
- (void) show:(CDVInvokedUrlCommand*)command;
- (void) showWithPlacement:(CDVInvokedUrlCommand*)command;
- (void) cache:(CDVInvokedUrlCommand*)command;
- (void) hide:(CDVInvokedUrlCommand*)command;
- (void) setLogging:(CDVInvokedUrlCommand*)command;
- (void) setTesting:(CDVInvokedUrlCommand*)command;
- (void) resetUUID:(CDVInvokedUrlCommand*)command;
- (void) getVersion:(CDVInvokedUrlCommand*)command;
- (void) isLoaded:(CDVInvokedUrlCommand*)command;
- (void) setCustomDoubleRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomIntegerRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomStringRule:(CDVInvokedUrlCommand*)command;
- (void) setCustomBooleanRule:(CDVInvokedUrlCommand*)command;
- (void) confirm:(CDVInvokedUrlCommand*)command;
- (void) setSmartBanners:(CDVInvokedUrlCommand*)command;
- (void) setBannerBackground:(CDVInvokedUrlCommand*)command;
- (void) setBannerAnimation:(CDVInvokedUrlCommand*)command;
- (void) setUserId:(CDVInvokedUrlCommand*)command;
- (void) setEmail:(CDVInvokedUrlCommand*)command;
- (void) setBirthday:(CDVInvokedUrlCommand*)command;
- (void) setAge:(CDVInvokedUrlCommand*)command;
- (void) setGender:(CDVInvokedUrlCommand*)command;
- (void) setOccupation:(CDVInvokedUrlCommand*)command;
- (void) setRelation:(CDVInvokedUrlCommand*)command;
- (void) setSmoking:(CDVInvokedUrlCommand*)command;
- (void) setAlcohol:(CDVInvokedUrlCommand*)command;
- (void) setInterests:(CDVInvokedUrlCommand*)command;

@end
