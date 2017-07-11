#import "AppodealPlugin.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

const int INTERSTITIAL        = 3;
const int BANNER              = 4;
const int BANNER_BOTTOM       = 8;
const int BANNER_TOP          = 16;
const int REWARDED_VIDEO      = 128;
const int NON_SKIPPABLE_VIDEO = 256;

float bannerHeight = 50.f;
float statusBarHeight = 20.f;

bool bannerOverlap;
bool bannerOverlapBottom;
bool bannerOverlapTop;
bool bannerIsShowing;
bool hasStatusBarPlugin = false;
bool isIphone;

NSString *CALLBACK_EVENT = @"event";
NSString *CALLBACK_INIT = @"onInit";
NSString *CALLBACK_LOADED = @"onLoaded";
NSString *CALLBACK_FAILED = @"onFailedToLoad";
NSString *CALLBACK_CLICKED = @"onClick";
NSString *CALLBACK_SHOWN = @"onShown";
NSString *CALLBACK_CLOSED = @"onClosed";
NSString *CALLBACK_FINISHED = @"onFinished";

bool isRewardedFinished = NO;
bool isNonSkippableFinished = NO;

int nativeAdTypesForType(int adTypes) {
    int nativeAdTypes = 0;
    
    if ((adTypes & INTERSTITIAL) > 0) {
        nativeAdTypes |= AppodealAdTypeInterstitial;
    }
    
    if ((adTypes & BANNER) > 0 ||
        (adTypes & BANNER_TOP) > 0 ||
        (adTypes & BANNER_BOTTOM) > 0) {
        
        nativeAdTypes |= AppodealAdTypeBanner;
    }
    
    if ((adTypes & REWARDED_VIDEO) > 0) {
        nativeAdTypes |= AppodealAdTypeRewardedVideo;
    }
    
    if ((adTypes & NON_SKIPPABLE_VIDEO) >0) {
        nativeAdTypes |= AppodealAdTypeNonSkippableVideo;
    }
    return nativeAdTypes;
}

int nativeShowStyleForType(int adTypes) {
    
    if ((adTypes & INTERSTITIAL) > 0) {
        return AppodealShowStyleInterstitial;
    }
    
    if ((adTypes & BANNER_TOP) > 0) {
        return AppodealShowStyleBannerTop;
    }
    
    if ((adTypes & BANNER_BOTTOM) > 0) {
        return AppodealShowStyleBannerBottom;
    }
    
    if ((adTypes & REWARDED_VIDEO) > 0) {
        return AppodealShowStyleRewardedVideo;
    }
    
    if ((adTypes & NON_SKIPPABLE_VIDEO) > 0) {
        return AppodealShowStyleNonSkippableVideo;
    }
    
    return 0;
}

@implementation AppodealPlugin

- (void)bannerDidLoadAdIsPrecache:(BOOL)precache
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_LOADED, @"isPrecache": [NSNumber numberWithBool:precache], @"height": @"0"};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.bannerCallbackID];
}

- (void)bannerDidFailToLoadAd
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_FAILED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.bannerCallbackID];
}

- (void)bannerDidClick
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_CLICKED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.bannerCallbackID];
}


- (void)bannerDidShow
{
    bannerIsShowing = true;
    if (bannerOverlap)
        [self changeWebViewWithOverlappedBanner];
    
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_SHOWN};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.bannerCallbackID];
}

// interstitial
- (void)interstitialDidLoadAdisPrecache:(BOOL)precache
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_LOADED, @"isPrecache": [NSNumber numberWithBool:precache]};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.interstitialCallbackID];
}

- (void)interstitialDidFailToLoadAd
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_FAILED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.interstitialCallbackID];
}

- (void)interstitialWillPresent
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_SHOWN};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.interstitialCallbackID];
}

- (void)interstitialDidDismiss
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_CLOSED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.interstitialCallbackID];
}

- (void)interstitialDidClick
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_CLICKED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.interstitialCallbackID];
}

// rewarded video
- (void)rewardedVideoDidLoadAd
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_LOADED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void)rewardedVideoDidFailToLoadAd
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_FAILED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void)rewardedVideoDidPresent
{
    isRewardedFinished = NO;
    
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_SHOWN};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void)rewardedVideoWillDismiss
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_CLOSED, @"finished": [NSNumber numberWithBool:isRewardedFinished]};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName
{
    isRewardedFinished = YES;
    
    NSMutableDictionary * rewardDict = [NSMutableDictionary new];
    rewardDict[CALLBACK_EVENT] = CALLBACK_FINISHED;
    rewardDict[@"rewardName"] = rewardName;
    rewardDict[@"rewardCount"] = @(rewardAmount);
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:rewardDict];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}


// non skippable video
- (void)nonSkippableVideoDidLoadAd
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_LOADED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void)nonSkippableVideoDidFailToLoadAd
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_FAILED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void)nonSkippableVideoDidPresent
{
    isNonSkippableFinished = NO;
    
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_SHOWN};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void)nonSkippableVideoWillDismiss
{
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_CLOSED, @"finished": [NSNumber numberWithBool:isNonSkippableFinished]};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void)nonSkippableVideoDidFinish
{
    isNonSkippableFinished = YES;
    
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_FINISHED};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}


- (void) disableNetworkType:(CDVInvokedUrlCommand*)command
{
    [Appodeal disableNetworkForAdType:nativeAdTypesForType([[[command arguments] objectAtIndex:1] intValue]) name:[[command arguments] objectAtIndex:0]];
}

- (void) disableLocationPermissionCheck:(CDVInvokedUrlCommand*)command
{
    [Appodeal setLocationTracking:NO];
}

- (void) setAutoCache:(CDVInvokedUrlCommand*)command
{
    [Appodeal setAutocache:[[[command arguments] objectAtIndex:1] boolValue] types:nativeAdTypesForType([[[command arguments] objectAtIndex:0] intValue])];
}

- (void) isPrecache:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal isAutocacheEnabled:nativeAdTypesForType([[[command arguments] objectAtIndex:0] intValue])])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) initialize:(CDVInvokedUrlCommand*)command
{
    [Appodeal setFramework:APDFrameworkCordova];
    if ([[[command arguments] objectAtIndex:1] intValue] & BANNER) {
        if (bannerOverlap) {
            [self setDelegateOnOverlap:(AppodealAdType)nativeAdTypesForType([[[command arguments] objectAtIndex:1] intValue])];
        }
        [self detectStatusBarPlugin];
        bannerHeight = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 90.f : 50.f);
        isIphone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? false : true);
    }
    [Appodeal initializeWithApiKey:[[command arguments] objectAtIndex:0] types:nativeAdTypesForType ([[[command arguments] objectAtIndex:1] intValue])];    
}

- (void) isInitalized:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal isInitalized])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setInterstitialCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setInterstitialDelegate:self];
    self.interstitialCallbackID = command.callbackId;
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_INIT};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.interstitialCallbackID];
}

- (void) setBannerCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerDelegate:self];
    self.bannerCallbackID = command.callbackId;
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_INIT};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.bannerCallbackID];
}

- (void) setRewardedVideoCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setRewardedVideoDelegate:self];
    self.rewardedCallbackID = command.callbackId;
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_INIT};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.rewardedCallbackID];
}

- (void) setNonSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setNonSkippableVideoDelegate:self];
    self.nonSkippbaleCallbackID = command.callbackId;
    NSDictionary *vals = @{CALLBACK_EVENT: CALLBACK_INIT};
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:vals];
    [pluginResult setKeepCallback:[NSNumber numberWithBool:YES]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.nonSkippbaleCallbackID];
}

- (void) show:(CDVInvokedUrlCommand*)command
{
    if (bannerOverlap) {
        if (([[[command arguments] objectAtIndex:0] intValue]) == 8) {
            if (bannerIsShowing)
                [self hide:command];
            bannerOverlapBottom = true;
            bannerOverlapTop = false;
        }
        else if (([[[command arguments] objectAtIndex:0] intValue]) == 16) {
            if (bannerIsShowing)
                [self hide:command];
            bannerOverlapBottom = false;
            bannerOverlapTop = true;
        }
    }
    CDVPluginResult* pluginResult = nil;
    if([Appodeal showAd:nativeShowStyleForType((int)[[[command arguments] objectAtIndex:0] integerValue]) rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) showWithPlacement:(CDVInvokedUrlCommand*)command
{
    if (bannerOverlap){
        if (([[[command arguments] objectAtIndex:0] intValue]) == 8) {
            if (bannerIsShowing)
                [self hide:command];
            bannerOverlapBottom = true;
            bannerOverlapTop = false;
        }
        else if (([[[command arguments] objectAtIndex:0] intValue]) == 16) {
            if (bannerIsShowing)
                [self hide:command];
            bannerOverlapBottom = false;
            bannerOverlapTop = true;
        }
    }
    CDVPluginResult* pluginResult = nil;
    if([Appodeal showAd:nativeShowStyleForType((int)[[[command arguments] objectAtIndex:0] intValue]) forPlacement:[[command arguments] objectAtIndex:1] rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) cache:(CDVInvokedUrlCommand*)command
{
    [Appodeal cacheAd:nativeAdTypesForType([[[command arguments] objectAtIndex:0] intValue])];
}

- (void) hide:(CDVInvokedUrlCommand*)command
{
    [Appodeal hideBanner];
    if (bannerOverlap && bannerIsShowing) {
        [self returnNativeSize];
    }
    bannerIsShowing = false;
}

- (void) setLogging:(CDVInvokedUrlCommand*)command
{
    [Appodeal setDebugEnabled:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) setTesting:(CDVInvokedUrlCommand*)command
{
    [Appodeal setTestingEnabled:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) getVersion:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[Appodeal getVersion]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) isLoaded:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal isReadyForShowWithStyle:nativeShowStyleForType([[[command arguments] objectAtIndex:0] intValue])])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) canShow:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal canShowAd:nativeShowStyleForType([[[command arguments] objectAtIndex:0] intValue]) forPlacement:[[command arguments] objectAtIndex:0]])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void) setCustomDoubleRule:(CDVInvokedUrlCommand*)command
{
    NSString *jsonString = [[command arguments] objectAtIndex:0];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [Appodeal setCustomRule:json];
}

- (void) setCustomIntegerRule:(CDVInvokedUrlCommand*)command
{
    NSString *jsonString = [[command arguments] objectAtIndex:0];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [Appodeal setCustomRule:json];
}

- (void) setCustomStringRule:(CDVInvokedUrlCommand*)command
{
    NSString *jsonString = [[command arguments] objectAtIndex:0];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [Appodeal setCustomRule:json];
}

- (void) setCustomBooleanRule:(CDVInvokedUrlCommand*)command
{
    NSString *jsonString = [[command arguments] objectAtIndex:0];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [Appodeal setCustomRule:json];
}

- (void) setSmartBanners:(CDVInvokedUrlCommand*)command
{
    [Appodeal setSmartBannersEnabled:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) setBannerBackground:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerBackgroundVisible:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) setBannerAnimation:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerAnimationEnabled:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) setAge:(CDVInvokedUrlCommand*)command
{
    [Appodeal setUserAge:[[[command arguments] objectAtIndex:0] integerValue]];
}

- (void) setGender:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserGender = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserGender isEqualToString:@"other"])
        [Appodeal setUserGender:AppodealUserGenderOther];
    if([AppodealUserGender isEqualToString:@"male"])
        [Appodeal setUserGender:AppodealUserGenderMale];
    if([AppodealUserGender isEqualToString:@"female"])
        [Appodeal setUserGender:AppodealUserGenderFemale];
}

//Banner overlap
- (void) setBannerOverLap:(CDVInvokedUrlCommand*)command
{
    if (![Appodeal isInitalized]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarDidChangeFrame:) name: UIApplicationDidChangeStatusBarFrameNotification object:nil];
            bannerOverlap = [[[command arguments] objectAtIndex:0] boolValue];
        if (hasStatusBarPlugin) {
            bannerOverlap = false;
        }
    }
}

- (void) returnNativeSize {
    CGRect bounds = [self.viewController.view.window bounds];
    if (CGRectEqualToRect(bounds, CGRectZero)) {
        bounds = [[UIScreen mainScreen] bounds];
    }
    if (CGRectEqualToRect(bounds, CGRectZero)) {
        bounds = [self.viewController.view bounds];
    }
    self.viewController.view.frame = bounds;
    [self.webView setFrame:bounds];
}

- (void) changeWebViewWithOverlappedBanner {
    CGRect bounds = [self.viewController.view.window bounds];
    if (CGRectEqualToRect(bounds, CGRectZero)) {
        bounds = [[UIScreen mainScreen] bounds];
    }
    if (CGRectEqualToRect(bounds, CGRectZero)) {
        bounds = [self.viewController.view bounds];
    }
    self.viewController.view.frame = bounds;
    if (hasStatusBarPlugin){
        statusBarHeight = 20.f;
    }
    else {
        if (isIphone && UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
            statusBarHeight = 0.f;
        else
            statusBarHeight = 20.f;
    }
    
    if (bannerOverlapTop) {
        [self.webView setFrame:CGRectMake(bounds.origin.x, bounds.origin.y + bannerHeight + statusBarHeight, bounds.size.width, bounds.size.height - bannerHeight - statusBarHeight)];
    }
    else if (bannerOverlapBottom) {
        [self.webView setFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height - bannerHeight)];
    }
}

- (void) statusBarDidChangeFrame:(NSNotification *)note
{
    if (bannerOverlap && bannerIsShowing)
        [self changeWebViewWithOverlappedBanner];
}

- (void) setDelegateOnOverlap:(AppodealAdType) types {
    switch (types) {
        case AppodealAdTypeBanner:
            [Appodeal setBannerDelegate:self];
        case AppodealAdTypeInterstitial:
            [Appodeal setInterstitialDelegate:self];
        case AppodealAdTypeRewardedVideo:
            [Appodeal setRewardedVideoDelegate:self];
        default:
            break;
    }
}

- (void)detectStatusBarPlugin {
    int numClasses;
    Class * classes = NULL;
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    
    if (numClasses > 0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            Class c = classes[i];
            NSString * className = NSStringFromClass(c);
            
            if ([className hasPrefix:@"CDVStatusBar"]) {
                hasStatusBarPlugin = true;
            }
        }
        free(classes);
    }
}

@end
