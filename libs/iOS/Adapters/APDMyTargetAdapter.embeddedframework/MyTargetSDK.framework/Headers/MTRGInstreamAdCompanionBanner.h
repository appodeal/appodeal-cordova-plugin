//
//  MTRGInstreamAdCompanionBanner.h
//  myTargetSDK 4.6.22
//
//  Created by Andrey Seredkin on 14.12.16.
//  Copyright © 2016 Mail.ru Group. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTRGInstreamAdCompanionBanner : NSObject

@property(nonatomic) NSUInteger width;
@property(nonatomic) NSUInteger height;
@property(nonatomic) NSUInteger assetWidth;
@property(nonatomic) NSUInteger assetHeight;
@property(nonatomic) NSUInteger expandedWidth;
@property(nonatomic) NSUInteger expandedHeight;

@property(nonatomic, copy, nullable) NSString *staticResource;
@property(nonatomic, copy, nullable) NSString *iframeResource;
@property(nonatomic, copy, nullable) NSString *htmlResource;
@property(nonatomic, copy, nullable) NSString *apiFramework;
@property(nonatomic, copy, nullable) NSString *adSlotID;
@property(nonatomic, copy, nullable) NSString *required;

@end

NS_ASSUME_NONNULL_END
