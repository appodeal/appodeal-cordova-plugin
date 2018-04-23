//
//  MTRGNativeAppwallBanner.h
//  myTargetSDK 4.6.22
//
//  Created by Anton Bulankin on 13.01.15.
//  Copyright (c) 2015 Mail.ru Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MyTargetSDK/MTRGImageData.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTRGNativeAppwallBanner : NSObject

@property(nonatomic, copy, nullable) NSString *status;
@property(nonatomic, copy, nullable) NSString *title;
@property(nonatomic, copy, nullable) NSString *descriptionText;
@property(nonatomic, copy, nullable) NSString *paidType;
@property(nonatomic, copy, nullable) NSString *mrgsId;
@property(nonatomic) BOOL hasNotification;
@property(nonatomic) BOOL subitem;
@property(nonatomic) BOOL isAppInstalled;
@property(nonatomic) BOOL main;
@property(nonatomic) BOOL requireCategoryHighlight;
@property(nonatomic) BOOL banner;
@property(nonatomic) BOOL requireWifi;
@property(nonatomic, nullable) NSNumber *rating;
@property(nonatomic) NSUInteger votes;
@property(nonatomic) NSUInteger coins;
@property(nonatomic, nullable) UIColor *coinsBgColor;
@property(nonatomic, nullable) UIColor *coinsTextColor;
@property(nonatomic, nullable) MTRGImageData *icon;
@property(nonatomic, nullable) MTRGImageData *statusImage;
@property(nonatomic, nullable) MTRGImageData *coinsIcon;
@property(nonatomic, nullable) MTRGImageData *crossNotifIcon;
@property(nonatomic, nullable) MTRGImageData *bubbleIcon;
@property(nonatomic, nullable) MTRGImageData *gotoAppIcon;
@property(nonatomic, nullable) MTRGImageData *itemHighlightIcon;

@end

NS_ASSUME_NONNULL_END
