//
//  MTRGTracer.h
//  myTargetSDK 4.6.22
//
// Created by Timur on 5/23/16.
// Copyright (c) 2016 Mail.ru. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTRGTracer : NSObject

+ (BOOL)enabled;

+ (void)setEnabled:(BOOL)enabled;

@end

extern void mtrg_tracer_i(NSString *, ...);

extern void mtrg_tracer_d(NSString *, ...);

extern void mtrg_tracer_e(NSString *, ...);

NS_ASSUME_NONNULL_END
