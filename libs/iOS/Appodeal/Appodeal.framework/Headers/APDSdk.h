//
//  APDSdk.h
//  Appodeal
//
//  Copyright © 2016 Appodeal, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Appodeal/APDUserInfo.h>
#import <Appodeal/APDDefines.h>

/*!
 * Main sdk object, that managed network request, ad modules and statistics data.
 * You should initilize sdk before you start loading any ad types.
 * You can do this in 
 * @discussion - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
 * @discussion for example.
 * @warning You must call sharedSdkWithApiKey:(NSString *)apiKey firstly. 
 * @discussion For example initializiton code can be something like this:
 * @code 
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[APDSdk sharedSdkWithApiKey: YOUR_API_KEY] initializeForAdTypes: APDAdTypeInterstitialAd];
 return YES;
 }
 * @endcode

 * After sdk initialization you can get instanse of sdk by calle [APDSdk sharedSdk];
 * You can additional set other sdk settings before/after sdk initialization
 */
@interface APDSdk : NSObject

/*!
 If type APDMediaViewTypeIcon -mediaViewStartPlaying: call firstly!
 *  Unuvailabale initializer
 *
 *  @return nil
 */
- (instancetype)init NS_UNAVAILABLE;

/*!
 *  Unuvailabale initializer
 *
 *  @return nil
 */
+ (instancetype)new NS_UNAVAILABLE;

/*!
 *  Singleton instance of APDSdk
 *
 *  @param apiKey String API key parameter from Appodeal Dashboard
 *
 *  @return Singleton instance of APDSdk
 */
+ (instancetype)sharedSdkWithApiKey:(NSString *)apiKey;


/*!
 *  Always returns same instance SDK returned by first call of +sharedSdkWithApiKey:
 *
 *  @return Instance of APDSdk
 */
+ (instancetype)sharedSdk;

/*!
 *  Initializtion of sdk for types
 *
 *  @param adTypes APDAdType value
 */
- (void)initializeForAdTypes:(APDAdType)adTypes;

/*!
 *  Check that sdk is initialized for ad type
 *
 *  @param adType APDAdType value
 *
 *  @return YES if sdk initialized for this type, or NO if not
 */
- (BOOL)isInitializedForAdType:(APDAdType)adType;

/*!
 *  If you set YES to this method you get only
 *  test ad with 0$ eCPM
 *
 *  @param enabled Boolean flag
 */
- (void)setTesingMode:(BOOL)enabled;

/*!
 *  Set targeting for more satisfuong ads
 *
 *  @param userInfo Insatance of APDUserInfo class
 */
- (void)setUserInfo:(APDUserInfo *)userInfo;

/*!
 *  If you does not want to some ad network
 *  get user info call this method
 *
 *  @param networkName Appodeal ad network name for example: @"mopub", @"admob"
 */
- (void)disableUserInfoForNetworkName:(NSString *)networkName;

/*!
 *  You can set custom rule by usage this method.
 *  Configure rules for segments in <b>Appodeal Dashboard</b>.
 *  @discussion For example, you want to use segment, when user complete 20 or more levels
 *  You create rule in dashboard with name "completedLevels" of type Int,
 *  operator GreaterThanOrEqualTo and value 10, now you implement folowing code:
 *
 *  @code 
    NSDictionary * customRule = {@"completedLevels" : CURRENT_NUMBER_OF_COMPLETED_LEVELS};
    [[APDSdk sharedSdk] setCustomRule: customRule];
 *  @endcode
 *
 *  And then CURRENT_NUMBER_OF_COMPLETED_LEVELS become 10 or greater
 *  You segments settings become available
 *
 *  @param customRule NSDictionary instance with keys that similar to  keys that you tune in Appodeal Dashboard's Segment settings block and values of similar types
 */
- (void)setCustomRule:(NSDictionary *)customRule;


/*!
 *  Appodeal SDK supports multiple log level for internal logging,
 *  and ONLY one (VERBOSE) log level for third party ad networks.
 *  To enable third party ad networks logging set log level to APDLogLevelVerbose.
 *  If log level other than APDLogLevelVerbose, all third party ad networks logging will be suppressed (if possible).
 *
 *  @param logLevel APDLogLevel value
 */
- (void)setLogLevel:(APDLogLevel)logLevel;

/*!
 *  Disabling/enabling loction tracking
 *
 *  @param enabled By default set to NO
 */
- (void)setLocationTracking:(BOOL)enabled;

/*!
 *  @brief Reset UUID for tracking/targeting ad
 */
- (void)resetUUID;

@end


@interface APDSdk (InAppPurchase)

/*!
 *  In-app purchase tracking.
 *  Call this method after user make some in-app purchase
 *
 *  @param amount   Amount of in-app purchase, for example @0.99
 *  @param currency In-app purchase currency, for example @"USD"
 */

- (void)trackInAppPurchase:(NSNumber *)amount currency:(NSString *)currency;

@end
