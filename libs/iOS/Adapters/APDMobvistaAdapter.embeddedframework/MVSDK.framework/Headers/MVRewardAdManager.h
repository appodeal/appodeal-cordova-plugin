//
//  MVRewardAdManager.h
//  MVSDK
//
//  Created by yujinping on 16/4/12.
//

#import <Foundation/Foundation.h>
#import <MVSDK/MVRewardAdInfo.h>

#define kMVErrorCodeNoAdsAvailableToPlay          12930004
#define kMVErrorCodeFailedToPlay                  12930005

#pragma mark - MVRewardAdManagerDelegate


/**
 *  This protocol defines a listener for ad video load events.
 */
@protocol MVRewardAdLoadDelegate <NSObject>
@optional

/**
 *  Called when the ad is successfully load , and is ready to be displayed
 *
 *  @param unitId - the unitId string of the Ad that was loaded.
 */
- (void)onVideoAdLoadSuccess:(nullable NSString *)unitId;

/**
 *  Called when there was an error loading the ad.
 *
 *  @param unitId      - the unitId string of the Ad that failed to load.
 *  @param error       - error object that describes the exact error encountered when loading the ad.
 */
- (void)onVideoAdLoadFailed:(nullable NSString *)unitId error:(nonnull NSError *)error;

@end

/**
 *  This protocol defines a listener for ad video show events.
 */
@protocol MVRewardAdShowDelegate <NSObject>
@optional

/**
 *  Called when the ad display success
 *
 *  @param unitId - the unitId string of the Ad that display success.
 */
- (void)onVideoAdShowSuccess:(nullable NSString *)unitId;

/**
 *  Called when the ad failed to display for some reason
 *
 *  @param unitId      - the unitId string of the Ad that failed to be displayed.
 *  @param error       - error object that describes the exact error encountered when showing the ad.
 */
- (void)onVideoAdShowFailed:(nullable NSString *)unitId withError:(nonnull NSError *)error;

/**
 *  Called when the ad is clicked
 *
 *  @param unitId - the unitId string of the Ad clicked.
 */
- (void)onVideoAdClicked:(nullable NSString *)unitId;

/** 
 *  Called when the ad has been dismissed from being displayed, and control will return to your app
 *
 *  @param unitId      - the unitId string of the Ad that has been dismissed
 *  @param converted   - BOOL describing whether the ad has converted
 *  @param rewardInfo  - the rewardInfo object containing the info that should be given to your user.
 */
- (void)onVideoAdDismissed:(nullable NSString *)unitId withConverted:(BOOL)converted withRewardInfo:(nullable MVRewardAdInfo *)rewardInfo;
@end


#pragma mark - MVRewardAdManager


@interface MVRewardAdManager : NSObject


/**
 * The shared instance of the video.
 *
 * @return The video singleton.
 */
+ (nonnull instancetype)sharedInstance;

/**
 *  Called when load the video
 *
 *  @param unitId      - the unitId string of the Ad that was loaded.
 *  @param delegate    - reference to the object that implements MVRewardAdLoadDelegate protocol; will receive load events for the given unitId.
 */
- (void)loadVideo:(nonnull NSString *)unitId delegate:(nullable id <MVRewardAdLoadDelegate>)delegate;

/**
 *  Called when show the video
 *
 *  @param unitId         - the unitId string of the Ad that display.
 *  @param rewardId       - the reward info about NativeX or AppLovin
 *  @param userId       - The user's unique identifier in your system
 *  @param delegate       - reference to the object that implements MVRewardAdShowDelegate protocol; will receive show events for the given unitId.
 *  @param viewController - UIViewController that shouold be set as the root view controller for the ad
 */
- (void)showVideo:(nonnull NSString *)unitId withRewardId:(nonnull NSString *)rewardId userId:(nullable NSString *)userId delegate:(nullable id <MVRewardAdShowDelegate>)delegate viewController:(nonnull UIViewController*)viewController;

/**
 *  Will return whether the given unitId is loaded and ready to be shown.
 *
 *  @param unitId - adPositionId value in Self Service
 *
 *  @return - YES if the unitId is loaded and ready to be shown, NO otherwise
 */
- (BOOL)isVideoReadyToPlay:(nonnull NSString *)unitId;

/**
 *  Clean all the video file cache from the disk.
 */
- (void)cleanAllVideoFileCache;



@end
