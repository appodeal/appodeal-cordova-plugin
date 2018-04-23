//
//  MTRGNativePromoBanner.h
//  myTargetSDK 4.6.22
//
//  Created by Anton Bulankin on 17.11.14.
//  Copyright (c) 2014 Mail.ru Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MyTargetSDK/MTRGImageData.h>
#import <MyTargetSDK/MTRGNavigationType.h>
#import <MyTargetSDK/MTRGNativePromoCard.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTRGNativePromoBanner : NSObject

@property(nonatomic, copy, nullable) NSString *advertisingLabel;
@property(nonatomic, copy, nullable) NSString *ageRestrictions;
@property(nonatomic, copy, nullable) NSString *title;
@property(nonatomic, copy, nullable) NSString *descriptionText;
@property(nonatomic, copy, nullable) NSString *disclaimer;
@property(nonatomic, copy, nullable) NSString *category;
@property(nonatomic, copy, nullable) NSString *subcategory;
@property(nonatomic, copy, nullable) NSString *domain;
@property(nonatomic, copy, nullable) NSString *ctaText;
@property(nonatomic, nullable) NSNumber *rating;
@property(nonatomic) NSUInteger votes;
@property(nonatomic) MTRGNavigationType navigationType;
@property(nonatomic, nullable) MTRGImageData *icon;
@property(nonatomic, nullable) MTRGImageData *image;
@property(nonatomic, nullable) NSArray<MTRGNativePromoCard *> *cards;

@end

NS_ASSUME_NONNULL_END
