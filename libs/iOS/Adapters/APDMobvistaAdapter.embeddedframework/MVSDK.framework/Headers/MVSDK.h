//
//  MVSDK.h
//  MVSDK
//
//  Created by Jomy on 15/9/28.
//

#define MVSDKVersion @"2.5.0"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MVSDK/MVNativeAdManager.h>
#import <MVSDK/MVCampaign.h>
#import <MVSDK/MVTemplate.h>
#import <MVSDK/MVFrame.h>
#import <MVSDK/MVNativeScrollView.h>
#import <MVSDK/MVMediaView.h>

@interface MVSDK : NSObject


/**
 * The shared instance of the SDK.
 *
 * @return The SDK singleton.
 */
+ (nonnull instancetype)sharedInstance;

/**
 * Set the AppID and ApiKey. This must be called before any ads are requested.
 *
 * @param appID  T application Id registered on the our portal.
 * @param apiKey The API Key generated on the our Portal.
 */
- (void)setAppID:(nonnull NSString *)appID ApiKey:(nonnull NSString *)apiKey;

/**
 *
 @method
 
 @abstract The method that kicks off the preloading of native ads. It may be called again in the future to refresh the ads manually.
 
 @param unitId The id of the ad unit. You can create your unit id from our Portal.
 
 @param fbPlacementId The Facebook PlacementID is used to request ads from Facebook. You can also set the placementID in our portal. The ID you set in our web portal will replace the ID you set here in future.
 @param numAdsRequested The number of ads you would like to preload. Max number is 10. If you pass any number bigger than 10, it will be reset to 10.
 */
- (void)preloadNativeAdsWithUnitId:(nonnull NSString *)unitId
                     fbPlacementId:(nullable NSString *)fbPlacementId
                forNumAdsRequested:(NSUInteger)numAdsRequested;

/**
 *
 @method
 
 @abstract The method that kicks off the preloading of native ads. It may be called again in the future to refresh the ads manually.
 
 @param unitId The id of the ad unit. You can create your unit id from our Portal.
 
 @param fbPlacementId The Facebook PlacementID is used to request ads from Facebook. You can also set the placementID in our portal. The ID you set in our web portal will replace the ID you set here in future.
 
 @param videoSupport If the support video ads, set videoSupport  to yes.
 
 @param numAdsRequested The number of ads you would like to preload. Max number is 10. If you pass any number bigger than 10, it will be reset to 10.
 */
- (void)preloadNativeAdsWithUnitId:(nonnull NSString *)unitId
                     fbPlacementId:(nullable NSString *)fbPlacementId
                     videoSupport:(BOOL)videoSupport
                forNumAdsRequested:(NSUInteger)numAdsRequested;

/**
 *
 @method
 
 @abstract The method that kicks off the preloading of native ads. It may be called again in the future to refresh the ads manually.
 
 @param unitId The id of the ad unit. You can create your unit id from our Portal.
 @param fbPlacementId The Facebook PlacementID is used to request ads from Facebook. You can also set the placementID in our portal. The ID you set in our web portal will replace the ID you set here in future.
 @param templates This array contains objects of MVTemplate. See more detail in definition of MVTemplate.
 @param autoCacheImage If you pass YES, SDK will download the image resource automatically when you get the campaign.
 @param adCategory Decide what kind of ads you want to retrieve. Games, apps or all of them. The default is All.
 */
- (void)preloadNativeAdsWithUnitId:(nonnull NSString *)unitId
                     fbPlacementId:(nullable NSString *)fbPlacementId
                supportedTemplates:(nullable NSArray *)templates
                    autoCacheImage:(BOOL)autoCacheImage
                        adCategory:(MVAdCategory)adCategory;
/**
 *
 @method
 
 @abstract The method that kicks off the preloading of native frames. It may be called again in the future to refresh the frames manually.
 
 @param unitId The id of the ad unit. You can create your unit id from our Portal.
 @param fbPlacementId The Facebook PlacementID is used to request ads from Facebook. You can also set the placementID in our portal. The ID you set in our web portal will replace the ID you set here in future.
 @param templates This array contains objects of MVTemplate. See more detail in definition of MVTemplate.
 @param autoCacheImage If you pass YES, SDK will download the image resource automatically when you get the campaign.
 @param adCategory Decide what kind of ads you want to retrieve. Games, apps or all of them. The default is All.
 @param frameNum The number of frames you would like to preload. Max number is 10. If you pass any number bigger than 10, it will be reset to 10.
 */
- (void)preloadNativeFramesWithUnitId:(nonnull NSString *)unitId
                        fbPlacementId:(nullable NSString *)fbPlacementId
              supportedFrameTemplates:(nullable NSArray *)templates
                       autoCacheImage:(BOOL)autoCacheImage
                           adCategory:(MVAdCategory)adCategory
                             frameNum:(NSUInteger)frameNum DEPRECATED_ATTRIBUTE;

/**
 *
 @method
 
 @abstract The method that kicks off the preloading of app wall ads. It may be called again in the future to refresh the ads manually.
 
 @param unitId The id of the ad unit. You can create your unit id from our Portal.
 */
- (void)preloadAppWallAdsWithUnitId:(nonnull NSString *)unitId;







@end
