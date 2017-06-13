//
//  ALSdkSettings.h
//
//  Copyright (c) 2013, AppLovin Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALAnnotations.h"

/**
 * This class contains settings for the AppLovin SDK.
 */
@interface ALSdkSettings : NSObject

/**
 * Toggle test ads for the SDK. This is set to NO by default.
 *
 * If enabled, AppLovin will display test ads from our servers, guaranteeing 100% fill.
 * This is for integration testing only. Ensure that you set this to NO when the app is launched.
 *
 * @param isTestAdsEnabled YES if you want to receive test ads. NO if you want live ads.
 */
@property (assign, atomic) BOOL isTestAdsEnabled;

/**
 * Toggle verbose logging for the SDK. This is set to NO by default.
 * 
 * If enabled AppLovin messages will appear in standard application log accessible via console.
 * All log messages will be prefixed by the "AppLovinSdk" tag.
 * 
 * Verbose logging is <i>disabled</i> by default.
 * 
 * @param isVerboseLogging YES if log messages should be output. NO if the SDK should be silent (recommended for App Store submissions).
 */
@property (assign, atomic) BOOL isVerboseLogging;

/**
 * Defines sizes of ads that should be automatically preloaded.
 * <p>
 * Auto preloading is enabled for <code>BANNER,INTER</code> by default.
 * To disable outright, set to "NONE".
 *
 * @param autoPreloadAdSizes Comma-separated list of sizes to preload. For example: "BANNER,INTER"
 */
@property (strong, atomic) NSString * __alnonnull autoPreloadAdSizes;

/**
 * Defines types of ads that should be automatically preloaded.
 * <p>
 * Auto preloading is enabled for <code>REGULAR,INCENTIVIZED</code> by default.
 * To disable outright, set to "NONE".
 *
 * @param autoPreloadAdTypes Comma-separated list of sizes to preload. For example: "REGULAR,INCENTIVIZED"
 */
@property (strong, atomic) NSString * __alnonnull autoPreloadAdTypes;

/**
 * Determines whether to begin video ads in a muted state or not. Defaults to YES unless changed in the dashboard.
 *
 * @param muted YES if ads should begin in a muted state. NO if ads should NOT begin in a muted state.
 */
@property (assign, atomic) BOOL muted __TVOS_PROHIBITED;

@end
