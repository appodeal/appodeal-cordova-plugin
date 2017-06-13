//
//  APDNativeAd.h
//  Appodeal
//
//  AppodealSDK version 2.0.0-All
//
//  Copyright © 2017 Appodeal, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Appodeal/APDImage.h>
#import <UIKit/UIKit.h>

@class APDNativeAd;


typedef NS_ENUM(NSUInteger, APDNativeComplainPosition) {
    APDComplainNone = 0,
    APDComplainTop,
    APDComplainCenter,
    APDComplainBottom
};

@protocol APDNativeAdPresentationDelegate <NSObject>

@optional

- (void)nativeAdWillLogImpression:(APDNativeAd *)nativeAd;

- (void)nativeAdWillLogUserInteraction:(APDNativeAd *)nativeAd;

@end

/*!
 *  Instance of this class contain ad data
 */
@interface APDNativeAd : NSObject

@property (nonatomic, weak) id <APDNativeAdPresentationDelegate> delegate;

/*!
 *  Ad title, required field to display. Length less than or equal to about 120 characters
 */
@property (copy, nonatomic, readonly) NSString *title;

/*!
 *  Ad subtitle, optional field to display
 */
@property (copy, nonatomic, readonly) NSString *subtitle;

/*!
 *  Ad description, optional field to display. Length less than or equal to about 400 characters
 */
@property (copy, nonatomic, readonly) NSString *descriptionText;

/*!
 *  Ad call to action text, required field to display. Length less than or equal to about 120 characters
 */
@property (copy, nonatomic, readonly) NSString *callToActionText;

/*!
 *  Ad content rating to action text, optional field to display. Length less than or equal to about 120 characters
 */
@property (copy, nonatomic, readonly) NSString *contentRating;

/*!
 *  Rating of advertised app, optional field
 */
@property (copy, nonatomic, readonly) NSNumber *starRating;

/*!
 *  Main image from native ad. Prevalent aspect ratio is 16:9. Optional
 */
@property (copy, nonatomic, readonly) APDImage *mainImage;

/*!
 *  Square icon image. Prevalent sizes 50x50, 80x80. Requered
 */
@property (copy, nonatomic, readonly) APDImage *iconImage;

/*!
 *  Ad Choices view. Can be nil. Provided by ad network. If contains requered to display!. Minimum size 24x24
 */
@property (nonatomic, strong, readonly) UIView * adChoicesView;

/*!
 *  Getter that native ad contains video
 */
@property (nonatomic, readonly, getter=isContainsVideo) BOOL containsVideo;

/*!
 *  Call this method before displying native ad! 
 *  Need to track impressions/tap actions!
 *
 *  @param view           Nonnul view that contains all required fields and will be displayed
 *  @param viewController Nonnul view controller that will display view
 */
- (void)attachToView:(UIView *)view viewController:(UIViewController *)viewController;

/*!
 *  Call this method after native ad view hide
 *  Remove all native ad internal caches
 *  Disable native ad tracking mechanism for current native ad view
 */
- (void)detachFromView;

- (void)complainButtonPositon:(APDNativeComplainPosition)position;

@end
