//
//  STAAbstractAd.h
//  StartAppAdSDK
//
//  Copyright (c) 2013 StartApp. All rights reserved.
//  SDK version 3.5.1

#import <Foundation/Foundation.h>

//Show ad failure reasons:
#define FAIL_REASON_NO_INTERNET                             @"No internet connection."
#define FAIL_REASON_AD_RULES                                @"Ad Rules"
#define FAIL_REASON_AD_ALREADY_DISPLAYED                    @"An ad is already displayed"
#define FAIL_REASON_AD_NOT_READY                            @"Ad is not loaded"
#define FAIL_REASON_INTERNAL_ERROR                          @"Internal error"


@class STAAbstractAd; // << Forward declaration
@protocol STADelegateProtocol <NSObject>
@optional

- (void) didLoadAd:(STAAbstractAd*)ad;
- (void) failedLoadAd:(STAAbstractAd*)ad withError:(NSError *)error;
- (void) didShowAd:(STAAbstractAd*)ad;
- (void) failedShowAd:(STAAbstractAd*)ad withError:(NSError *)error;
- (void) didCloseAd:(STAAbstractAd*)ad;
- (void) didClickAd:(STAAbstractAd*)ad;
- (void) didCloseInAppStore:(STAAbstractAd*)ad;
- (void) didCompleteVideo:(STAAbstractAd*)ad;

@end

@interface STAAbstractAd : NSObject

- (BOOL) isReady;

@end
