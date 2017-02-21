#import <Foundation/Foundation.h>
#import "RevMobAdsDelegate.h"

/**
 Class responsable for handle the Fullscreen ad unit.

 */
@interface RevMobFullscreen : NSObject

/**
 The delegate set on this property is called when ad related events happend, see
 RevMobAdsDelegate for mode details.
 */
@property(nonatomic, assign) id<RevMobAdsDelegate> delegate;

/**
 The default behaviour of the fullscreen is rotate for all the orientations.
 If you want to change this you should set an array in this property with the
 desired orientations.

 Example of use:

     fullscreen.supportedInterfaceOrientations = @[ @(UIInterfaceOrientationPortrait) ];
 */
@property(nonatomic, strong) NSArray *supportedInterfaceOrientations;

/**
 Use this method to load the video ad;
 */
-(void) loadVideo;

/**
 Use this method to load the rewarded ad;
 */
-(void) loadRewardedVideo;

/**
 Use this method to load the ad.

 @see loadWithSuccessHandler:andLoadFailHandler:onClickHandler:onCloseHandler:
 */
- (void)loadAd;

/**
 Use this method to load the ad.

 @see loadWithSuccessHandler:andLoadFailHandler:onClickHandler:onCloseHandler:
 */
- (void) loadWithSuccessHandler:(void(^)(RevMobFullscreen* fs)) onAdLoadedHandler
         andLoadFailHandler:(void(^)(RevMobFullscreen* fs, NSError *error)) onAdFailedHandler;

/**
 Use this method to load the ad.
 
 
 Example of usage:
 
     [fs loadWithSuccessHandler:^(RevMobFullscreen *fs) {
       [fs showAd];
       NSLog(@"Ad loaded");
     } andLoadFailHandler:^(RevMobFullscreen *fs, NSError *error) {
       NSLog(@"Ad error: %@",error);
     } onClickHandler:^{      
       NSLog(@"Ad clicked");
     } onCloseHandler:^{
       NSLog(@"Ad closed");
     }];

 @param onAdLoadedHandler: A block that will be executed once the ad is loaded, can be nil.
 
 @param onAdFailedHandler: A block that will be executed once any error happen, can be nil.

 @param onClickHandler: A block that will be executed once the user click on the ad, can be nil.
 
 @param onCloseHandler: A block that will be executed once the user close the ad, can be nil.

 */
- (void) loadWithSuccessHandler:(void(^)(RevMobFullscreen* fs)) onAdLoadedHandler
             andLoadFailHandler:(void(^)(RevMobFullscreen* fs, NSError *error)) onAdFailedHandler
                 onClickHandler:(void(^)())onClickHandler
                 onCloseHandler:(void(^)())onCloseHandler;


/**
 Use this method to load the ad.
 
 
 Example of usage:
 
 [video loadWithSuccessHandler:^(RevMobFullscreen *video) {
 [video showAd];
 NSLog(@"Ad loaded");
 } andLoadFailHandler:^(RevMobFullscreen *video, NSError *error) {
 NSLog(@"Ad error: %@",error);
 } onClickHandler:^{
 NSLog(@"Ad clicked");
 } onCloseHandler:^{
 NSLog(@"Ad closed");
 }];
 
 @param onAdLoadedHandler: A block that will be executed once the ad is loaded, can be nil.
 
 @param onAdFailedHandler: A block that will be executed once any error happen, can be nil.
 
 @param onClickHandler: A block that will be executed once the user click on the ad, can be nil.
 
 @param onCloseHandler: A block that will be executed once the user close the ad, can be nil.
 
 */
- (void) loadVideoWithSuccessHandler:(void(^)(RevMobFullscreen* fs)) onAdLoadedHandler
             andLoadFailHandler:(void(^)(RevMobFullscreen* fs, NSError *error)) onAdFailedHandler
                 onClickHandler:(void(^)())onClickHandler
                 onCloseHandler:(void(^)())onCloseHandler;


/**
 Use this method to load the ad.
 
 
 Example of usage:
 
 [rewardedVideo loadRewardedVideoWithSuccessHandler:^(RevMobFullscreen *rewardedVideo) {
 [rewardedVideo showAd];
 NSLog(@"Ad loaded");
 } andLoadFailHandler:^(RevMobFullscreen *rewardedVideo, NSError *error) {
 NSLog(@"Ad error: %@",error);
 } onClickHandler:^{
 NSLog(@"Ad clicked");
 } onCloseHandler:^{
 NSLog(@"Ad closed");
 }];
 
 @param onAdLoadedHandler: A block that will be executed once the ad is loaded, can be nil.
 
 @param onAdFailedHandler: A block that will be executed once any error happen, can be nil.
 
 @param onClickHandler: A block that will be executed once the user click on the ad, can be nil.
 
 @param onCloseHandler: A block that will be executed once the user close the ad, can be nil.
 
 */
- (void) loadRewardedVideoWithSuccessHandler:(void(^)(RevMobFullscreen* fs)) onAdLoadedHandler
             andLoadFailHandler:(void(^)(RevMobFullscreen* fs, NSError *error)) onAdFailedHandler
              onCompleteHandler:(void(^)())onCompleteHandler;



/**
 Use this method to show the ad.
 */
- (void)showAd;
/**
 Use this method to show the video ad.
 */
- (void) showVideo;

/** Use this method to show the rewarded video ad.
 */
-(void) showRewardedVideo;

/**
 Use this method to hide the ad.
 */
- (void)hideAd;

@end
