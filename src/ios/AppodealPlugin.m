#import "AppodealPlugin.h"
#import <UIKit/UIKit.h>

const int INTERSTITIAL        = 1;
const int SKIPPABLE_VIDEO     = 2;
const int BANNER              = 4;
const int NATIVE              = 8;
const int REWARDED_VIDEO      = 16;
const int MREC                = 32;
const int NON_SKIPPABLE_VIDEO = 64;

const int SHOW_INTERSTITIAL        = 1;
const int SHOW_SKIPPABLE_VIDEO     = 2;
const int SHOW_VIDEO_INTERSTITIAL  = 3;
const int SHOW_BANNER_TOP          = 4;
const int SHOW_BANNER_BOTTOM       = 5;
const int SHOW_REWARDED_VIDEO      = 6;
const int SHOW_NON_SKIPPABLE_VIDEO = 7;

@implementation AppodealPlugin

// banner
- (void)bannerDidLoadAdisPrecache:(BOOL)precache
{
    NSString* bool_;
    if(precache)
        bool_ = @"TRUE";
    else
        bool_ = @"FALSE";
    
    NSString* script = [NSString stringWithFormat:@"cordova.fireDocumentEvent('bannerDidLoadAdisPrecache', { precache: '%@' })", bool_];
    
    [self.webViewEngine evaluateJavaScript:script completionHandler:nil];
}

- (void)bannerDidRefresh
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('bannerDidRefresh')" completionHandler:nil];
}

- (void)bannerDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('bannerDidFailToLoadAd')" completionHandler:nil];
}

- (void)bannerDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('bannerDidClick')" completionHandler:nil];
}

- (void)bannerDidShow
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('bannerDidShow')" completionHandler:nil];
}

// interstitial
- (void)interstitialDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('interstitialDidLoadAd')" completionHandler:nil];
}

- (void)interstitialDidLoadAdisPrecache:(BOOL)precache
{
    NSString* bool_;
    if(precache)
        bool_ = @"TRUE";
    else
        bool_ = @"FALSE";
    
    NSString* script = [NSString stringWithFormat:@"cordova.fireDocumentEvent('interstitialDidLoadAdisPrecache', { precache: '%@' })", bool_];
    
    [self.webViewEngine evaluateJavaScript:script completionHandler:nil];
}

- (void)interstitialDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('interstitialDidFailToLoadAd')" completionHandler:nil];
}

- (void)interstitialWillPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('interstitialWillPresent')" completionHandler:nil];
}

- (void)interstitialDidDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('interstitialDidDismiss')" completionHandler:nil];
}

- (void)interstitialDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('interstitialDidClick')" completionHandler:nil];
}

// rewarded video
- (void)rewardedVideoDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('rewardedVideoDidLoadAd')" completionHandler:nil];
}

- (void)rewardedVideoDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('rewardedVideoDidFailToLoadAd')" completionHandler:nil];
}

- (void)rewardedVideoDidPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('rewardedVideoDidPresent')" completionHandler:nil];
}

- (void)rewardedVideoWillDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('rewardedVideoWillDismiss')" completionHandler:nil];
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName
{
    NSString* script = [NSString stringWithFormat:@"cordova.fireDocumentEvent('rewardedVideoDidFinish', { amount: %lu, name: '%@' })", rewardAmount, rewardName];
    [self.webViewEngine evaluateJavaScript:script completionHandler:nil];
}

- (void)rewardedVideoDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('rewardedVideoDidClick')" completionHandler:nil];
}

// non skippable video
- (void)nonSkippableVideoDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nonSkippableVideoDidLoadAd')" completionHandler:nil];
}

- (void)nonSkippableVideoDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nonSkippableVideoDidFailToLoadAd')" completionHandler:nil];
}

- (void)nonSkippableVideoDidPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nonSkippableVideoDidPresent')" completionHandler:nil];
}

- (void)nonSkippableVideoWillDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nonSkippableVideoWillDismiss')" completionHandler:nil];
}

- (void)nonSkippableVideoDidFinish
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nonSkippableVideoDidFinish')" completionHandler:nil];
}

- (void)nonSkippableVideoDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nonSkippableVideoDidClick')" completionHandler:nil];
}

// skippable video
- (void)skippableVideoDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('skippableVideoDidLoadAd')" completionHandler:nil];
}

- (void)skippableVideoDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('skippableVideoDidFailToLoadAd')" completionHandler:nil];
}

- (void)skippableVideoDidPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('skippableVideoDidPresent')" completionHandler:nil];
}

- (void)skippableVideoWillDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('skippableVideoWillDismiss')" completionHandler:nil];
}

- (void)skippableVideoDidFinish
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('skippableVideoDidFinish')" completionHandler:nil];
}

- (void)skippableVideoDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('skippableVideoDidClick')" completionHandler:nil];
}

- (void) disableNetworkType:(CDVInvokedUrlCommand*)command
{
    [Appodeal disableNetworkForAdType:[[[command arguments] objectAtIndex:1] integerValue] name:[[command arguments] objectAtIndex:0]];
}

- (void) disableLocationPermissionCheck:(CDVInvokedUrlCommand*)command
{
    [Appodeal disableLocationPermissionCheck];
}

- (void) setAutoCache:(CDVInvokedUrlCommand*)command
{
    [Appodeal setAutocache:[[[command arguments] objectAtIndex:1] boolValue] types:[[[command arguments] objectAtIndex:0] integerValue]];
}

- (void) isPrecache:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal isAutocacheEnabled:[[[command arguments] objectAtIndex:0] integerValue]])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) initialize:(CDVInvokedUrlCommand*)command
{
    [Appodeal initializeWithApiKey:[[command arguments] objectAtIndex:0] types:[[[command arguments] objectAtIndex:1] integerValue]];
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
    
    if([Appodeal showAd:[[[command arguments] objectAtIndex:0] integerValue] rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) showWithPlacement:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal showAd:[[[command arguments] objectAtIndex:0] integerValue] forPlacement:[[command arguments] objectAtIndex:1] rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) cache:(CDVInvokedUrlCommand*)command
{
    [Appodeal cacheAd:[[[command arguments] objectAtIndex:0] integerValue]];
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
    
    if([Appodeal isReadyForShowWithStyle:[[[command arguments] objectAtIndex:0] integerValue]])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setCustomRule:(CDVInvokedUrlCommand*)command
{
    //@"{\"valueNumber\":0,\"valueText\":\"text\"}"
    NSString *jsonString = [[command arguments] objectAtIndex:0];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [Appodeal setCustomRule:json];
}

- (void) confirm:(CDVInvokedUrlCommand*)command
{
    [Appodeal confirmUsage:[[[command arguments] objectAtIndex:0] integerValue]];
}

- (void) setSmartBanners:(CDVInvokedUrlCommand*)command
{
    [Appodeal setSmartBannersEnabled:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) setBannerBackgroundVisible:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerBackgroundVisible:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) setBannerAnimationEnabled:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerAnimationEnabled:[[[command arguments] objectAtIndex:0] boolValue]];
}

- (void) setUserId:(CDVInvokedUrlCommand*)command
{
    [Appodeal setUserEmail:[[command arguments] objectAtIndex:0]];
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
    
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderOther"])
        [Appodeal setUserGender:AppodealUserGenderOther];
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderMale"])
        [Appodeal setUserGender:AppodealUserGenderMale];
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderFemale"])
        [Appodeal setUserGender:AppodealUserGenderFemale];
}

- (void) setOccupation:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserOccupation = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserOccupation isEqualToString:@"AppodealUserOccupationOther"])
        [Appodeal setUserOccupation:AppodealUserOccupationOther];
    if([AppodealUserOccupation isEqualToString:@"AppodealUserOccupationWork"])
        [Appodeal setUserOccupation:AppodealUserOccupationWork];
    if([AppodealUserOccupation isEqualToString:@"AppodealUserOccupationSchool"])
        [Appodeal setUserOccupation:AppodealUserOccupationSchool];
    if([AppodealUserOccupation isEqualToString:@"AppodealUserOccupationUniversity"])
        [Appodeal setUserOccupation:AppodealUserOccupationUniversity];
}

- (void) setRelation:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserRelationship = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipOther"])
        [Appodeal setUserRelationship:AppodealUserRelationshipOther];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipSingle"])
        [Appodeal setUserRelationship:AppodealUserRelationshipSingle];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipDating"])
        [Appodeal setUserRelationship:AppodealUserRelationshipDating];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipEngaged"])
        [Appodeal setUserRelationship:AppodealUserRelationshipEngaged];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipMarried"])
        [Appodeal setUserRelationship:AppodealUserRelationshipMarried];
    if([AppodealUserRelationship isEqualToString:@"AppodealUserRelationshipSearching"])
        [Appodeal setUserRelationship:AppodealUserRelationshipSearching];
}

- (void) setSmoking:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserSmokingAttitude = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudeNegative"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNegative];
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudeNeutral"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNeutral];
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudePositive"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudePositive];
}

- (void) setAlcohol:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserAlcoholAttitude = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudeNegative"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNegative];
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudeNeutral"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNeutral];
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudePositive"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudePositive];
}

- (void) setInterests:(CDVInvokedUrlCommand*)command
{
    [Appodeal setUserInterests:[[command arguments] objectAtIndex:0]];
}

@end
