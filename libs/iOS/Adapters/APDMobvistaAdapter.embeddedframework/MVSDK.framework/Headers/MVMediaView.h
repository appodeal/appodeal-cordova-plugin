//
//  MVMediaView.h
//  MVSDK
//
//  Created by 陈俊杰 on 2017/5/25.
//  Copyright © 2017年 Mobvista. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MVMediaViewDelegate;
@class MVCampaign;
@class MVNativeAdManager;

@interface MVMediaView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
/**
the media source, can be set again to reuse this view.
*/
- (void)setMediaSourceWithCampaign:(MVCampaign *)campaign unitId:(NSString*)unitId;

@property (nonatomic, weak, nullable) id<MVMediaViewDelegate> delegate;

@property (nonatomic, assign) BOOL  allowFullscreen;

@property (nonatomic, strong, readonly) MVCampaign *campaign;

@property (nonatomic, readonly) NSString *unitId;

@end

@protocol MVMediaViewDelegate <NSObject>

@optional

/*!
 @method
 
 @abstract
 Sent just before an MVMediaView will enter the fullscreen layout.
 
 @param nativeAd: An mediaView object sending the message.
 */
- (void)MVMediaViewWillEnterFullscreen:(MVMediaView *)mediaView;

/*!
 @method
 
 @abstract
 Sent after an FBMediaView has exited the fullscreen layout.
 
 @param nativeAd: An mediaView object sending the message.
 */
- (void)MVMediaViewDidExitFullscreen:(MVMediaView *)mediaView;

/*!
 @method
 
 @abstract
 Sent after an ad has been clicked by a user.
 
 @param nativeAd An MVCampaign object sending the message.
 */
- (void)nativeAdDidClick:(nonnull MVCampaign *)nativeAd;

/*!
 @method
 
 @abstract
 Sent after an ad url did start to resolve.
 
 @param clickUrl The click url of the ad.
 */
- (void)nativeAdClickUrlWillStartToJump:(nonnull NSURL *)clickUrl;

/*!
 @method
 
 @abstract
 Sent after an ad url has jumped to a new url.
 
 @param jumpUrl The url during jumping.
 
 @discussion It will not be called if a ad's final jump url has been cached
 */
- (void)nativeAdClickUrlDidJumpToUrl:(nonnull NSURL *)jumpUrl;

/*!
 @method
 
 @abstract
 Sent after an ad url did reach the final jump url.
 
 @param finalUrl the final jump url of the click url.
 @param error the error generated between jumping.
 */
- (void)nativeAdClickUrlDidEndJump:(nullable NSURL *)finalUrl
                             error:(nullable NSError *)error;
@end

NS_ASSUME_NONNULL_END
