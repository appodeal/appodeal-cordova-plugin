#import "AppodealPlugin.h"
#import <UIKit/UIKit.h>

const int INTERSTITIAL        = 1;
const int VIDEO               = 2;
const int BANNER              = 4;
const int BANNER_BOTTOM       = 8;
const int BANNER_TOP          = 16;
const int REWARDED_VIDEO      = 128;
const int NON_SKIPPABLE_VIDEO = 256;

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
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onBannerLoaded')" completionHandler:nil];
}

- (void)bannerDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onBannerFailedToLoad')" completionHandler:nil];
}

- (void)bannerDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onBannerClicked')" completionHandler:nil];
}

- (void)bannerDidShow
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onBannerShown')" completionHandler:nil];
}

// interstitial
- (void)interstitialDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialLoaded')" completionHandler:nil];
}

- (void)interstitialDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialFailedToLoad')" completionHandler:nil];
}

- (void)interstitialWillPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialShown')" completionHandler:nil];
}

- (void)interstitialDidDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialClosed')" completionHandler:nil];
}

- (void)interstitialDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialClicked')" completionHandler:nil];
}

// rewarded video
- (void)rewardedVideoDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoLoaded')" completionHandler:nil];
}

- (void)rewardedVideoDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoFailedToLoad')" completionHandler:nil];
}

- (void)rewardedVideoDidPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoShown')" completionHandler:nil];
}

- (void)rewardedVideoWillDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoClosed')" completionHandler:nil];
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName
{
    NSString* script = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onRewardedVideoFinished', { amount: %lu, name: '%@' })", rewardAmount, rewardName];
    [self.webViewEngine evaluateJavaScript:script completionHandler:nil];
}

- (void)rewardedVideoDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoClicked')" completionHandler:nil];
}

// non skippable video
- (void)nonSkippableVideoDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onNonSkippableVideoLoaded')" completionHandler:nil];
}

- (void)nonSkippableVideoDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onNonSkippableVideoFailedToLoad')" completionHandler:nil];
}

- (void)nonSkippableVideoDidPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onNonSkippableVideoShown')" completionHandler:nil];
}

- (void)nonSkippableVideoWillDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onNonSkippableVideoClosed')" completionHandler:nil];
}

- (void)nonSkippableVideoDidFinish
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onNonSkippableVideoFinished')" completionHandler:nil];
}

- (void)nonSkippableVideoDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onNonSkippableVideoClicked')" completionHandler:nil];
}

// skippable video
- (void)skippableVideoDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onSkippableVideoLoaded')" completionHandler:nil];
}

- (void)skippableVideoDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onSkippableVideoFailedToLoad')" completionHandler:nil];
}

- (void)skippableVideoDidPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onSkippableVideoShown')" completionHandler:nil];
}

- (void)skippableVideoWillDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onSkippableVideoClosed')" completionHandler:nil];
}

- (void)skippableVideoDidFinish
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onSkippableVideoFinished')" completionHandler:nil];
}

- (void)skippableVideoDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onSkippableVideoClicked')" completionHandler:nil];
}

- (void) disableNetworkType:(CDVInvokedUrlCommand*)command
{
    [Appodeal disableNetworkForAdType:nativeAdTypesForType([[[command arguments] objectAtIndex:1] integerValue]) name:[[command arguments] objectAtIndex:0]];
}

- (void) disableLocationPermissionCheck:(CDVInvokedUrlCommand*)command
{
    [Appodeal disableLocationPermissionCheck];
}

- (void) setAutoCache:(CDVInvokedUrlCommand*)command
{
    [Appodeal setAutocache:[[[command arguments] objectAtIndex:1] boolValue] types:nativeAdTypesForType([[[command arguments] objectAtIndex:0] integerValue])];
}

- (void) isPrecache:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal isAutocacheEnabled:nativeAdTypesForType([[[command arguments] objectAtIndex:0] integerValue])])
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) initialize:(CDVInvokedUrlCommand*)command
{
    [Appodeal initializeWithApiKey:[[command arguments] objectAtIndex:0] types:nativeAdTypesForType([[[command arguments] objectAtIndex:1] integerValue])];
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
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal showAd:nativeShowStyleForType([[[command arguments] objectAtIndex:0] integerValue]) rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController])
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) showWithPlacement:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal showAd:nativeShowStyleForType([[[command arguments] objectAtIndex:0] integerValue]) forPlacement:[[command arguments] objectAtIndex:1] rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController])
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) cache:(CDVInvokedUrlCommand*)command
{
    [Appodeal cacheAd:nativeAdTypesForType([[[command arguments] objectAtIndex:0] integerValue])];
}

- (void) hide:(CDVInvokedUrlCommand*)command
{
    [Appodeal hideBanner];
}

- (void) setLogging:(CDVInvokedUrlCommand*)command
{
    [Appodeal setDebugEnabled:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) setTesting:(CDVInvokedUrlCommand*)command
{
    [Appodeal setTestingEnabled:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) resetUUID:(CDVInvokedUrlCommand*)command
{
    [Appodeal resetUUID];
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
    
    if([Appodeal isReadyForShowWithStyle:nativeShowStyleForType([[[command arguments] objectAtIndex:0] integerValue])])
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
    [Appodeal confirmUsage:nativeAdTypesForType([[[command arguments] objectAtIndex:0] integerValue])];
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

@end
