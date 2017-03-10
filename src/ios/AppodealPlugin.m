#import "AppodealPlugin.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

const int INTERSTITIAL        = 1;
const int VIDEO               = 2;
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


int nativeAdTypesForType(int adTypes) {
    int nativeAdTypes = 0;
    
    if ((adTypes & INTERSTITIAL) > 0) {
        nativeAdTypes |= AppodealAdTypeInterstitial;
    }
    
    if ((adTypes & VIDEO) > 0) {
        nativeAdTypes |= AppodealAdTypeSkippableVideo;
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
    bool isInterstitial = (adTypes & INTERSTITIAL) > 0;
    bool isVideo = (adTypes & VIDEO) > 0;
    
    if (isInterstitial && isVideo) {
        return AppodealShowStyleVideoOrInterstitial;
    } else if (isVideo) {
        return AppodealShowStyleSkippableVideo;
    } else if (isInterstitial) {
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

- (void)bannerDidLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onBannerLoaded')"];
}

- (void)bannerDidFailToLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onBannerFailedToLoad')"];
}

- (void)bannerDidClick
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onBannerClicked')"];
}


- (void)bannerDidShow
{
    bannerIsShowing = true;
    if (bannerOverlap)
        [self changeWebViewWithOverlappedBanner];
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onBannerShown')"];
}

// interstitial
- (void)interstitialDidLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onInterstitialLoaded')"];
}

- (void)interstitialDidFailToLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onInterstitialFailedToLoad')"];
}

- (void)interstitialWillPresent
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onInterstitialShown')"];
}

- (void)interstitialDidDismiss
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onInterstitialClosed')"];
}

- (void)interstitialDidClick
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onInterstitialClicked')"];
}

// rewarded video
- (void)rewardedVideoDidLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onRewardedVideoLoaded')"];
}

- (void)rewardedVideoDidFailToLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onRewardedVideoFailedToLoad')"];
}

- (void)rewardedVideoDidPresent
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onRewardedVideoShown')"];
}

- (void)rewardedVideoWillDismiss
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onRewardedVideoClosed')"];
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName
{
    NSString* script = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onRewardedVideoFinished', { amount: %lu, name: '%@' })", rewardAmount, rewardName];
    [self.commandDelegate evalJs:script];
}

- (void)rewardedVideoDidClick
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onRewardedVideoClicked')"];
}

// non skippable video
- (void)nonSkippableVideoDidLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onNonSkippableVideoLoaded')"];
}

- (void)nonSkippableVideoDidFailToLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onNonSkippableVideoFailedToLoad')"];
}

- (void)nonSkippableVideoDidPresent
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onNonSkippableVideoShown')"];
}

- (void)nonSkippableVideoWillDismiss
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onNonSkippableVideoClosed')"];
}

- (void)nonSkippableVideoDidFinish
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onNonSkippableVideoFinished')"];
}

- (void)nonSkippableVideoDidClick
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onNonSkippableVideoClicked')"];
}

// skippable video
- (void)skippableVideoDidLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onSkippableVideoLoaded')"];
}

- (void)skippableVideoDidFailToLoadAd
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onSkippableVideoFailedToLoad')"];
}

- (void)skippableVideoDidPresent
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onSkippableVideoShown')"];
}

- (void)skippableVideoWillDismiss
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onSkippableVideoClosed')"];
}

- (void)skippableVideoDidFinish
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onSkippableVideoFinished')"];
}

- (void)skippableVideoDidClick
{
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('onSkippableVideoClicked')"];
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
    if (![Appodeal isInitalized])
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

- (void) enableInterstitialCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setInterstitialDelegate:self];
}

- (void) enableBannerCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerDelegate:self];
}

- (void) enableSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setSkippableVideoDelegate:self];
}

- (void) enableRewardedVideoCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setRewardedVideoDelegate:self];
}

- (void) enableNonSkippableVideoCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setNonSkippableVideoDelegate:self];
}

- (void) show:(CDVInvokedUrlCommand*)command
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
    [Appodeal showAd:nativeShowStyleForType((int)[[[command arguments] objectAtIndex:0] integerValue]) rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
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

- (void) confirm:(CDVInvokedUrlCommand*)command
{
    [Appodeal confirmUsage:nativeAdTypesForType([[[command arguments] objectAtIndex:0] intValue])];
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

- (void) setUserId:(CDVInvokedUrlCommand*)command
{
    [Appodeal setUserId:[[command arguments] objectAtIndex:0]];
}

- (void) setEmail:(CDVInvokedUrlCommand*)command
{
    [Appodeal setUserEmail:[[command arguments] objectAtIndex:0]];
}

- (void) setBirthday:(CDVInvokedUrlCommand*)command
{
    NSString *dateString = [[command arguments] objectAtIndex:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [Appodeal setUserBirthday:dateFromString];
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

- (void) setOccupation:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserOccupation = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserOccupation isEqualToString:@"other"])
        [Appodeal setUserOccupation:AppodealUserOccupationOther];
    if([AppodealUserOccupation isEqualToString:@"work"])
        [Appodeal setUserOccupation:AppodealUserOccupationWork];
    if([AppodealUserOccupation isEqualToString:@"school"])
        [Appodeal setUserOccupation:AppodealUserOccupationSchool];
    if([AppodealUserOccupation isEqualToString:@"university"])
        [Appodeal setUserOccupation:AppodealUserOccupationUniversity];
}

- (void) setRelation:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserRelationship = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserRelationship isEqualToString:@"other"])
        [Appodeal setUserRelationship:AppodealUserRelationshipOther];
    if([AppodealUserRelationship isEqualToString:@"single"])
        [Appodeal setUserRelationship:AppodealUserRelationshipSingle];
    if([AppodealUserRelationship isEqualToString:@"dating"])
        [Appodeal setUserRelationship:AppodealUserRelationshipDating];
    if([AppodealUserRelationship isEqualToString:@"engaged"])
        [Appodeal setUserRelationship:AppodealUserRelationshipEngaged];
    if([AppodealUserRelationship isEqualToString:@"married"])
        [Appodeal setUserRelationship:AppodealUserRelationshipMarried];
    if([AppodealUserRelationship isEqualToString:@"searching"])
        [Appodeal setUserRelationship:AppodealUserRelationshipSearching];
}

- (void) setSmoking:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserSmokingAttitude = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserSmokingAttitude isEqualToString:@"negative"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNegative];
    if([AppodealUserSmokingAttitude isEqualToString:@"neutral"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNeutral];
    if([AppodealUserSmokingAttitude isEqualToString:@"positive"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudePositive];
}

- (void) setAlcohol:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserAlcoholAttitude = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserAlcoholAttitude isEqualToString:@"negative"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNegative];
    if([AppodealUserAlcoholAttitude isEqualToString:@"neutral"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNeutral];
    if([AppodealUserAlcoholAttitude isEqualToString:@"positive"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudePositive];
}

- (void) setInterests:(CDVInvokedUrlCommand*)command
{
    [Appodeal setUserInterests:[[command arguments] objectAtIndex:0]];
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
        case AppodealAdTypeSkippableVideo:
            [Appodeal setSkippableVideoDelegate:self];
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
