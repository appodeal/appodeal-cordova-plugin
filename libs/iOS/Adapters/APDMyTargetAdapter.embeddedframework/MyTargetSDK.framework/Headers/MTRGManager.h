//
//  MTRGManager.h
//  myTargetSDK 4.6.22
//
//  Created by Anton Bulankin on 18.09.15.
//  Copyright © 2015 Mail.ru. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTRGManager : NSObject

+ (NSDictionary *)getFingerprintParams;
+ (void)trackUrl:(NSString *)trackingUrl;

@end

NS_ASSUME_NONNULL_END
