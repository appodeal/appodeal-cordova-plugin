//
//  APDNativeAdQueue.h
//  Appodeal
//
//  AppodealSDK version 2.0.0-All
//
//  Copyright © 2017 Appodeal, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Appodeal/APDNativeAd.h>
#import <Appodeal/APDDefines.h>


@class APDNativeAdQueue;


@protocol APDNativeAdQueueDelegate <NSObject>

@optional

- (void)adQueueAdIsAvailable:(APDNativeAdQueue *)adQueue ofCount:(NSInteger)count;

- (void)adQueue:(APDNativeAdQueue *)adQueue failedWithError:(NSError *)error;

@end


@interface APDNativeAdQueue : NSObject

@property (nonatomic, weak) id<APDNativeAdQueueDelegate> delegate;
@property (nonatomic, readonly, assign) NSInteger currentAdCount;

- (void)setMaxAdSize:(NSInteger)adSize;

- (void)loadAdOfType:(APDNativeAdType)type;

- (NSArray <__kindof APDNativeAd *> *)getNativeAdsOfCount:(NSInteger)count;


@end
