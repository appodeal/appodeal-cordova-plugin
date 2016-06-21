#import "AppodealPlugin.h"
#import <UIKit/UIKit.h>

const int INTERSTITIAL  = 1;
const int VIDEO         = 2;
const int BANNER        = 4;
const int BANNER_BOTTOM = 8;
const int BANNER_TOP    = 16;
const int BANNER_CENTER = 32;
const int ALL           = 255;
const int ANY           = 255;
const int REWARDED_VIDEO= 128;

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
        (adTypes & BANNER_CENTER) > 0 ||
        (adTypes & BANNER_BOTTOM) > 0) {
        
        nativeAdTypes |= AppodealAdTypeBanner;
    }
    
    if ((adTypes & REWARDED_VIDEO) > 0) {
        nativeAdTypes |= AppodealAdTypeRewardedVideo;
    }
    
    nativeAdTypes |= AppodealAdTypeNativeAd;
    
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
    
    if ((adTypes & BANNER_CENTER) > 0) {
        return AppodealShowStyleBannerCenter;
    }
    
    if ((adTypes & BANNER_BOTTOM) > 0) {
        return AppodealShowStyleBannerBottom;
    }
    
    if ((adTypes & REWARDED_VIDEO) > 0) {
        return AppodealShowStyleRewardedVideo;
    }
    
    return 0;
}

@implementation AppodealPlugin

- (void) disableLocationCheck:(CDVInvokedUrlCommand*)command
{
    [Appodeal disableLocationPermissionCheck];
}

-(AppodealNativeAdViewAttributes *) attributes
{
    if(!_attributes)
        _attributes=[[AppodealNativeAdViewAttributes alloc] init];
    return _attributes;
}

- (NSInteger)appodealAdViewTypeConvert:(NSString*) adViewType
{
    NSInteger adtype=1;
    if([adViewType isEqualToString:@"AppodealNativeAdTypeNewsFeed"])
        adtype=AppodealNativeAdTypeNewsFeed;
    if([adViewType isEqualToString:@"AppodealNativeAdTypeContentStream"])
        adtype=AppodealNativeAdTypeContentStream;
    if([adViewType isEqualToString:@"AppodealNativeAdType320x50"])
        adtype=AppodealNativeAdType320x50;
    if([adViewType isEqualToString:@"AppodealNativeAdType728x90"])
        adtype=AppodealNativeAdType728x90;
    
    return adtype;
}

- (void) loadNativeAd:(CDVInvokedUrlCommand*)command
{
    self.x = [[[command arguments] objectAtIndex:0] floatValue];
    self.y = [[[command arguments] objectAtIndex:1] floatValue];
    self.adViewType = [self appodealAdViewTypeConvert:[[command arguments] objectAtIndex:2]];
    self.adService = [[AppodealNativeAdService alloc] init];
    self.adService.delegate = self;
    [self.adService loadAd];
}

- (void)nativeAdServiceDidLoad: (AppodealNativeAd*) nativeAd{
    self.ad = nativeAd;
    self.attributes.width=320;
    self.attributes.heigth=50;
    self.adView = [AppodealNativeAdView nativeAdViewWithType:self.adViewType andNativeAd:self.ad andAttributes:self.attributes rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
    [self.adView setFrame: CGRectMake(self.x, self.y, self.attributes.width, self.attributes.heigth)];
    [self.webView addSubview:self.adView];
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nativeAdServiceDidLoad'); cordova.fireDocumentEvent('nativeAdServiceDidLoad')" completionHandler:nil];
}

- (void)attachToView:(CDVInvokedUrlCommand*)command
{
    [self.ad attachToView:self.adView viewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
}

- (void)detachFromView:(CDVInvokedUrlCommand*)command
{
    [self.ad detachFromView];
}

- (void)nativeAdServiceDidFailedToLoad
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nativeAdServiceDidFailedToLoad'); cordova.fireDocumentEvent('nativeAdServiceDidFailedToLoad')" completionHandler:nil];
}

- (void)nativeAdDidClick:(AppodealNativeAd *)nativeAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nativeAdDidClick'); cordova.fireDocumentEvent('nativeAdDidClick')" completionHandler:nil];
}

- (void)nativeAdDidPresent:(AppodealNativeAd *)nativeAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nativeAdDidPresent'); cordova.fireDocumentEvent('nativeAdDidPresent')" completionHandler:nil];
}

- (void)setNativeAdAttributes_width_height:(CDVInvokedUrlCommand*)command
{
    self.attributes.width=[[[command arguments] objectAtIndex:0] floatValue];
    self.attributes.heigth=[[[command arguments] objectAtIndex:1] floatValue];
}

- (void)setNativeAdAttributes_roundedIcon:(CDVInvokedUrlCommand*)command
{
    self.attributes.roundedIcon=[[[command arguments] objectAtIndex:0] boolValue];
}
- (void)setNativeAdAttributes_sponsored:(CDVInvokedUrlCommand*)command
{
    self.attributes.sponsored=[[[command arguments] objectAtIndex:0] boolValue];
}
//name, size
- (void)setNativeAdAttributes_titleFont:(CDVInvokedUrlCommand*)command
{
    self.attributes.titleFont=[UIFont fontWithName:[[command arguments] objectAtIndex:0] size:[[[command arguments] objectAtIndex:1] intValue]];
}
- (void)setNativeAdAttributes_descriptionFont:(CDVInvokedUrlCommand*)command
{
    self.attributes.descriptionFont=[UIFont fontWithName:[[command arguments] objectAtIndex:0] size:[[[command arguments] objectAtIndex:1] intValue]];
}
- (void)setNativeAdAttributes_subtitleFont:(CDVInvokedUrlCommand*)command
{
    self.attributes.subtitleFont=[UIFont fontWithName:[[command arguments] objectAtIndex:0] size:[[[command arguments] objectAtIndex:1] intValue]];
}
- (void)setNativeAdAttributes_buttonTitleFont:(CDVInvokedUrlCommand*)command
{
    self.attributes.buttonTitleFont=[UIFont fontWithName:[[command arguments] objectAtIndex:0] size:[[[command arguments] objectAtIndex:1] intValue]];
}
- (void)setNativeAdAttributes_titleFontColor:(CDVInvokedUrlCommand*)command
{
    self.attributes.titleFontColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
                                                   green:[[[command arguments] objectAtIndex:1] floatValue]
                                                    blue:[[[command arguments] objectAtIndex:2] floatValue]
                                                   alpha:[[[command arguments] objectAtIndex:3] floatValue]];
}
- (void)setNativeAdAttributes_descriptionFontColor:(CDVInvokedUrlCommand*)command
{
    self.attributes.descriptionFontColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
                                                         green:[[[command arguments] objectAtIndex:1] floatValue]
                                                          blue:[[[command arguments] objectAtIndex:2] floatValue]
                                                         alpha:[[[command arguments] objectAtIndex:3] floatValue]];
}
- (void)setNativeAdAttributes_subtitleColor:(CDVInvokedUrlCommand*)command
{
    self.attributes.subtitleColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
                                                  green:[[[command arguments] objectAtIndex:1] floatValue]
                                                   blue:[[[command arguments] objectAtIndex:2] floatValue]
                                                  alpha:[[[command arguments] objectAtIndex:3] floatValue]];
}
- (void)setNativeAdAttributes_buttonColor:(CDVInvokedUrlCommand*)command
{
    self.attributes.buttonColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
                                                green:[[[command arguments] objectAtIndex:1] floatValue]
                                                 blue:[[[command arguments] objectAtIndex:2] floatValue]
                                                alpha:[[[command arguments] objectAtIndex:3] floatValue]];
}
- (void)setNativeAdAttributes_starRatingColor:(CDVInvokedUrlCommand*)command
{
    self.attributes.starRatingColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
                                                    green:[[[command arguments] objectAtIndex:1] floatValue]
                                                     blue:[[[command arguments] objectAtIndex:2] floatValue]
                                                    alpha:[[[command arguments] objectAtIndex:3] floatValue]];
}

// banner

- (void)bannerDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onBannerLoaded'); cordova.fireDocumentEvent('onBannerDidLoadAd')" completionHandler:nil];
}

- (void)bannerDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onBannerFailedToLoad'); cordova.fireDocumentEvent('onBannerDidFailToLoadAd')" completionHandler:nil];
}

- (void)bannerDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onBannerClicked'); cordova.fireDocumentEvent('onBannerDidClick')" completionHandler:nil];
}

- (void)bannerDidShow
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onBannerDidShow')" completionHandler:nil];
}

// interstitial

- (void)interstitialDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialLoaded'); cordova.fireDocumentEvent('onInterstitialDidLoadAd')" completionHandler:nil];
}

- (void)interstitialDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialFailedToLoad'); cordova.fireDocumentEvent('onInterstitialDidFailToLoadAd')" completionHandler:nil];
}

- (void)interstitialWillPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialShown'); cordova.fireDocumentEvent('onInterstitialWillPresent')" completionHandler:nil];
}

- (void)interstitialDidDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialClosed'); cordova.fireDocumentEvent('onInterstitialDidDismiss')" completionHandler:nil];
}

- (void)interstitialDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onInterstitialClicked'); cordova.fireDocumentEvent('onInterstitialDidClick')" completionHandler:nil];
}

// video

- (void)videoDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onVideoLoaded'); cordova.fireDocumentEvent('onVideoDidLoadAd')" completionHandler:nil];
}

- (void)videoDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onVideoFailedToLoad'); cordova.fireDocumentEvent('onVideoDidFailToLoadAd')" completionHandler:nil];
}

- (void)videoDidPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onVideoShown'); cordova.fireDocumentEvent('onVideoDidPresent')" completionHandler:nil];
}

- (void)videoWillDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onVideoClosed'); cordova.fireDocumentEvent('onVideoWillDismiss')" completionHandler:nil];
}

- (void)videoDidFinish
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onVideoFinished'); cordova.fireDocumentEvent('onVideoDidFinish')" completionHandler:nil];
}

- (void)videoDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onVideoDidClick')" completionHandler:nil];
}

// rewarded video

- (void)rewardedVideoDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoDidLoadAd')" completionHandler:nil];
}

- (void)rewardedVideoDidFailToLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoDidFailToLoadAd')" completionHandler:nil];
}

- (void)rewardedVideoWillDismiss
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoWillDismiss')" completionHandler:nil];
}

- (void)rewardedVideoDidPresent
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoDidPresent')" completionHandler:nil];
}

- (void)rewardedVideoDidFinish:(NSUInteger)rewardAmount name:(NSString *)rewardName
{
    NSString* script = [NSString stringWithFormat:@"cordova.fireDocumentEvent('onRewardedVideoDidFinish', { amount: %d, name: '%@' })", rewardAmount, rewardName];
    [self.webViewEngine evaluateJavaScript:script completionHandler:nil];
}

- (void)rewardedVideoDidClick
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('onRewardedVideoDidClick')" completionHandler:nil];
}

- (void) enableInterstitialCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setInterstitialDelegate:self];
}

- (void) enableVideoCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setVideoDelegate:self];
}

- (void) enableBannerCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerDelegate:self];
}

- (void) enableRewardedVideoCallbacks:(CDVInvokedUrlCommand*)command
{
    [Appodeal setRewardedVideoDelegate:self];
}

- (void) isAutocacheEnabled:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    if([Appodeal isAutocacheEnabled:nativeAdTypesForType(ALL)])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) deinitialize:(CDVInvokedUrlCommand*)command
{
    [Appodeal deinitialize];
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

- (void) initialize:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"initialized"];
    
    //TODO nativeAdTypesForType(ALL)
    NSString* appKey = [[command arguments] objectAtIndex:0];
    [Appodeal initializeWithApiKey:appKey types:nativeAdTypesForType(ALL)];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) initializeAdType:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    
    NSString* appKey = [[command arguments] objectAtIndex:0];
    id adType = [[command arguments] objectAtIndex:1];
    [Appodeal initializeWithApiKey:appKey types:nativeAdTypesForType([adType integerValue])];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) testingEnabled:(CDVInvokedUrlCommand*)command
{
    BOOL testingEnabled = [[command arguments] objectAtIndex:0];
    [Appodeal setTestingEnabled:testingEnabled];
}

- (void) isReadyForShowWithStyle:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    id adType = [[command arguments] objectAtIndex:0];
    if([Appodeal isReadyForShowWithStyle:nativeShowStyleForType([adType integerValue])])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) isReadyWithPriceFloorForShowWithStyle:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    id adType = [[command arguments] objectAtIndex:0];
    if([Appodeal isReadyWithPriceFloorForShowWithStyle:nativeShowStyleForType([adType integerValue])])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)confirmUsage:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"ok"];
    
    id adType = [[command arguments] objectAtIndex:0];
    [Appodeal confirmUsage:nativeShowStyleForType([adType integerValue])];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) show:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    id adType = [[command arguments] objectAtIndex:0];
    
    if([Appodeal showAd:nativeShowStyleForType([adType integerValue]) rootViewController:self.viewController])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) showAdWithPriceFloor:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    id adType = [[command arguments] objectAtIndex:0];
    if([Appodeal showAdWithPriceFloor:nativeShowStyleForType([adType integerValue]) rootViewController:self.viewController])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) hide:(CDVInvokedUrlCommand*)command
{
    [Appodeal hideBanner];
    //  if((nativeAdTypesForType([adType integerValue]) & (1 << 2)) > 0)
    //  {
    //  }
}

- (void) cacheAd:(CDVInvokedUrlCommand*)command
{
    id adType = [[command arguments] objectAtIndex:0];
    [Appodeal cacheAd:nativeShowStyleForType([adType integerValue])];
}

- (void) getVersion:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[Appodeal getVersion]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) setAutoCache:(CDVInvokedUrlCommand*)command
{
    id adType = [[command arguments] objectAtIndex:0];
    id autoCache = [[command arguments] objectAtIndex:1];
    // nothing
    [Appodeal setAutocache:[autoCache boolValue] types:nativeAdTypesForType([adType integerValue])];
    
}

- (void) disableNetwork:(CDVInvokedUrlCommand*)command
{
    NSString* network = [[command arguments] objectAtIndex:0];
    [Appodeal disableNetworkForAdType:AppodealAdTypeAll name:network];
}

- (void) setUserId:(CDVInvokedUrlCommand*)command
{
    NSString* userId = [[command arguments] objectAtIndex:0];
    [Appodeal setUserId:userId];
}

- (void) setUserVkId:(CDVInvokedUrlCommand*)command
{
    NSString* userId = [[command arguments] objectAtIndex:0];
    [Appodeal setUserVkId:userId];
}

- (void) setUserFacebookId:(CDVInvokedUrlCommand*)command
{
    NSString* userId = [[command arguments] objectAtIndex:0];
    [Appodeal setUserFacebookId:userId];
}

- (void) setUserEmail:(CDVInvokedUrlCommand*)command
{
    NSString* userId = [[command arguments] objectAtIndex:0];
    [Appodeal setUserEmail:userId];
}

- (void) setUserBirthday:(CDVInvokedUrlCommand*)command
{
    //format "1996-12-19T16:39:57-08:00"
    //NSString *string = [[command arguments] objectAtIndex:0];
    //NSDate *date = [RFC3339DateFormatter dateFromString:string];
    //[Appodeal setUserBirthday:date];
}

- (void) setUserAge:(CDVInvokedUrlCommand*)command
{
    //  NSUInteger* age = [[command arguments] objectAtIndex:0];
    //  [Appodeal setUserAge:age];
}

- (void) setUserGender:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserGender = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderOther"])
        [Appodeal setUserGender:AppodealUserGenderOther];
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderMale"])
        [Appodeal setUserGender:AppodealUserGenderMale];
    if([AppodealUserGender isEqualToString:@"AppodealUserGenderFemale"])
        [Appodeal setUserGender:AppodealUserGenderFemale];
}

- (void) setUserOccupation:(CDVInvokedUrlCommand*)command
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

- (void) setUserRelationship:(CDVInvokedUrlCommand*)command
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

- (void) setUserSmokingAttitude:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserSmokingAttitude = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudeNegative"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNegative];
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudeNeutral"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudeNeutral];
    if([AppodealUserSmokingAttitude isEqualToString:@"AppodealUserSmokingAttitudePositive"])
        [Appodeal setUserSmokingAttitude:AppodealUserSmokingAttitudePositive];
}

- (void) setUserAlcoholAttitude:(CDVInvokedUrlCommand*)command
{
    NSString *AppodealUserAlcoholAttitude = [[command arguments] objectAtIndex:0];
    
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudeNegative"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNegative];
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudeNeutral"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudeNeutral];
    if([AppodealUserAlcoholAttitude isEqualToString:@"AppodealUserAlcoholAttitudePositive"])
        [Appodeal setUserAlcoholAttitude:AppodealUserAlcoholAttitudePositive];
}

- (void) setUserInterests:(CDVInvokedUrlCommand*)command
{
    NSString* Interests = [[command arguments] objectAtIndex:0];
    [Appodeal setUserInterests:Interests];
}

@end
