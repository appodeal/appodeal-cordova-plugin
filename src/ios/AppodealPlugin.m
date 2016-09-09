#import "AppodealPlugin.h"
#import <UIKit/UIKit.h>

const int INTERSTITIAL  = 1;
//skippable
const int VIDEO         = 2;
const int BANNER        = 4;
const int BANNER_BOTTOM = 8;
const int BANNER_TOP    = 16;
const int BANNER_CENTER = 32;
const int NATIVE        = 64;
const int REWARDED_VIDEO= 128;
const int MREC          = 256;
const int NON_SKIPPABLE_VIDEO= 512;

const int SHOW_INTERSTITIAL  = 1;
//skippable
const int SHOW_VIDEO         = 2;
const int SHOW_VIDEO_INTERSTITIAL = 3;
const int SHOW_BANNER_TOP    = 4;
const int SHOW_BANNER_BOTTOM = 5;
const int SHOW_REWARDED_VIDEO= 6;
const int SHOW_NON_SKIPPABLE_VIDEO= 7;

int nativeAdTypesForType(int adTypes) {
    int types = 0;

    if ((adTypes & INTERSTITIAL) > 0)
        types |= AppodealAdTypeInterstitial;

    if ((adTypes & VIDEO) > 0)
        types |= AppodealAdTypeSkippableVideo;

    if ((adTypes & BANNER) > 0 ||
        (adTypes & BANNER_TOP) > 0 ||
        (adTypes & BANNER_CENTER) > 0 ||
        (adTypes & BANNER_BOTTOM) > 0) {
        
        types |= AppodealAdTypeBanner;
    }

    if ((adTypes & NATIVE) > 0)
        types |= AppodealAdTypeNativeAd;

    if ((adTypes & REWARDED_VIDEO) > 0)
        types |= AppodealAdTypeRewardedVideo;

    if ((adTypes & MREC) > 0)
        types |= AppodealAdTypeMREC;

    if ((adTypes & NON_SKIPPABLE_VIDEO) > 0)
        types |= AppodealAdTypeNonSkippableVideo;

    return types;
}

@implementation AppodealPlugin

- (void)bannerDidLoadAd
{
    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('bannerDidLoadAd')" completionHandler:nil];
}

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
//deprecated
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

//non skippable video
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

//skippable video
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
//callbacks

//deprecated
- (void) disableNetworkType:(CDVInvokedUrlCommand*)command
{
    [Appodeal disableNetworkForAdType:nativeAdTypesForType([[[command arguments] objectAtIndex:1] integerValue]) name:[[command arguments] objectAtIndex:0]];
}

- (void) disableLocationCheck:(CDVInvokedUrlCommand*)command
{
    [Appodeal disableLocationPermissionCheck];
}

- (void) setAutoCache:(CDVInvokedUrlCommand*)command
{
    [Appodeal setAutocache:[[[command arguments] objectAtIndex:1] boolValue] types:nativeAdTypesForType([[[command arguments] objectAtIndex:0] integerValue])];
}

- (void) isAutocacheEnabled:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    if([Appodeal isAutocacheEnabled:nativeAdTypesForType([[command arguments] objectAtIndex:0])])
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

    if([Appodeal showAd: nativeAdTypesForType([[[command arguments] objectAtIndex:0] integerValue]) rootViewController:self.viewController])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) showWithPlacement:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    if([Appodeal showAd:[[[command arguments] objectAtIndex:0] integerValue] forPlacement:[[command arguments] objectAtIndex:1] rootViewController:self.viewController])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) cacheBanner:(CDVInvokedUrlCommand*)command
{
    [Appodeal cacheAd:nativeAdTypesForType([[[command arguments] objectAtIndex:0] integerValue])];
}

- (void) hide:(CDVInvokedUrlCommand*)command
{
    [Appodeal hideBanner];
}

- (void) setDebugEnabled:(CDVInvokedUrlCommand*)command
{
    [Appodeal setDebugEnabled:[[command arguments] objectAtIndex:0]];
}

- (void) setTesting:(CDVInvokedUrlCommand*)command
{
    [Appodeal setTestingEnabled:[[command arguments] objectAtIndex:0]];
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

- (void) isReadyForShowWithStyle:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    id adType = [[command arguments] objectAtIndex:0];
    if([Appodeal isReadyForShowWithStyle:[[[command arguments] objectAtIndex:0] integerValue]])
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    else
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setCustomRule:(CDVInvokedUrlCommand*)command
{
    [Appodeal setCustomRule:[[command arguments] objectAtIndex:0]];
}

- (void)confirm:(CDVInvokedUrlCommand*)command
{
    [Appodeal confirmUsage:nativeAdTypesForType([[command arguments] objectAtIndex:0])];
}

- (void) setSmartBanners:(CDVInvokedUrlCommand*)command
{
    [Appodeal setSmartBannersEnabled:[[command arguments] objectAtIndex:0]];
}

- (void) setBannerBackgroundVisible:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerBackgroundVisible:[[command arguments] objectAtIndex:0]];
}

- (void) setBannerAnimationEnabled:(CDVInvokedUrlCommand*)command
{
    [Appodeal setBannerAnimationEnabled:[[command arguments] objectAtIndex:0]];
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
    [Appodeal setUserAge:[[command arguments] objectAtIndex:0]];
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
    [Appodeal setUserInterests:[[command arguments] objectAtIndex:0]];
}



//-(AppodealNativeAdViewAttributes *) attributes
//{
//    if(!_attributes)
//        _attributes=[[AppodealNativeAdViewAttributes alloc] init];
//    return _attributes;
//}
//
//- (NSInteger)appodealAdViewTypeConvert:(NSString*) adViewType
//{
//    NSInteger adtype=1;
//    if([adViewType isEqualToString:@"AppodealNativeAdTypeNewsFeed"])
//        adtype=AppodealNativeAdTypeNewsFeed;
//    if([adViewType isEqualToString:@"AppodealNativeAdTypeContentStream"])
//        adtype=AppodealNativeAdTypeContentStream;
//    if([adViewType isEqualToString:@"AppodealNativeAdType320x50"])
//        adtype=AppodealNativeAdType320x50;
//    if([adViewType isEqualToString:@"AppodealNativeAdType728x90"])
//        adtype=AppodealNativeAdType728x90;
//
//    return adtype;
//}
//
//- (void) loadNativeAd:(CDVInvokedUrlCommand*)command
//{
//    self.x = [[[command arguments] objectAtIndex:0] floatValue];
//    self.y = [[[command arguments] objectAtIndex:1] floatValue];
//    self.adViewType = [self appodealAdViewTypeConvert:[[command arguments] objectAtIndex:2]];
//    self.adService = [[AppodealNativeAdService alloc] init];
//    self.adService.delegate = self;
//    [self.adService loadAd];
//}
//
//- (void)nativeAdServiceDidLoad: (AppodealNativeAd*) nativeAd{
//    self.ad = nativeAd;
//    self.myView = [[UIView alloc] init];
//    [self.myView setFrame: CGRectMake(10, 350, 200, 200)];
//    [self.myView setBackgroundColor:[UIColor clearColor]];
//
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.ad.image.imageUrl]];
//    UIImageView* blockView = [[UIImageView alloc] initWithImage:image];
//    blockView.frame = CGRectMake(0 ,0, 50,50);
//    [self.myView addSubview:blockView];
//
//    UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.ad.icon.imageUrl]];
//    UIImageView* blockView1 = [[UIImageView alloc] initWithImage:icon];
//    blockView1.frame = CGRectMake(55 ,0, 50,50);
//    [self.myView addSubview:blockView1];
//
//    UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 20)];
//    [yourLabel setTextColor:[UIColor blackColor]];
//    [yourLabel setBackgroundColor:[UIColor clearColor]];
//    [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
//    [yourLabel setText:self.ad.title];
//    [self.myView addSubview:yourLabel];
//
//    UILabel *yourLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 20)];
//    [yourLabel1 setTextColor:[UIColor blackColor]];
//    [yourLabel1 setBackgroundColor:[UIColor clearColor]];
//    [yourLabel1 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
//    [yourLabel1 setText:self.ad.subtitle];
//    [self.myView addSubview:yourLabel1];
//
//    UILabel *yourLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
//    [yourLabel2 setTextColor:[UIColor blackColor]];
//    [yourLabel2 setBackgroundColor:[UIColor clearColor]];
//    [yourLabel2 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
//    [yourLabel2 setText:self.ad.descriptionText];
//    [self.myView addSubview:yourLabel2];
//
//    UILabel *yourLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
//    [yourLabel4 setTextColor:[UIColor blackColor]];
//    [yourLabel4 setBackgroundColor:[UIColor clearColor]];
//    [yourLabel4 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
//    [yourLabel4 setText:self.ad.callToActionText];
//    [self.myView addSubview:yourLabel4];
//
//    UILabel *yourLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
//    [yourLabel5 setTextColor:[UIColor blackColor]];
//    [yourLabel5 setBackgroundColor:[UIColor clearColor]];
//    [yourLabel5 setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]];
//    [yourLabel5 setText:self.ad.contentRating];
//    [self.myView addSubview:yourLabel5];
//
//    [self.webView addSubview:self.myView];
//    [self.ad attachToView:self.myView viewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
//
////    self.adView = [AppodealNativeAdView nativeAdViewWithType:self.adViewType andNativeAd:self.ad andAttributes:self.attributes rootViewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
////    [self.adView setFrame: CGRectMake(self.x, self.y, self.attributes.width, self.attributes.heigth)];
////    [self.webView addSubview:self.adView];
//    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nativeAdServiceDidLoad'); cordova.fireDocumentEvent('nativeAdServiceDidLoad')" completionHandler:nil];
//}

//- (void)attachToView:(CDVInvokedUrlCommand*)command
//{
//    [self.ad attachToView:self.adView viewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
//}
//
//- (void)detachFromView:(CDVInvokedUrlCommand*)command
//{
//    [self.ad detachFromView];
//}

//- (void)nativeAdServiceDidFailedToLoad
//{
//    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nativeAdServiceDidFailedToLoad'); cordova.fireDocumentEvent('nativeAdServiceDidFailedToLoad')" completionHandler:nil];
//}
//
//- (void)nativeAdDidClick:(AppodealNativeAd *)nativeAd
//{
//    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nativeAdDidClick'); cordova.fireDocumentEvent('nativeAdDidClick')" completionHandler:nil];
//}
//
//- (void)nativeAdDidPresent:(AppodealNativeAd *)nativeAd
//{
//    [self.webViewEngine evaluateJavaScript:@"cordova.fireDocumentEvent('nativeAdDidPresent'); cordova.fireDocumentEvent('nativeAdDidPresent')" completionHandler:nil];
//}

//- (void)setNativeAdAttributes_width_height:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.width=[[[command arguments] objectAtIndex:0] floatValue];
//    self.attributes.heigth=[[[command arguments] objectAtIndex:1] floatValue];
//}
//
//- (void)setNativeAdAttributes_roundedIcon:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.roundedIcon=[[[command arguments] objectAtIndex:0] boolValue];
//}
//- (void)setNativeAdAttributes_sponsored:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.sponsored=[[[command arguments] objectAtIndex:0] boolValue];
//}
////name, size
//- (void)setNativeAdAttributes_titleFont:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.titleFont=[UIFont fontWithName:[[command arguments] objectAtIndex:0] size:[[[command arguments] objectAtIndex:1] intValue]];
//}
//- (void)setNativeAdAttributes_descriptionFont:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.descriptionFont=[UIFont fontWithName:[[command arguments] objectAtIndex:0] size:[[[command arguments] objectAtIndex:1] intValue]];
//}
//- (void)setNativeAdAttributes_subtitleFont:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.subtitleFont=[UIFont fontWithName:[[command arguments] objectAtIndex:0] size:[[[command arguments] objectAtIndex:1] intValue]];
//}
//- (void)setNativeAdAttributes_buttonTitleFont:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.buttonTitleFont=[UIFont fontWithName:[[command arguments] objectAtIndex:0] size:[[[command arguments] objectAtIndex:1] intValue]];
//}
//- (void)setNativeAdAttributes_titleFontColor:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.titleFontColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
//                                                   green:[[[command arguments] objectAtIndex:1] floatValue]
//                                                    blue:[[[command arguments] objectAtIndex:2] floatValue]
//                                                   alpha:[[[command arguments] objectAtIndex:3] floatValue]];
//}
//- (void)setNativeAdAttributes_descriptionFontColor:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.descriptionFontColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
//                                                         green:[[[command arguments] objectAtIndex:1] floatValue]
//                                                          blue:[[[command arguments] objectAtIndex:2] floatValue]
//                                                         alpha:[[[command arguments] objectAtIndex:3] floatValue]];
//}
//- (void)setNativeAdAttributes_subtitleColor:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.subtitleColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
//                                                  green:[[[command arguments] objectAtIndex:1] floatValue]
//                                                   blue:[[[command arguments] objectAtIndex:2] floatValue]
//                                                  alpha:[[[command arguments] objectAtIndex:3] floatValue]];
//}
//- (void)setNativeAdAttributes_buttonColor:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.buttonColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
//                                                green:[[[command arguments] objectAtIndex:1] floatValue]
//                                                 blue:[[[command arguments] objectAtIndex:2] floatValue]
//                                                alpha:[[[command arguments] objectAtIndex:3] floatValue]];
//}
//- (void)setNativeAdAttributes_starRatingColor:(CDVInvokedUrlCommand*)command
//{
//    self.attributes.starRatingColor=[UIColor colorWithRed:[[[command arguments] objectAtIndex:0] floatValue]
//                                                    green:[[[command arguments] objectAtIndex:1] floatValue]
//                                                     blue:[[[command arguments] objectAtIndex:2] floatValue]
//                                                    alpha:[[[command arguments] objectAtIndex:3] floatValue]];
//}

@end
