#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RevMobAdsDelegate <NSObject>


@optional

# pragma mark Publisher Callbacks

/**
 Fired when session is started.
 */
- (void)revmobSessionDidStart;

/**
 Fired when session fails to start.
 @param error: contains error information.
 */
- (void)revmobSessionDidNotStartWithError:(NSError *)error;



/******** Ad Delegates *******/



/** Native **/

/**
 Called when it's sucessfully loaded and ready to be shown.
 */
- (void)revmobNativeDidReceive:(NSString *)placementId;


/**
 Called when the communication with the server is finished with error.
 @param error: contains error information.
 */
- (void)revmobNativeDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId;


/**
 Called when the Native is clicked
 */
- (void)revmobUserDidClickOnNative:(NSString *)placementId;





/** Banner **/

/**
Called when it's sucessfully loaded and ready to be shown.
 */
- (void)revmobBannerDidReceive:(NSString *)placementId;


/**
 Called when the communication with the server is finished with error.
 @param error: contains error information.
 */
- (void)revmobBannerDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId;


/**
Called when the Ad is displayed in the screen.
 */
- (void)revmobBannerDidDisplay:(NSString *)placementId;


/**
 Called when the Banner is clicked
 */
- (void)revmobUserDidClickOnBanner:(NSString *)placementId;





/** Fullscreen **/

/**
 Called when it's sucessfully loaded and ready to be shown.
 */
- (void)revmobFullscreenDidReceive:(NSString *)placementId;


/**
 Called when the communication with the server is finished with error.
 @param error: contains error information.
 */
- (void)revmobFullscreenDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId;


/**
 Called when the Ad is displayed in the screen.
 */
- (void)revmobFullscreenDidDisplay:(NSString *)placementId;


/**
 Called when the Fullscreen is clicked
 */
- (void)revmobUserDidClickOnFullscreen:(NSString *)placementId;


/**
 Called when the Fullscreen is dismissed
 */
- (void)revmobUserDidCloseFullscreen:(NSString *)placementId;






/** Video **/

/**
 Fired when the Video is received.
 */
- (void)revmobVideoDidLoad:(NSString *)placementId;


/**
 Called when the communication with the server is finished with error.
 @param error: contains error information.
 */
- (void)revmobVideoDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId;


/**
 Fired when the Video is not completely loaded or not even loading.
 */
- (void)revmobVideoNotCompletelyLoaded:(NSString *)placementId;


/**
 Fired when the Video starts.
 */
- (void)revmobVideoDidStart:(NSString *)placementId;


/**
 Fired when the Video finished.
 */
- (void)revmobVideoDidFinish:(NSString *)placementId;


/**
 Called when the Video is clicked
 */
- (void)revmobUserDidClickOnVideo:(NSString *)placementId;


/**
 Called when the Video is dismissed
 */
- (void)revmobUserDidCloseVideo:(NSString *)placementId;





/** Rewarded Video **/

/**
 Fired when the Rewarded Video is loaded.
 */
- (void)revmobRewardedVideoDidLoad:(NSString *)placementId;


/**
 Called when the communication with the server is finished with error.
 @param error: contains error information.
 */
- (void)revmobRewardedVideoDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId;


/**
 Fired when the Rewarded Video is not completely loaded or not even loading.
 */
- (void)revmobRewardedVideoNotCompletelyLoaded:(NSString *)placementId;


/**
 Fired when the Rewarded Video starts.
 */
- (void)revmobRewardedVideoDidStart:(NSString *)placementId;


/**
 Called when the whole Rewarded Video process is completed and the reward can be given.
 */
- (void)revmobRewardedVideoDidComplete:(NSString *)placementId;


/**
 Called when the RevMob Rewarded Video Pre-Roll is displayed.
 */
- (void)revmobRewardedPreRollDidDisplay:(NSString *)placementId;


/**
 Called when the Rewarded Video is dismissed
 */
- (void)revmobUserDidCloseRewardedVideo:(NSString *)placementId;





/** Pop Up **/

/**
 Called when it's sucessfully loaded and ready to be shown.
 */
- (void)revmobPopUpDidReceive:(NSString *)placementId;


/**
 Called when the communication with the server is finished with error.
 @param error: contains error information.
 */
- (void)revmobPopUpDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId;


/**
 Called when the Ad is displayed in the screen.
 */
- (void)revmobPopUpDidDisplay:(NSString *)placementId;


/**
 Called when the Fullscreen is clicked
 */
- (void)revmobUserDidClickOnPopUp:(NSString *)placementId;


/**
 Called when the Fullscreen is dismissed
 */
- (void)revmobUserDidClosePopUp:(NSString *)placementId;




@end
