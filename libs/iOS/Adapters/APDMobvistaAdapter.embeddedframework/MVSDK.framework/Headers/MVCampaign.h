//
//  MVCampaign.h
//  MVSDK
//
//  Created by Jomy on 15/10/14.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MVAdSourceType) {
    MVAD_SOURCE_API_OFFER = 1,
    MVAD_SOURCE_MY_OFFER  = 2,
    MVAD_SOURCE_FACEBOOK  = 3,
    MVAD_SOURCE_MOBVISTA  = 4,
    MVAD_SOURCE_PUBNATIVE = 5,
    MVAD_SOURCE_ADMOB     = 6,
    MVAD_SOURCE_MYTARGET  = 7,
    MVAD_SOURCE_NATIVEX   = 8,
    MVAD_SOURCE_APPLOVIN  = 9,
};

typedef NS_ENUM(NSInteger, MVAdTemplateType) {
    MVAD_TEMPLATE_BIG_IMAGE  = 2,
    MVAD_TEMPLATE_ONLY_ICON  = 3,
};

@interface MVCampaign : NSObject

/*!
 @property
 
 @abstract The unique id of the ad
 */
@property (nonatomic, copy  ) NSString       *adId;

/*!
 @property
 
 @abstract The app's package name of the campaign
 */
@property (nonatomic, copy  ) NSString       *packageName;

/*!
 @property
 
 @abstract The app name of the campaign
 */
@property (nonatomic, copy  ) NSString       *appName;

/*!
 @property
 
 @abstract The description of the campaign
 */
@property (nonatomic, copy  ) NSString       *appDesc;

/*!
 @property
 
 @abstract The app size of the campaign
 */
@property (nonatomic, copy  ) NSString       *appSize;

/*!
 @property
 
 @abstract The icon url of the campaign
 */
@property (nonatomic, copy  ) NSString       *iconUrl;

/*!
 @property
 
 @abstract The image url of the campaign. The image size will be 1200px * 627px.
 */
@property (nonatomic, copy  ) NSString       *imageUrl;

/*!
 @property
 
 @abstract The string to show in the clickbutton
 */
@property (nonatomic, copy  ) NSString       *adCall;

/*!
 @property
 
 @abstract The ad source of the campaign
 */
@property (nonatomic, assign) MVAdSourceType type;

/*!
 @property
 
 @abstract The timestap of the campaign
 */
@property (nonatomic, assign) double      timestamp;

/*!
 @property
 
 @abstract The dataTemplate of the campaign
 */
@property (nonatomic,assign) MVAdTemplateType    dataTemplate;

/*!
 @method
 
 @abstract
 Loads an icon image from self.iconUrl over the network, or returns the cached image immediately.
 
 @param block Block to handle the loaded image. The image may be nil if error happened.
 */
- (void)loadIconUrlAsyncWithBlock:(void (^)(UIImage *image))block;

/*!
 @method
 
 @abstract
 Loads an image from self.imageUrl over the network, or returns the cached image immediately.
 
 @param block Block to handle the loaded image. The image may be nil if error happened.
 */
- (void)loadImageUrlAsyncWithBlock:(void (^)(UIImage *image))block;


@end
