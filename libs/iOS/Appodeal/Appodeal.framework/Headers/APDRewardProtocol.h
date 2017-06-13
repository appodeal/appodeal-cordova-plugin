//
//  APDRewardProtocol.h
//  Appodeal
//
//  AppodealSDK version 2.0.0-All
//
//  Copyright © 2017 Appodeal, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 *  Declaration of appodeal reward protocol object
 */
@protocol APDReward <NSObject>

/*!
 *  App currency name. For example @"Coins", @"Stars"
 */
@property (copy,   nonatomic, readonly) NSString *currencyName;

/*!
 *  App currency amount
 */
@property (assign, nonatomic, readonly) NSUInteger amount;

@end
